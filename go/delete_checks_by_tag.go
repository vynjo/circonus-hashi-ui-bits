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
	// 	"strconv"

	"github.com/circonus-labs/circonus-gometrics/api"
)

type checkBundleMetric struct {
	Name   string   `json:"name"`
	Status string   `json:"status"`
	Tags   []string `json:"tags"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Result string   `json:"result,omitempty"`
}

type Querylist struct {
	Query string `json:"query"`
	Typep string `json:"type"`
}

type metricCluster struct {
	Name        string      `json:"name"`
	Cid         string      `json:"_cid"`
	Queries     []Querylist `json:"queries"`
	Description string      `json:"description"`
	Tags        []string    `json:"tags"`
}

type ClusterDef struct {
	Name    string      `json:"name"`
	Queries []Querylist `json:"queries"`
	Tags    string      `json:"tags"`
}

type Graph struct {
	Cid string `json:"_cid"`
	// 	AccessKeys        []interface{} `json:"access_keys"`
	// 	Composites        []interface{} `json:"composites"`
	// 	Datapoints        []DataPoint	`json:"datapoints"`
	// 	Description       string        `json:"description"`
	// 	Guides            []interface{} `json:"guides"`
	// 	LineStyle         interface{}   `json:"line_style"`
	// 	LogarithmicLeftY  interface{}   `json:"logarithmic_left_y"`
	// 	LogarithmicRightY interface{}   `json:"logarithmic_right_y"`
	// 	MaxLeftY          interface{}   `json:"max_left_y"`
	// 	MaxRightY         interface{}   `json:"max_right_y"`
	// 	MetricClusters    []interface{} `json:"metric_clusters"`
	// 	MinLeftY          interface{}   `json:"min_left_y"`
	// 	MinRightY         interface{}   `json:"min_right_y"`
	// 	Notes             interface{}   `json:"notes"`
	// 	Style             interface{}   `json:"style"`
	// 	Tags              []interface{} `json:"tags"`
	Title string `json:"title"`
}

type DataPoint struct {
	Alpha         string      `json:"alpha"`
	Axis          string      `json:"axis"`
	Caql          string      `json:"caql"`
	CheckID       string      `json:"check_id"`
	Color         string      `json:"color"`
	DataFormula   string      `json:"data_formula"`
	Derive        bool        `json:"derive"`
	Hidden        bool        `json:"hidden"`
	LegendFormula string      `json:"legend_formula"`
	MetricName    string      `json:"metric_name"`
	MetricType    string      `json:"metric_type"`
	Name          string      `json:"name"`
	Stack         interface{} `json:"stack"`
}

// Need to build out rest of structure so datapoints can be added later

type graphMetricClusters struct {
	LegendFormula     string `json:"legend_formula"`
	Stack             int    `json:"stack"`
	Name              string `json:"name"`
	AggregateFunction string `json:"aggregate_function"`
	MetricCluster     string `json:"metric_cluster"`
	Axis              string `json:"axis"`
	DataFormula       string `json:"data_formula"`
	Hidden            bool   `json:"hidden"`
}

type clusterGraph struct {
	Description    string                `json:"description"`
	MetricClusters []graphMetricClusters `json:"metric_clusters"`
	Tags           []string              `json:"tags"`
	Title          string                `json:"title"`
	Cid            string                `json:"_cid"`
	Style          string                `json:"style"`
	Datapoints     []DataPoint           `json:"datapoints"`
}

var (
	circapi     *api.API
	queryString string
	titleString string
	tagString   string
)

type caqlConfig struct {
	Query            string `json:"query"`
	ReverseSecretKey string `json:"reverse:secret_key"`
	Name             string `json:"name"`
}
type caqlMetrics struct {
	Status string   `json:"status"`
	Name   string   `json:"name"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Tags   []string `json:"tags"`
}

type getCheck struct {
	ReverseConnectionUrls string `json:"_reverse_url"`
	Broker                string `json:"_broker"`
	Active                bool   `json:"_active"`
	CheckUuid             string `json:"_check_uuid"`
	Bundle                string `json:"_check_bundle"`
	Cid                   string `json:"_cid"`
	// 	Details 				[]string		`json:"_details"`
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
	flag.StringVar(&tagString, "tags", "", "Tags to include")
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

	if tagString == "" {
		log.Printf("Must provide tag list.\n")
		os.Exit(1)

	}
	cfg.URL = apiURL

	cfg.Debug = debug

	circapi, err = api.NewAPI(cfg)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n", err)
		os.Exit(1)
	}
}

func deleteChecks(Checks []getCheck) error {

	for _, check := range Checks {
		fmt.Printf("Deleting: %v\n", check.Bundle)
		response, err := circapi.Delete(check.Bundle)
		if err != nil {
			log.Printf("Error Deleting Check %v: %v, with Response: %v\n", check.Bundle, err, response)
			os.Exit(1)
		}
		// 		log.Printf("Response: %v\n", response)
	}

	return nil
}

func getChecksViaTag(tag string) ([]getCheck, error) {

	SearchURL := fmt.Sprintf("check?search=(tags:%s)&size=100", tag)

	// 	metricSearchURL = "graph?search='(tags:creator:api)'"
	fmt.Printf("URL: %v\n", SearchURL)
	checkJSON, err := circapi.Get(SearchURL)
	if err != nil {
		return nil, err
	}

	checks := []getCheck{}

	err = json.Unmarshal(checkJSON, &checks)
	if err != nil {
		return nil, err
	}
	// 	fmt.Printf("Checks: %v\n", checks)
	return checks, nil
}

func main() {

	setup()

	check_json, err := getChecksViaTag(tagString)

	if err != nil {
		log.Printf("ERROR: Finding Checks %v\n", err)
		os.Exit(1)
	}

	err = deleteChecks(check_json)
	if err != nil {
		log.Printf("Error Deleting Checks", err)
		os.Exit(1)
	}

	// 	fmt.Printf("Clusters Returned: %v\n", cluster_json)
	fmt.Printf("Done\n")

}
