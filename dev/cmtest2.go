package main

import (
	// "bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	// "strings"
	// "time"

	"github.com/circonus-labs/circonus-gometrics/api"
)

// // Structures copied from Nomad: TaskEvent, TaskState, and Allocation, needed to parse results from Nomad Server
// // 		in order to get Allocation list (Running, Lost, or Complete)
// type TaskEvent struct {
// 	Type string
// 	Time int64 // Unix Nanosecond timestamp
// 	// Restart fields.
// 	RestartReason string
// 	// Driver Failure fields.
// 	DriverError string // A driver error occurred while starting the task.
// 	// Task Terminated Fields.
// 	ExitCode int    // The exit code of the task.
// 	Signal   int    // The signal that terminated the task.
// 	Message  string // A possible message explaining the termination of the task.
// 	// Killing fields
// 	KillTimeout time.Duration
// 	// Task Killed Fields.
// 	KillError string // Error killing the task.
// 	// TaskRestarting fields.
// 	StartDelay int64 // The sleep period before restarting the task in unix nanoseconds.
// 	// Artifact Download fields
// 	DownloadError string // Error downloading artifacts
// 	// Validation fields
// 	ValidationError string // Validation error
// 	// The maximum allowed task disk size.
// 	DiskLimit int64
// 	// The recorded task disk size.
// 	DiskSize int64
// 	// Name of the sibling task that caused termination of the task that
// 	// the TaskEvent refers to.
// 	FailedSibling string
// 	// VaultError is the error from token renewal
// 	VaultError string
// }
//
// type TaskState struct {
// 	// The current state of the task.
// 	State string
//
// 	// Series of task events that transition the state of the task.
// 	Events []*TaskEvent
// }

// Allocation is a struct containing state of a nomad allocation
type Allocation struct {
	// ID of the allocation (UUID)
	ID string
	// // ID of the evaluation that generated this allocation
	// EvalID string
	// Name is a logical name of the allocation.
	Name string
	// NodeID is the node this is being placed on
	NodeID string
	// Job is the parent job of the task group being allocated.
	// This is copied at allocation time to avoid issues if the job
	// definition is updated.
	JobID string
	// // TaskGroup is the name of the task group that should be run
	// TaskGroup string
	// // Desired Status of the allocation on the client
	// DesiredStatus string
	// // DesiredStatusDescription is meant to provide more human useful information
	// DesiredDescription string
	// // Status of the allocation on the client
	ClientStatus string
	// // ClientStatusDescription is meant to provide more human useful information
	// ClientDescription string
	// // TaskStates stores the state of each task,
	// TaskStates map[string]*TaskState
	// // Raft Indexes
	// CreateIndex uint64
	// ModifyIndex uint64
}

// type AllocationResponse struct {
// 	Collection []Allocation
// }

// A test function for Slices.
func printSlice(s []int) {
	fmt.Printf("len=%d cap=%d %v\n", len(s), cap(s), s)
}

// Modified from cnsobject.go in the cironus-api-go repo:

// Used to Parse results from the Circonus API when searching for Metrics which correspond to an Allocation
type circonusMetrics struct {
	Name          string `json:"_metric_name"`
	Active        bool   `json:"_active"`
	CheckBundleID string `json:"_check_bundle"`
}

// Used to create the modified Metric list, particularly the Status field which will be set to 'available'
// type ModifiedMetrics struct {
// 	Name       string `json:"name"`
// 	Status     string `json:"status"`
// 	MetricType string `json:"type"`
// }

// type circapi_response struct {
// 	cid     string   `json:"_cid"`
// 	metrics []string `json:"metrics"`
// }

func getAllocations() ([]Allocation, error) {
	// Get the current allocations (running, lost, complete) Hard coded to IP of Madsen's Nomad server. Will change.
	res, err := http.Get("http://104.196.144.155:4646/v1/allocations")
	if err != nil {
		return nil, err
	}

	//Wait for the full response
	defer res.Body.Close()
	// Read the entire body
	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return nil, err
	}

	allocations := []Allocation{}

	err = json.Unmarshal(body, &allocations)
	if err != nil {
		return nil, err
	}

	return allocations, nil
}

func getCompletedAllocations() ([]Allocation, error) {
	allocations, err := getAllocations()
	if err != nil {
		return nil, err
	}

	completed := []Allocation{}

	for _, allocation := range allocations {
		if allocation.ClientStatus == "complete" {
			completed = append(completed, allocation)
		}
	}

	return completed, nil
}

func getAllocationMetrics(id string) ([]circonusMetrics, error) {

	metricSearchURL := fmt.Sprintf("/metric?search=(active:1)*%s*", id)

	metricsJSON, err := circapi.Get(metricSearchURL)
	if err != nil {
		return nil, err
	}

	metrics := []circonusMetrics{}

	err = json.Unmarshal(metricsJSON, &metrics)
	if err != nil {
		return nil, err
	}

	return metrics, nil
}

func deactivateMetrics(allocation Allocation) error {

	log.Printf("Removing metrics for %s on %s (%s:%s)", allocation.JobID, allocation.NodeID, allocation.Name, allocation.ID)

	allocationMetrics, err := getAllocationMetrics(allocation.ID)
	if err != nil {
		return err
	}

	if len(allocationMetrics) == 0 {
		log.Printf("skipping allocation %s, 0 metrics.", allocation.ID)
		return nil
	}

	log.Printf("allocation %s has %d metrics", allocation.ID, len(allocationMetrics))

	return nil
}

var circapi *api.API

