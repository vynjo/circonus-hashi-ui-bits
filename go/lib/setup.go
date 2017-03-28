package lib

import (
	"flag"
	"log"
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

type CetricSearchResult struct {
	CheckBundleID string   `json:"_check_bundle"`
	Name          string   `json:"_metric_name"`
	Type          string   `json:"_metric_type"`
	Tags          []string `json:"tags"`
	Units         string   `json:"units"`
}

type CheckBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

type CheckBundleMetricList struct {
	Metrics []checkBundleMetric `json:"metrics"`
}

type CheckBundleMetricResult struct {
	CID     string              `json:"_cid"`
	Metrics []checkBundleMetric `json:"metrics"`
}

var (
	NomadURL *url.URL
	circapi  *api.API
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
	NomadURL, err = url.Parse(nomadAPIURL)
	if err != nil {
		log.Printf("ERROR: parsing Nomad API URL %+v\n", err)
		os.Exit(1)
	}

	return cfg
}
