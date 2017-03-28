package main

import (
	"encoding/json"
	"flag"
	"fmt"
	// 	"io/ioutil"
	"log"
	// 	"net/http"
	// 	"net/url"
	"os"
	// 	"strings"

	"github.com/circonus-labs/circonus-gometrics/api"
	"github.com/vynjo/circonus-hashi-ui-bits/lib"
)

type checkBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

var (
	circapi     *api.API
	queryString string
	titleString string
	tagString   string
)

func makeCluster() (lib.MetricCluster, error) {
	var clusterReturn lib.MetricCluster

	cluster := lib.Cluster{
		Name: titleString,
		Queries: []lib.Querylist{
			{queryString, "average"},
		},
		Tags: tagString,
	}
	// 	fmt.Println("ORIGINAL Cluster:", cluster)

	reqPath := "/metric_cluster"

	clusterJSON, err := json.Marshal(cluster)
	if err != nil {
		return clusterReturn, err
	}

	log.Printf("%v", string(clusterJSON))

	response, err := circapi.Post(reqPath, clusterJSON)
	if err != nil {
		return clusterReturn, err
	}

	err = json.Unmarshal(response, &clusterReturn)
	if err != nil {
		return clusterReturn, err
	}
	// 	log.Printf("clusterReturn: %s\n", clusterReturn)
	log.Printf("Created Cluster: %s\n", response)

	return clusterReturn, nil
}

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
	flag.StringVar(&titleString, "title", "", "The name of the Culster, and Graph [none]")
	flag.StringVar(&tagString, "tags", "", "Tags to include [none]")
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

	if titleString == "" {
		log.Printf("Must Title String %+v\n", err)
		os.Exit(1)
	}
}

func main() {
	setup()

	clusterReturn, err := makeCluster()
	if err != nil {
		log.Printf("ERROR: creating metric cluster %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("Cluster Returned to main: %v\n", clusterReturn.Cid)
	log.Printf("Cluster complete")
}
