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
	"strconv"

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
	Tags   		string		`json:"tags"`
} 

// Need to build out rest of structure so datapoints can be added later
type DatapointsDef struct {
	LegendFormula 	string	`json:"legend_formula"`
	Caql 			string 	`json:"caql"`
	CheckID 		int 	`json:"check_id"`
	MetricType 		string 	`json:"metric_type"`
	Stack 			int 	`json:"stack"`
	Name 			string 	`json:"name"`
	Axis 			string 	`json:"axis"`
	DataFormula 	string	`json:"data_formula"`
	Color 			string 	`json:"color"`
	MetricName 		string 	`json:"metric_name"`
	Alpha 			int 	`json:"alpha"`
	Derive 			string 	`json:"derive"`
	Hidden 			bool 	`json:"hidden"`
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
	queryString 	string
	titleString 	string
	tagString 		string
)

type caqlConfig	struct {
	Query 					string			`json:"query"`
	ReverseSecretKey 		string 			`json:"reverse:secret_key"`
	Name 					string 			`json:"name"`

}
type caqlMetrics struct {
	Status 					string 			`json:"status"`
	Name 					string 			`json:"name"`
	Type 					string 			`json:"type"`
	Units 					string 			`json:"units"`
	Tags 					[]string 		`json:"tags"`
}

type caqlCheck struct {
	CheckUuids 				[]string 		`json:"_check_uuids"`
	Checks 					[]string 		`json:"_checks"`
	Cid 					string 			`json:"_cid"`
	Created 				int 			`json:"_created"`
	LastModified 			int 			`json:"_last_modified"`
	LastModifiedBy 			string 			`json:"_last_modified_by"`
	ReverseConnectionUrls 	[]string 		`json:"_reverse_connection_urls"`
	Brokers 				[]string 		`json:"brokers"`
	Config 					caqlConfig		`json:"config"`
	DisplayName 			string 			`json:"display_name"`
	Metrics 				[]caqlMetrics	`json:"metrics"`
	Notes 					string			`json:"notes"`
	Period 					int 			`json:"period"`
	Status 					string 			`json:"status"`
	Tags					[]string		`json:"tags"`
	Target 					string 			`json:"target"`
	Timeout 				int 			`json:"timeout"`
	Type 					string 			`json:"type"`
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
	
	if tagString == "" {
		tagString = "creator:api"
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
		log.Printf("Must  have title string %+v\n", err)
		os.Exit(1)
	}
}

func createCaqlCheck() (caql_check caqlCheck, err error) {
	
	var caqlReturn caqlCheck
	
	var cluster_type string
	
	if strings.Contains(tagString, "counter") {
		cluster_type = "counter"
	} else if strings.Contains(tagString, "derive") {
		cluster_type = "derivative"
	} else if strings.Contains(tagString, "count") {
		cluster_type = "count"
	} else if strings.Contains(tagString, "text") {
		cluster_type = "text"
	} else {
		cluster_type = "average"
	}
	
	caql_check = caqlCheck {
		DisplayName: 	titleString + " (Histogram)",
		Target: 		"q._caql",
		Period: 		60,
		Status: 		"active",
		Tags: 			strings.Split(tagString,","),
		Timeout: 		10,
		Type: 			"caql",
		Brokers: 		[]string{"/broker/1490"},
		Config:			caqlConfig{
			Query: 		"search:metric:" + cluster_type + "(\"" + queryString + "\") | histogram()",
		},
		Metrics: []caqlMetrics{
			{Status: "active",
			Name:	"output[1]",
			Type: 	"histogram"},
		},
	}
	reqPath := "/check_bundle"

	checkJSON, err := json.Marshal(caql_check)
		if err != nil {
		return  caql_check, err
 	}
//  	log.Printf(" Adding CAQL Check: %v\n", string(checkJSON))
	response, err := circapi.Post(reqPath, checkJSON)
	if err != nil {
		return caql_check, err
	}
// 	log.Printf("%v\n", response)	
	err = json.Unmarshal(response, &caqlReturn)
	if err != nil {
		return caqlReturn, err
	}
// 	log.Printf("Returning Check: %v\n", caqlReturn.Cid)
	return caqlReturn, nil
}

