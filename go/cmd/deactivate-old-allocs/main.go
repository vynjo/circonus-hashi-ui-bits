package main

import (
	"encoding/json"
	// "flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	// "net/url"
	"os"
	"strings"
	"github.com/vynjo/circonus-hashi-ui-bits/lib"
	// "github.com/circonus-labs/circonus-gometrics/api"
)

func getAllocations() ([]lib.Allocation, error) {
	reqURL := lib.NomadURL.String()
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

	allocations := []lib.Allocation{}

	err = json.Unmarshal(body, &allocations)
	if err != nil {
		return nil, err
	}

	return allocations, nil
}

func getRunningAllocations() ([]lib.Allocation, error) {
	allocations, err := getAllocations()
	if err != nil {
		return nil, err
	}

	running := []lib.Allocation{}

	for _, allocation := range allocations {
		if allocation.ClientStatus == "running" {
			running = append(running, allocation)
		}
	}

	return running, nil
}

func getAllocationMetrics(id string) ([]lib.metricSearchResult, error) {

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
		log.Printf("\tmetric: %s, status: %s, result: %s\n", metric.Name, metric.Status, metric.Result)
	}

	log.Println("---")

	return nil
}

func updateMetrics(allocation lib.Allocation) error {

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
	metrics := []lib.checkBundleMetric{}

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

func main() {

	setup()

	log.Println("Retrieving Running allocations from Nomad")

	runningAllocations, err := getRunningAllocations()
	if err != nil {
		log.Printf("ERROR: retrieving allocations %v\n", err)
		os.Exit(1)
	}

	if len(runningAllocations) == 0 {
		log.Println("No running allocations found.")
	} else {
		log.Printf("Allocations found:\n%v\n", runningAllocations)
		for _, allocation := range runningAllocations {
			log.Printf("Processing Running allocation %s on %s (%s:%s)\n", allocation.JobID, allocation.NodeID, allocation.Name, allocation.ID)
			// 			err := updateMetrics(allocation)
			// 			if err != nil {
			// 				log.Printf("ERROR: %+v", err)
			// 				os.Exit(1)
			// 			}
		}
	}
	log.Printf("\tchecking for active metrics\n")

	allocationMetrics, err := getAllocationMetrics("allocs")
	if err != nil {
		log.Printf("ERROR: finding allocations %v\n", err)
		os.Exit(1)
	}
	for _, metric := range allocationMetrics {
		log.Printf("Allocation found: %s\n", metric.Name)
	}

	// 	if len(allocationMetrics) == 0 {
	// 		log.Printf("\t0 active metrics, skipping\n")
	// 	}

	log.Printf("\t Found %d active metrics:\n", len(allocationMetrics))

	// 	lostAllocations, err := getLostAllocations()
	// 	if err != nil {
	// 		log.Printf("ERROR: retrieving allocations %v\n", err)
	// 		os.Exit(1)
	// 	}
	//
	// 	if len(lostAllocations) == 0 {
	// 		log.Println("No lost allocations found, exiting.")
	// 		os.Exit(0)
	// 	}
	//
	// 	for _, allocation := range lostAllocations {
	// 		log.Printf("Processing LOST allocation %s on %s (%s:%s)\n", allocation.JobID, allocation.NodeID, allocation.Name, allocation.ID)
	// 		err := updateMetrics(allocation)
	// 		if err != nil {
	// 			log.Printf("ERROR: %+v", err)
	// 			os.Exit(1)
	// 		}
	// 	}

}
