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
	"github.com/vynjo/circonus-hashi-ui-bits/lib"
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
	ID                string `json:"ID"`
	ParentID          string `json:"ParentID"`
	Name              string `json:"Name"`
	Type              string `json:"Type"`
	Status            string `json:"Status"`
	StatusDescription string `json:"StatusDescription"`
	CreateIndex       int    `json:"CreateIndex"`
	ModifyIndex       int    `json:"ModifyIndex"`
	JobModifyIndex    int    `json:"JobModifyIndex"`
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
	if !strings.Contains(reqURL, "jobs") {
		reqURL += "jobs"
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

func setup() *api.Config {
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

	if nomadAPIURL == "" {
		nomadAPIURL = os.Getenv("NOMAD_API_URL")
// 		log.Printf("URL before = %v\n", nomadAPIURL)

		if nomadAPIURL == "" {
			nomadAPIURL = "http://localhost:4646/v1/jobs"
		} else {
			if strings.Contains(nomadAPIURL, "allocations") {
				nomadAPIURL = strings.Replace(nomadAPIURL, "allocations", "jobs", 1)
			}
		}
	}
// 	log.Printf("URL after = %v\n", nomadAPIURL)
	nomadURL, err = url.Parse(nomadAPIURL)
	if err != nil {
		log.Printf("ERROR: parsing Nomad API URL %+v\n", err)
		os.Exit(1)
	}

	return cfg
}

func processAllocation(capi *api.API, query, title, tags string) {
	Continue := 1

	cluster := &lib.Cluster{
		Name: title,
		Queries: []lib.Querylist{
			{query, "average"},
		},
		Tags: tags,
	}

	clusterReturn, err := lib.CreateCluster(capi, cluster)
	if err != nil {
		if strings.Contains(err.Error(), "unique") {
			Continue = 0
		} else {
			log.Printf("ERROR: creating metric cluster %v\n", err)
			os.Exit(1)
		}
	}
	if Continue == 1 {
		fmt.Printf("Cluster Created: %v\n", clusterReturn.Cid)

		caqlCheck, err := lib.CreateCAQLCheckForCluster(capi, query, title, tags)
		if err != nil {
			log.Printf("ERROR: creating caql check %v\n", err)
			os.Exit(1)
		}

		fmt.Printf("Cluster to Merged Histogram CAQL Check Created: %v\n", caqlCheck.Cid)

		clusterGraph, err := lib.MakeGraphFromCluster(capi, clusterReturn)
		if err != nil {
			log.Printf("ERROR: creating metric cluster graph%v\n", err)
			os.Exit(1)
		}
		fmt.Printf("Cluster Graph Created: %v\n", clusterGraph.Cid)
		caqlgraph, err := lib.CreateCAQLGraph(capi, caqlCheck)
		if err != nil {
			log.Printf("ERROR: Creating CAQL Graph: %v, Error:%v\n", caqlgraph, err)
			os.Exit(1)
		}
		fmt.Printf("Cluster to Merged Histogram Graph Created: %v\n", caqlgraph.Cid)
	}
}

func main() {
	cfg := setup()

	circapi, err := api.NewAPI(cfg)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n", err)
		os.Exit(1)
	}

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
		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*system",
			"Nomad Job "+job.Name+" cpu system",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*throttled_periods",
			"Nomad Job "+job.Name+" cpu throttled_periods",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*throttled_time",
			"Nomad Job "+job.Name+" cpu throttled_time",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*total_percent",
			"Nomad Job "+job.Name+" cpu total_percent",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*total_ticks",
			"Nomad Job "+job.Name+" cpu total_ticks",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*cpu*user",
			"Nomad Job "+job.Name+" cpu user",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*cache",
			"Nomad Job "+job.Name+" memory cache",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*kernel_max_usage",
			"Nomad Job "+job.Name+" memory kernel_max_usage",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*kernel_usage",
			"Nomad Job "+job.Name+" memory kernel_usage",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*max_usage",
			"Nomad Job "+job.Name+" memory max_usage",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*rss",
			"Nomad Job "+job.Name+" memory rss",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)

		processAllocation(circapi,
			"nomad*client*allocs*"+job.Name+"*memory*swap",
			"Nomad Job "+job.Name+" memory swap",
			"creator:api,role:allocation,service:nomad,data-type:guage,group:primary"+"allocation:"+job.Name)
	}
}
