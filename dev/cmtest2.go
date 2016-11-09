package main

import (
	// "bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"
	// "time"

	"github.com/circonus-labs/circonus-gometrics/api"
)

// Allocation is a struct containing state of a nomad allocation
type Allocation struct {
	// ID of the allocation (UUID)
	ID string
	// Name is a logical name of the allocation.
	Name string
	// NodeID is the node this is being placed on
	NodeID string
	// JobID is the parent job of the task group being allocated.
	// This is copied at allocation time to avoid issues if the job
	// definition is updated.
	JobID string
	// ClientStatus of the allocation on the client
	ClientStatus string
}

type metricSearchResult struct {
	CheckBundleID string   `json:"_check_bundle"`
	Name          string   `json:"_metric_name"`
	Type          string   `json:"_metric_type"`
	Tags          []string `json:"tags"`
	Units         string   `json:"units"`
}

type checkBundleMetricList struct {
	Metrics []checkBundleMetric `json:"metrics"`
}

type checkBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

type checkBundleMetricResult struct {
	CID     string              `json:"_cid"`
	Metrics []checkBundleMetric `json:"metrics"`
}

func getAllocations() ([]Allocation, error) {
	reqURL := nomadURL.String()
	if !strings.Contains(reqURL, "v1/allocations") {
		reqURL += "v1/allocations"
	}

	res, err := http.Get(reqURL)
	if err != nil {
		return nil, err
	}

	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, err
	}

	allocations := []Allocation{}

	err = json.Unmarshal(body, &allocations)
	if err != nil {
		return nil, err
	}

	return allocations, nil
}

func getCompletedAllocations() ([]Allocation, error) {
	allocations, err := getAllocations()
	if err != nil {
		return nil, err
	}

	completed := []Allocation{}

	for _, allocation := range allocations {
		if allocation.ClientStatus == "complete" {
			completed = append(completed, allocation)
		}
	}

	return completed, nil
}

func getAllocationMetrics(id string) ([]metricSearchResult, error) {

	metricSearchURL := fmt.Sprintf("/metric?search=(active:1)*%s*", id)

	metricsJSON, err := circapi.Get(metricSearchURL)
	if err != nil {
		return nil, err
	}

	metrics := []metricSearchResult{}

	err = json.Unmarshal(metricsJSON, &metrics)
	if err != nil {
		return nil, err
	}

	return metrics, nil
}

func deactivateMetrics(checkBundleID string, metricList checkBundleMetricList) error {
	reqPath := fmt.Sprintf("/check_bundle_metrics/%s", checkBundleID)

	metricsJSON, err := json.Marshal(metricList)
	if err != nil {
		return err
	}

	response, err := circapi.Put(reqPath, metricsJSON)
	if err != nil {
		return err
	}

	result := checkBundleMetricResult{}
	err = json.Unmarshal(response, &result)
	if err != nil {
		return err
	}

	for _, metric := range result.Metrics {
		log.Printf("\tmetric: %s, status: %s\n", metric.Name, metric.Result)
	}

	log.Println("---")

	return nil
}

func updateMetrics(allocation Allocation) error {

	log.Printf("\tchecking for active metrics\n")

	allocationMetrics, err := getAllocationMetrics(allocation.ID)
	if err != nil {
		return err
	}

	if len(allocationMetrics) == 0 {
		log.Printf("\t0 active metrics, skipping\n")
		return nil
	}

	log.Printf("\tdeactivating %d active metrics\n", len(allocationMetrics))

	checkBundleID := ""
	metrics := []checkBundleMetric{}

	for _, metric := range allocationMetrics {
		if checkBundleID == "" {
			checkBundleID = strings.Replace(metric.CheckBundleID, "/check_bundle/", "", -1)
		}
		metrics = append(metrics, checkBundleMetric{
			Name:   metric.Name,
			Status: "available",
			Tags:   metric.Tags,
			Type:   metric.Type,
			Units:  metric.Units,
		})
	}

	metricList := checkBundleMetricList{metrics}

	err = deactivateMetrics(checkBundleID, metricList)
	if err != nil {
		return err
	}

	return nil
}

var (
	circapi  *api.API
	nomadURL *url.URL
)

func init() {
	var err error

	cfg := &api.Config{}

	apiKey := os.Getenv("CIRCONUS_API_TOKEN")
	if apiKey == "" {
		log.Printf("CIRCONUS_API_TOKEN is not set, exiting.\n")
		os.Exit(1)
	}
	cfg.TokenKey = apiKey

	apiApp := os.Getenv("CIRCONUS_API_APP")
	if apiApp != "" {
		cfg.TokenApp = apiApp
	} else {
		cfg.TokenApp = "nomad-metric-deactivator"
	}

	apiURL := os.Getenv("CIRCONUS_API_URL")
	if apiURL != "" {
		cfg.URL = apiURL
	}

	// just so we can get some debug output (delete or set to false to stop debug messages)
	//cfg.Debug = true

	circapi, err = api.NewAPI(cfg)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n", err)
		os.Exit(1)
	}

	nomadurl := os.Getenv("NOMAD_URL")
	if nomadurl == "" {
		log.Printf("ERROR: NOMAD_URL not set, exiting.\n")
		os.Exit(1)
	}

	nomadURL, err = url.Parse(nomadurl)
	if err != nil {
		log.Printf("ERROR: parsing NOMAD_URL %+v\n", err)
		os.Exit(1)
	}

}

func main() {

	log.Println("Retrieving completed allocations from Nomad")

	completedAllocations, err := getCompletedAllocations()
	if err != nil {
		log.Printf("ERROR: retrieving allocations %v\n", err)
		os.Exit(1)
	}

	if len(completedAllocations) == 0 {
		log.Println("No completed allocations found, exiting.")
		os.Exit(0)
	}

	for _, allocation := range completedAllocations {
		log.Printf("Processing allocation %s on %s (%s:%s)\n", allocation.JobID, allocation.NodeID, allocation.Name, allocation.ID)
		err := updateMetrics(allocation)
		if err != nil {
			log.Printf("ERROR: %+v", err)
			os.Exit(1)
		}
	}
}
