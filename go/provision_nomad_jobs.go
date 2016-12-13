package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"strings"

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

type NomadJob struct {
	ID 					string 		`json:"ID"`
	ParentID 			string		`json:"ParentID"`
	Name 				string		`json:"Name"`
	Type 				string		`json:"Type"`
	Status 				string 		`json:"Status"`
	StatusDescription 	string 		`json:"StatusDescription"`
	CreateIndex 		int 		`json:"CreateIndex"`
	ModifyIndex 		int 		`json:"ModifyIndex"`
	JobModifyIndex 		int 		`json:"JobModifyIndex"`
}

// type metricSearchResult struct {
// 	CheckBundleID string   `json:"_check_bundle"`
// 	Name          string   `json:"_metric_name"`
// 	Type          string   `json:"_metric_type"`
// 	Tags          []string `json:"tags"`
// 	Units         string   `json:"units"`
// }

// type checkBundleMetric struct {
// 	Name   string   `json:"name"`
// 	Status string   `json:"status"`
// 	Tags   []string `json:"tags"`
// 	Type   string   `json:"type"`
// 	Units  string   `json:"units"`
// 	Result string   `json:"result,omitempty"`
// }

// type checkBundleMetricList struct {
// 	Metrics []checkBundleMetric `json:"metrics"`
// }
// 
// type checkBundleMetricResult struct {
// 	CID     string              `json:"_cid"`
// 	Metrics []checkBundleMetric `json:"metrics"`
// }

func getJobs() ([]NomadJob, error) {

	reqURL := nomadURL.String()
	if !strings.Contains(reqURL, "v1/jobs") {
		reqURL += "v1/jobs"
	}
	log.Printf("URL = %v\n", reqURL)

	res, err := http.Get(reqURL)
	if err != nil {
		return nil, err
	}

	defer res.Body.Close()
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, err
	}

	nomadjobs := []NomadJob{}

	err = json.Unmarshal(body, &nomadjobs)
	if err != nil {
		return nil, err
	}

	return nomadjobs, nil
}

var (
	nomadURL *url.URL
)

func setup() {
	var err error
	var apiKey string
	var apiApp string
	var apiURL string
	var nomadAPIURL string
	var debug bool

	flag.StringVar(&apiKey, "key", "", "Circonus API Token Key [none] (CIRCONUS_API_KEY)")
	flag.StringVar(&apiApp, "app", "", "Circonus API Token App [nomad-metric-reaper] (CIRCONUS_API_APP)")
	flag.StringVar(&apiURL, "apiurl", "", "Base Circonus API URL [https://api.circonus.com/] (CIRCONUS_API_URL)")
	flag.StringVar(&nomadAPIURL, "nomadurl", "", "Base Nomad API URL [http://localhost:4646/] (NOMAD_API_URL)")
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
		apiApp := os.Getenv("CIRCONUS_API_APP")
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

	if nomadAPIURL == "" {
		nomadAPIURL = os.Getenv("NOMAD_API_URL")
		if nomadAPIURL == "" {
			nomadAPIURL = "http://localhost:4646/v1/jobs"
		} else {
			if !strings.Contains(nomadAPIURL, "jobs") {
				nomadAPIURL += "jobs"
			} else if strings.Contains(nomadAPIURL, "allocations") {
				lastBin := strings.LastIndex( nomadAPIURL, "allocations" )
				nomadAPIURL = nomadAPIURL[0:lastBin]
				nomadAPIURL += "jobs"
			}
		}
	}	
	nomadURL, err = url.Parse(nomadAPIURL)
	if err != nil {
		log.Printf("ERROR: parsing Nomad API URL %+v\n", err)
		os.Exit(1)
	}
}

func processAllocation() {
	Continue := 1
// 	AlreadyProcessed := "The value you supplied must be unique"
	clusterReturn, err := makeCluster()
	if err != nil {
		if strings.Contains(err.Error(), "unique") {
			Continue = 0;			
		} else {
			log.Printf("ERROR: creating metric cluster %v\n", err)
			os.Exit(1)
		}
	}
	if Continue == 1 {
		fmt.Printf("Cluster Created: %v\n", clusterReturn.Cid)
	
		caqlCheck, err := createCaqlCheckForCluster()
		if err != nil {
			log.Printf("ERROR: creating caql check %v\n", err)
			os.Exit(1)
		}
		
		fmt.Printf("Cluster to Merged Histogram CAQL Check Created: %v\n", caqlCheck.Cid)
	// 	fmt.Printf("Total Returned to main: %v\n", caqlCheck)
		
		clusterGraph, err := makeGraphfromCluster(clusterReturn)
		if err != nil {
			log.Printf("ERROR: creating metric cluster graph%v\n", err)
			os.Exit(1)
		}
		fmt.Printf("Cluster Graph Created: %v\n", clusterGraph.Cid)
		caqlgraph, err := CreateCaqlGraph(caqlCheck)
		if err != nil {
			log.Printf("ERROR: Creating CAQL Graph: %v, Error:%v\n", caqlgraph, err)
			os.Exit(1)
		}
		fmt.Printf("Cluster to Merged Histogram Graph Created: %v\n", caqlgraph.Cid)
	}
}

func main() {

	setup()

	log.Println("Retrieving jobs from Nomad")

	nomadjobs, err := getJobs()
	if err != nil {
		log.Printf("ERROR: retrieving jobs %v\n", err)
		os.Exit(1)
	}

	if len(nomadjobs) == 0 {
		log.Println("No jobs found, exiting.")
		os.Exit(0)
	}

	for _, job := range nomadjobs {
		log.Printf("Processing job %s with status -  %s  (%s:%s)\n", job.Name, job.Status, job.Type, job.ID)
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*system" 
		titleString = "Nomad Job " + job.Name + " cpu system" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*throttled_periods"
		titleString = "Nomad Job " + job.Name + " cpu throttled_periods" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*throttled_time" 
		titleString = "Nomad Job " + job.Name + " cpu throttled_time" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*total_percent" 
		titleString = "Nomad Job " + job.Name + " cpu total_percent" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*total_ticks" 
		titleString = "Nomad Job " + job.Name + " cpu total_ticks" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*cpu*user" 
		titleString = "Nomad Job " + job.Name + " cpu user" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*cache" 
		titleString = "Nomad Job " + job.Name + " memory cache" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*kernel_max_usage" 
		titleString = "Nomad Job " + job.Name + " memory kernel_max_usage" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*kernel_usage" 
		titleString = "Nomad Job " + job.Name + " memory kernel_usage" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*max_usage" 
		titleString = "Nomad Job " + job.Name + " memory max_usage" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*rss" 
		titleString = "Nomad Job " + job.Name + " memory rss" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()
		queryString = "nomad*client*allocs*" + job.Name + "*memory*swap" 
		titleString = "Nomad Job " + job.Name + " memory swap" 
		tagString = "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
		processAllocation()

	}
}

