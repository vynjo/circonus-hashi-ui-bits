package main

import (
	"encoding/json"
	"flag"
	"net/url"
	"strings"
	// "flag"
	"fmt"
	// "io/ioutil"
	"log"
	// "net/http"
	// "net/url"
	"os"

	"github.com/circonus-labs/circonus-gometrics/api"
	// "github.com/vynjo/circonus-hashi-ui-bits/lib"
)

// MetricSearchResult returns list of metrics
type metricSearchResult struct {
	CheckBundleID string   `json:"_check_bundle"`
	Name          string   `json:"_metric_name"`
	Type          string   `json:"_metric_type"`
	Status        string   `json:"status"`
	Tags          []string `json:"tags"`
	Units         string   `json:"units"`
}

// checkBundleMetric returns a check bundle
type checkBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

// checkBundleMetricList returns a check bundle list
type checkBundleMetricList struct {
	Metrics []checkBundleMetric `json:"metrics"`
}

// checkBundleMetricResult returns a check bundle list
type checkBundleMetricResult struct {
	CID     string              `json:"_cid"`
	Metrics []checkBundleMetric `json:"metrics"`
}

var (
	circapi     *api.API
	queryString string
)

func setup() {
	var err error
	var apiKey string
	var apiApp string
	var apiURL string

	var debug bool

	flag.StringVar(&apiKey, "key", "", "Circonus API Token Key [none] (CIRCONUS_API_KEY)")
	flag.StringVar(&apiApp, "app", "", "Circonus API Token App [nomad-metric-reaper] (CIRCONUS_API_APP)")
	flag.StringVar(&apiURL, "apiurl", "", "Base Circonus API URL [https://api.circonus.com/] (CIRCONUS_API_URL)")
	flag.StringVar(&queryString, "query", "", "The Query used to search [none]")
	flag.BoolVar(&debug, "debug", false, "Enable Circonus API debugging")

	flag.Parse()

	cfg := &api.Config{}

	if apiKey == "" {
		apiKey = os.Getenv("CIRCONUS_API_KEY")
		if apiKey == "" {
			log.Printf("CIRCONUS_API_KEY is not set, exiting.\n")
			os.Exit(1)
		}
	}
	cfg.TokenKey = apiKey

	if apiApp == "" {
		apiApp = os.Getenv("CIRCONUS_API_APP")
		if apiApp == "" {
			apiApp = "nomad-metrics-reaper"
		}
	}
	cfg.TokenApp = apiApp

	if apiURL == "" {
		apiURL = os.Getenv("CIRCONUS_API_URL")
		if apiURL == "" {
			apiURL = "https://api.circonus.com/"
		}
	}

	cfg.URL = apiURL

	cfg.Debug = debug

	circapi, err = api.NewAPI(cfg)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n", err)
		os.Exit(1)
	}

	if queryString == "" {
		log.Printf("Must Include a Query String %+v\n", err)
		os.Exit(1)
	}
}

func findMetrics(id string) ([]metricSearchResult, error) {

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
	q := url.Values{}
	q.Set("search", "(active:1)*%s*")
	apiURL := url.URL{
		Path:     fmt.Sprintf("/check_bundle_metrics/%s", checkBundleID),
		RawQuery: q.Encode(),
	}

	metricsJSON, err := json.Marshal(metricList)
	if err != nil {
		return err
	}

	response, err := circapi.Put(apiURL.String(), metricsJSON)
	if err != nil {
		return err
	}

	result := checkBundleMetricResult{}
	err = json.Unmarshal(response, &result)
	if err != nil {
		return err
	}

	for _, metric := range result.Metrics {
		log.Printf("\tmetric: %s, status: %s, result: %s\n", metric.Name, metric.Status, metric.Result)
	}

	log.Println("---")

	return nil
}

func main() {

	setup()

	checkBundleID := ""

	log.Println("Finding Metrics that match query")

	foundMetrics, err := findMetrics(queryString)
	// log.Printf("Found: finding metrics %v\n", foundMetrics)
	log.Printf("\t Found %d metrics\n", len(foundMetrics))
	if err != nil {
		log.Printf("ERROR: finding metrics %v\n", err)
		os.Exit(1)
	}
	metrics := []checkBundleMetric{}
	for _, metric := range foundMetrics {
		// log.Printf("Metrics found: %s\n", metric.Name)
		// log.Printf("ID: %s\n", metric.CheckBundleID)
		// log.Printf("Processing metric %s \n", metric)
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
	// log.Printf("Processing metric %s \n", metrics)
	if len(foundMetrics) > 0 {
		if err = deactivateMetrics(checkBundleID, metricList); err != nil {
			log.Printf("Error: %+v\n", err)
		}
	}
}
