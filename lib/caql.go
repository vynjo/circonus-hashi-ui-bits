package lib

import (
	"encoding/json"
	"log"
	"os"
	"strconv"
	"strings"

	"github.com/circonus-labs/circonus-gometrics/api"
)

type CAQLConfig struct {
	Query            string `json:"query"`
	ReverseSecretKey string `json:"reverse:secret_key"`
	Name             string `json:"name"`
}

type CAQLMetrics struct {
	Status string   `json:"status"`
	Name   string   `json:"name"`
	Type   string   `json:"type"`
	Units  string   `json:"units"`
	Tags   []string `json:"tags"`
}

type CAQLCheck struct {
	CheckUuids            []string      `json:"_check_uuids"`
	Checks                []string      `json:"_checks"`
	Cid                   string        `json:"_cid"`
	Created               int           `json:"_created"`
	LastModified          int           `json:"_last_modified"`
	LastModifiedBy        string        `json:"_last_modified_by"`
	ReverseConnectionUrls []string      `json:"_reverse_connection_urls"`
	Brokers               []string      `json:"brokers"`
	Config                CAQLConfig    `json:"config"`
	DisplayName           string        `json:"display_name"`
	Metrics               []CAQLMetrics `json:"metrics"`
	Notes                 string        `json:"notes"`
	Period                int           `json:"period"`
	Status                string        `json:"status"`
	Tags                  []string      `json:"tags"`
	Target                string        `json:"target"`
	Timeout               int           `json:"timeout"`
	Type                  string        `json:"type"`
}

func CreateCAQLGraph(capi *api.API, caql CAQLCheck) (RegularGraph, error) {
	checknum, _ := strconv.Atoi(strings.Replace(caql.Checks[0], "/check/", "", -1))

	graph := RegularGraph{
		// 		Description: caql.Description,
		Title:     caql.DisplayName,
		Style:     "area",
		LineStyle: "stepped",
		Tags:      caql.Tags,
	}
	datapoint := Datapoint{
		CheckID:    checknum,
		MetricType: "histogram",
		Name:       caql.DisplayName,
		Axis:       "r",
		MetricName: caql.Metrics[0].Name,
		Color:      "#2F5DAB",
	}

	graph.Datapoints = append(graph.Datapoints, datapoint)

	graphJSON, err := json.Marshal(graph)
	if err != nil {
		return graph, err
	}

	reqPath := "/graph"
	response, err := capi.Post(reqPath, graphJSON)
	if err != nil {
		log.Printf("ERROR: Creating Graph via Circonus API %v\n%v\n", err, response)
		os.Exit(1)
		// 		return graph, err
	}

	var responseGraph ReturningGraph

	err = json.Unmarshal(response, &responseGraph)
	if err != nil {
		return RegularGraph{}, err
	}
	graph.Cid = responseGraph.Cid

	return graph, err
}
