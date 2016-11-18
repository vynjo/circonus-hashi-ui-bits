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
	"strings"

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
	Query		string	`json:"query"`
	Typep 		string	`json:"type"`
}

type metricCluster struct {
	Name 			string 		`json:"name"`
	Cid 			string 		`json:"_cid"`
	Queries 		[]Querylist	`json:"queries"`
	Description 	string 		`json:"description"`
	Tags 			[]string 	`json:"tags"`
}


type ClusterDef struct {
	Name   		string		`json:"name"`
	Queries		[]Querylist	`json:"queries"`	
	Tags   		[]string		`json:"tags"`
} 

// Need to build out rest of structure so datapoints can be added later
type DatapointsDef struct {
	Alpha		string		`json:"alpha"`
    Axis		string		`json:"axis:"`
    CheckID		int			`json:"check_id"`
//     color: #0000ff,
//     data_formula: null,
//     derive: gauge,
//     hidden: false,
//     legend_formula: null,
//     metric_name: bytes,
//     metric_type: numeric,
//     name: Bytes,
//     stack: null
}
type graphMetricClusters struct {
	LegendFormula 		string 		`json:"legend_formula"`
	Stack 				int			`json:"stack"`
	Name 				string 		`json:"name"`
	AggregateFunction 	string 		`json:"aggregate_function"`
	MetricCluster 		string 		`json:"metric_cluster"`
	Axis 				string 		`json:"axis"`
	DataFormula 		string 		`json:"data_formula"`
	Hidden 				bool 		`json:"hidden"`
}

type clusterGraph struct {
	Description 		string	 				`json:"description"`
	MetricClusters		[]graphMetricClusters 	`json:"metric_clusters"`
	Tags 				[]string 				`json:"tags"`
	Title 				string 					`json:"title"`
	Cid 				string 					`json:"_cid"`
	Style 				string 					`json:"style"`
	Datapoints			[]DatapointsDef			`json:"datapoints"`
}

var (
	circapi  *api.API
	queryString string
	titleString string
	tagString string
)

func makeGraphfromCluster(Cluster metricCluster) (graph clusterGraph, err error) {
	
	graph  = clusterGraph {
		Datapoints: []DatapointsDef{	
		},
		Description: Cluster.Description,
		Title: Cluster.Name,
		MetricClusters: []graphMetricClusters{
			{MetricCluster: Cluster.Cid,
			Name: Cluster.Name,
			Axis: "l",
			AggregateFunction: "none"},
		},
		Tags: Cluster.Tags,
		Style: "line",

	}
// 	log.Printf("Graph CID:", graph)	
 	reqPath := "/graph"
 	graphJSON, err := json.Marshal(graph)
		if err != nil {
		return  graph, err
 	}
//  	fmt.Printf("Graph Definition: %v", string(graphJSON))
	response, err := circapi.Post(reqPath, graphJSON)
	if err != nil {
		return graph, err
	}
	err = json.Unmarshal(response, &graph)
	if err != nil {
		return graph, err
	}
	log.Printf("%v", graph)
	return graph, nil
}

func makeCluster() (metricCluster, error) {

	var clusterReturn metricCluster
	cluster := ClusterDef {
	    Name: titleString,
	    Queries: []Querylist{
		    {queryString, "average"},
	    },
	    Tags: strings.Split(tagString,","),
    }
// 	fmt.Println("ORIGINAL Cluster:", cluster)
 	reqPath := "/metric_cluster"

	clusterJSON, err := json.Marshal(cluster)
		if err != nil {
		return  clusterReturn, err
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
	
	clusterReturn, err := makeCluster()
	if err != nil {
		log.Printf("ERROR: creating metric cluster %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("Cluster Returned to main: %v\n", clusterReturn.Cid)
	clusterGraph, err := makeGraphfromCluster(clusterReturn)
	if err != nil {
		log.Printf("ERROR: creating metric cluster graph%v\n", err)
		os.Exit(1)
	}
	log.Printf("Graph complete:%v", clusterGraph)
}
