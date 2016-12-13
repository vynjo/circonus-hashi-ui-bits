package lib

import (
	"encoding/json"
	"strings"

	"github.com/circonus-labs/circonus-gometrics/api"
)

const metricClusterReqPath = "/metric_cluster"

type Cluster struct {
	Name    string      `json:"name"`
	Queries []Querylist `json:"queries"`
	Tags    string      `json:"tags"`
}

type ClusterGraph struct {
	Description    string               `json:"description"`
	MetricClusters []GraphMetricCluster `json:"metric_clusters"`
	Tags           []string             `json:"tags"`
	Title          string               `json:"title"`
	Cid            string               `json:"_cid"`
	Style          string               `json:"style"`
	Datapoints     []Datapoint          `json:"datapoints"`
}

// Need to build out rest of structure so datapoints can be added later
type Datapoint struct {
	LegendFormula string `json:"legend_formula"`
	Caql          string `json:"caql"`
	CheckID       int    `json:"check_id"`
	MetricType    string `json:"metric_type"`
	Stack         int    `json:"stack"`
	Name          string `json:"name"`
	Axis          string `json:"axis"`
	DataFormula   string `json:"data_formula"`
	Color         string `json:"color"`
	MetricName    string `json:"metric_name"`
	Alpha         int    `json:"alpha"`
	Derive        string `json:"derive"`
	Hidden        bool   `json:"hidden"`
}

type GraphMetricCluster struct {
	LegendFormula     string `json:"legend_formula"`
	Stack             int    `json:"stack"`
	Name              string `json:"name"`
	AggregateFunction string `json:"aggregate_function"`
	MetricCluster     string `json:"metric_cluster"`
	Axis              string `json:"axis"`
	DataFormula       string `json:"data_formula"`
	Hidden            bool   `json:"hidden"`
}

type MetricCluster struct {
	Name        string      `json:"name"`
	Cid         string      `json:"_cid"`
	Queries     []Querylist `json:"queries"`
	Description string      `json:"description"`
	Tags        []string    `json:"tags"`
}

type Querylist struct {
	Query string `json:"query"`
	Typep string `json:"type"`
}

func CreateCluster(api *api.API, cluster *Cluster) (MetricCluster, error) {
	var clusterReturn MetricCluster

	clusterJSON, err := json.Marshal(cluster)
	if err != nil {
		return clusterReturn, err
	}

	response, err := api.Post(metricClusterReqPath, clusterJSON)
	if err != nil {
		return clusterReturn, err
	}

	err = json.Unmarshal(response, &clusterReturn)

	return clusterReturn, nil
}

// CreateCAQLCheckForCluster creates a CAQL check that combines numeric data to
// create a histogram.
func CreateCAQLCheckForCluster(capi *api.API, query, title, tags string) (CAQLCheck, error) {
	var cluster_type string
	if strings.Contains(tags, "counter") {
		cluster_type = "counter"
	} else if strings.Contains(tags, "derive") {
		cluster_type = "derivative"
	} else if strings.Contains(tags, "count") {
		cluster_type = "count"
	} else if strings.Contains(tags, "text") {
		cluster_type = "text"
	} else {
		cluster_type = "average"
	}

	caqlCheck := CAQLCheck{
		DisplayName: title + " (Histogram)",
		Target:      "q._caql",
		Period:      60,
		Status:      "active",
		Tags:        strings.Split(tags, ","),
		Timeout:     10,
		Type:        "caql",

		// FIXME(sean): Why is this broker hard coded?
		Brokers: []string{"/broker/1490"},
		Config: CAQLConfig{
			Query: "search:metric:" + cluster_type + "(\"" + query + "(active:1)" + "\") | histogram()",
		},
		Metrics: []CAQLMetrics{
			{Status: "active",
				Name: "output[1]",
				Type: "histogram"},
		},
	}
	reqPath := "/check_bundle"

	checkJSON, err := json.Marshal(caqlCheck)
	if err != nil {
		return caqlCheck, err
	}

	response, err := capi.Post(reqPath, checkJSON)
	if err != nil {
		return caqlCheck, err
	}

	var caqlRet CAQLCheck
	err = json.Unmarshal(response, &caqlRet)
	if err != nil {
		return caqlRet, err
	}

	return caqlRet, nil
}

func MakeGraphFromCluster(capi *api.API, cluster MetricCluster) (ClusterGraph, error) {
	graph := ClusterGraph{
		Datapoints:  []Datapoint{},
		Description: cluster.Description,
		Title:       cluster.Name,
		MetricClusters: []GraphMetricCluster{
			{MetricCluster: cluster.Cid,
				Name:              cluster.Name + " (Cluster)",
				Axis:              "l",
				AggregateFunction: "none"},
		},
		Tags:  cluster.Tags,
		Style: "line",
	}

	reqPath := "/graph"
	graphJSON, err := json.Marshal(graph)
	if err != nil {
		return graph, err
	}

	response, err := capi.Post(reqPath, graphJSON)
	if err != nil {
		return graph, err
	}
	err = json.Unmarshal(response, &graph)
	if err != nil {
		return graph, err
	}

	return graph, nil
}
