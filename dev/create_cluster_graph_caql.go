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

	"../../circonus-gometrics/api"
)


type checkBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

func makeCluster(apiKey, apiApp, apiURL, queryString, titleString, tagString) {
	
	fmt.Sprintf("%v", queryString)
// 	var cluster_config = {
// 	    "name": titleString,
// 	    "queries": [
// 			{
// 			"query": queryString,
// 			"type": "average"
// 			
// 			}
// 	    ],
// 	    "tags": tagString
// 	};
// 
// 	reqPath := fmt.Sprintf("/metric_cluster")
// 
// 	metricsJSON, err := json.Marshal(metricList)
// 	if err != nil {
// 		return err
// 	}
// 
// 	response, err := circapi.Put(reqPath, cluster_config)
// 	if err != nil {
// 		return err
// 	}
// 
// 	result := checkBundleMetricResult{}
// 	err = json.Unmarshal(response, &result)
// 	if err != nil {
// 		return err
// 	}
// 
// 	log.Printf("\resulte: %s\n", result)
// 	}
// 
// 	log.Println("---")

	return nil
}


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
	flag.StringVar(&queryString, "query", "", "The Query used to search [none]" )
	flag.StringVar(&titleString, "title", "", "The name of the Culster, and Graph [none]" )
	flag.StringVar(&tagString, "tags", "", "Tags to include [none]" )
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

	if queryString == "" {
		log.Printf("Must Include a Query String %+v\n", err)
		os.Exit(1)
	}
	
	if titleString == "" {
		log.Printf("Must Title String %+v\n", err)
		os.Exit(1)
	}
}

func main() {

	setup()

	metricCluster, err := makeCluster(apiKey, apiApp, apiURL, queryString, titleString, tagString)
	if err != nil {
		log.Printf("ERROR: creating metric cluster %v\n", err)
		os.Exit(1)
	}

// 	if len(completedAllocations) == 0 {
// 		log.Println("No completed allocations found, exiting.")
// 		os.Exit(0)
// 	}
// 
// 	for _, allocation := range completedAllocations {
// 		log.Printf("Processing allocation %s on %s (%s:%s)\n", allocation.JobID, allocation.NodeID, allocation.Name, allocation.ID)
// 		err := updateMetrics(allocation)
// 		if err != nil {
// 			log.Printf("ERROR: %+v", err)
// 			os.Exit(1)
// 		}
// 	}
}