func init() {
	var err error

	cfg := &api.Config{}

	// set any of these you'd like (obviously api token is required)
	cfg.URL = os.Getenv("CIRCONUS_API_URL")
	cfg.TokenKey = os.Getenv("CIRCONUS_API_TOKEN")
	cfg.TokenApp = os.Getenv("CIRCONUS_API_APP")

	// just so we can get some debug output (delete or set to false to stop debug messages)
	cfg.Debug = true

	circapi, err = api.NewAPI(cfg)
	if err != nil {
		log.Printf("ERROR: allocating Circonus API %v\n", err)
		os.Exit(1)
	}
}

func main() {

	completedAllocations, err := getCompletedAllocations()
	if err != nil {
		log.Printf("ERROR: retrieving allocations %v\n", err)
		os.Exit(1)
	}

	if len(completedAllocations) == 0 {
		log.Println("No completed allocations found, exiting.")
		os.Exit(0)
	}

	for _, allocation := range completedAllocations {
		deactivateMetrics(allocation)
	}

	// cfg := &circapi.Config{}
	//
	// // set any of these you'd like (obviously api token is required)
	// cfg.URL = os.Getenv("CIRCONUS_API_URL")
	// cfg.TokenKey = os.Getenv("CIRCONUS_API_TOKEN")
	// cfg.TokenApp = os.Getenv("CIRCONUS_API_APP")
	//
	// // just so we can get some debug output (delete or set to false to stop debug messages)
	// cfg.Debug = true
	//
	// circapi, err := circapi.NewAPI(cfg)
	// if err != nil {
	// 	panic(err)
	// }
	// // Loop through the completed allocations and then mark them as available
	// for n := range complete_allocs {
	// 	var url bytes.Buffer
	// 	metrics := make([]CirconusMetrics, 0)
	//
	// 	url.WriteString("/metric?search=(active:1)*")
	// 	url.WriteString(complete_allocs[n].ID)
	// 	url.WriteString("*")
	// 	foundmetrics, err := circapi.Get(url.String())
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// 	json.Unmarshal(foundmetrics, &metrics)
	// 	// Check to see if we're done (returns No more metrics found)
	// 	if len(metrics) == 0 {
	// 		break
	// 	}
	// 	// A debug - end loop after the first allocation while testings
	// 	if n > 0 {
	// 		break
	// 	}
	// 	// Make a return structure the same length as the found allolocation structure
	// 	modifiedmetrics := make([]ModifiedMetrics, len(metrics))
	// 	fmt.Println("There are", len(metrics), "metrics")
	//
	// 	var checkid = ""
	// 	for m := range metrics {
	// 		checkid = strings.Replace(metrics[m].CheckBundleID, "/check_bundle/", "", -1)
	// 		modifiedmetrics[m].Name = metrics[m].Name
	// 		modifiedmetrics[m].MetricType = metrics[m].MetricType
	// 		modifiedmetrics[m].Status = "available"
	// 		fmt.Println("Found Metrics:", metrics[m].Name, "Check Bundle ID:", checkid, "which is", metrics[m].Active)
	// 		metrics[m].Active = false
	// 		fmt.Println("Now           ", modifiedmetrics[m].Name, "now", modifiedmetrics[m].Status)
	// 	}
	// 	// 		updatedmetrics = JSON.stringify(modifiedmetrics)
	// 	updatedmetrics, err := json.Marshal(modifiedmetrics)
	// 	// Debug print
	// 	fmt.Println("Debug Updated metrics: ", string(updatedmetrics))
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// 	// Build the URL for the Circonus API call to modify the metrics. To Do is to check if all checkid's are the same,
	// 	//		if not error out. Edge case, but maybe useful
	// 	var ret_url bytes.Buffer
	// 	ret_url.WriteString("/check_bundle_metrics/")
	// 	ret_url.WriteString(checkid)
	//
	// 	// This is where I start to loose it - The proper response begins with { metric
	// 	var ret_data bytes.Buffer
	// 	ret_data.WriteString(`{ "metrics" : `)
	// 	ret_data.WriteString(string(updatedmetrics))
	// 	ret_data.WriteString("}")
	//
	// 	ret_json, err := json.Marshal(ret_data)
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// 	fmt.Println("Supposed correct JSON for call to Circonus Put: ", ret_data.String())
	// 	fmt.Println("URL to call API: ", ret_url.String())
	//
	// 	// 		var dat map[string]interface{}
	//
	// 	ret_put, err := circapi.Put(ret_url.String(), ret_json)
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// 	//		below are some debug statements
	// 	// 		json.Unmarshal(ret, &dat)
	// 	//
	// 	// 		log.Println(dat)
	// 	// 		log.Print("Length =", len(dat))
	// 	// 		log.Println(dat[0])
	//
	// 	fmt.Println("Debug: ", len(ret_put))
	// 	log.Println("Debug: FINISHED LOOP")
	//
	// }
	// log.Println("Done")
}

// To Duplicate my set up, you can use the following api variables:

// export CIRCONUS_API_TOKEN="7339c41b-48ab-617e-8859-c60ab96edb90"
// export CIRCONUS_API_APP="Nomad"
// export CIRCONUS_API_URL="https://api.circonus.com/v2/"
// export GOPATH=$PWD

// A run should disable the following set of metrics, you can search in the UI by the following:

//  https://conference.circonus.com/checks/metrics?search=*422f1f87-792a-cce3-97dd-3d15ade35619*

// but it does not. No error is given, but
// Proper call to circapi.Put should look like the following.
// {
// 	metrics: [{
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`system',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`kernel_usage',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`user',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`max_usage',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`total_percent',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`swap',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`total_ticks',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`rss',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`throttled_periods',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`kernel_max_usage',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`throttled_time',
// 		type: 'numeric'
// 	}, {
// 		status: 'available',
// 		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`cache',
// 		type: 'numeric'
// 	}]
// }