func makeGraphfromCluster(Cluster metricCluster) (graph clusterGraph, err error) {
	
	graph  = clusterGraph {
		Datapoints: []DatapointsDef{	
		},
		Description: Cluster.Description,
		Title: Cluster.Name,
		MetricClusters: []graphMetricClusters{
			{MetricCluster: Cluster.Cid,
			Name: Cluster.Name + " (Cluster)",
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
// 	log.Printf("%v", graph)
	return graph, nil
}



func makeCluster() (metricCluster, error) {

	var cluster_type string
	
	if strings.Contains(tagString, "counter") {
		cluster_type = "counter"
	} else if strings.Contains(tagString, "derive") {
		cluster_type = "derive"
	} else if strings.Contains(tagString, "count") {
		cluster_type = "count"
	} else if strings.Contains(tagString, "text") {
		cluster_type = "text"
	} else {
		cluster_type = "average"
	}
	var clusterReturn metricCluster
	cluster := ClusterDef {
	    Name: titleString,
	    Queries: []Querylist{
		    {queryString, cluster_type},
	    },
	    Tags: tagString,
    }
//  fmt.Printf("TAGS = %v\n", tagString)
// 	fmt.Println("ORIGINAL Cluster:", cluster)
 	reqPath := "/metric_cluster"

	clusterJSON, err := json.Marshal(cluster)
		if err != nil {
		return  clusterReturn, err
 	}
//  log.Printf("%v", string(clusterJSON))
	response, err := circapi.Post(reqPath, clusterJSON)
	if err != nil {
		return clusterReturn, err
	}
	
	err = json.Unmarshal(response, &clusterReturn)
	if err != nil {
		return clusterReturn, err
	}
// 	log.Printf("clusterReturn: %s\n", clusterReturn)
// 	log.Printf("Created Cluster: %s\n", response)
	
	return clusterReturn, nil
}

func addCaqlToGraph (graph clusterGraph, caql caqlCheck) (returnGraph clusterGraph, err error) {
// 	log.Printf("Add Caql to graph\n")
// 	log.Printf("Add: %v\n", caql)
	
	checkJSON, err := json.Marshal(caql)
		if err != nil {
			log.Printf("ERROR: allocating Circonus API %v\n%v\n", err, checkJSON)
		return  graph, err
 	}
//  	fmt.Printf("Add CAQL Definition: %+v\n", string(checkJSON))
 	checknum, _ := strconv.Atoi(strings.Replace(caql.Checks[0], "/check/", "", -1))
 	
//  	fmt.Printf("CID=%v Name= %v", caql.Cid, caql.DisplayName)
//  	fmt.Printf("CheckID= %v\n", checknum)
	datapoint := DatapointsDef {
		CheckID: 		checknum,
		MetricType:		"histogram",
		Name:			caql.DisplayName,
		Axis:			"r",
		MetricName:		caql.Metrics[0].Name,
		Color:			"#2F5DAB",
	}
	graph.Datapoints = append(graph.Datapoints, datapoint)
	
	graphJSON, err := json.Marshal(graph)
		if err != nil {
		return  graph, err
 	}

// 	fmt.Printf("Adding Datapoint: %+v\n", string(graphJSON))
	
	response, err := circapi.Put(graph.Cid, graphJSON)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n%v\n", err, response)
		os.Exit(1)
// 		return graph, err
	}
// 	fmt.Printf("Put Response: %v\n", string(response))
	return graph, err
}

func main() {

	setup()
	
	queryString = queryString + "(active:1)"
	
	if strings.Contains(tagString, "data-type:histogram") {
		log.Printf("Adding Histogram")
	} else {
		clusterReturn, err := makeCluster()
		if err != nil {
			log.Printf("ERROR: creating metric cluster %v\n", err)
			os.Exit(1)
		}
		fmt.Printf("Cluster Created: %v\n", clusterReturn.Cid)
	
		caqlCheck, err := createCaqlCheck()
		if err != nil {
			log.Printf("ERROR: creating caql check %v\n", err)
			os.Exit(1)
		}
		
		fmt.Printf("CAQL Check Created: %v\n", caqlCheck.Cid)
	// 	fmt.Printf("Total Returned to main: %v\n", caqlCheck)
		
		clusterGraph, err := makeGraphfromCluster(clusterReturn)
		if err != nil {
			log.Printf("ERROR: creating metric cluster graph%v\n", err)
			os.Exit(1)
		}
		fmt.Printf("Graph Created: %v\n", clusterGraph.Cid)
		graph, err := addCaqlToGraph(clusterGraph, caqlCheck)
		if err != nil {
			log.Printf("ERROR: adding CAQL to Graph: %v, Error:%v\n", graph, err)
			os.Exit(1)
		}

	}
}
