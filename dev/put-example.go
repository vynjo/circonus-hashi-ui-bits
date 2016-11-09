package main

import (
	"log"
	"os"
	circapi "github.com/circonus-labs/circonus-gometrics/api"
	"fmt"
)

type Foo struct {
    Number int    `json:"number"`
    Title  string `json:"title"`
}

type Metric struct {
	Name		string   	`json:"name"`
	Status		string		`json:"status"`
	MetricType	string		`json:"type"`
}

func main() {
	cfg := &circapi.Config{}

	// set any of these you'd like (obviously api token is required)
	cfg.URL = os.Getenv("CIRCONUS_API_URL")
	cfg.TokenKey = os.Getenv("CIRCONUS_API_TOKEN")
	cfg.TokenApp = os.Getenv("CIRCONUS_API_APP")

// 	log.Println(cfg.)
	// just so we can get some debug output (delete or set to false to stop debug messages)
	cfg.Debug = true

	api, err := circapi.NewAPI(cfg)
	if err != nil {
		panic(err)
	}

	ret, err := api.Get("/user/current")
	if err != nil {
		panic(err)
	}
	log.Println(string(ret))
	
// 	metric := make([]Metric, 0)
	json = {
		metrics: [{
			status: 'available',
			name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`system',
			type: 'numeric'
		}]
	}
	foo_marshalled, err := json.Marshal(Foo{Number: 1, Title: "test"})
	if err != nil {
			panic(err)
		}
	fmt.Println( string(foo_marshalled)) // write response to ResponseWriter (w)

	foo, err := json.Marshal(Metric{Name: "nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`system", Status: "available", MetricType: "numeric"})
		
	fmt.Println("%v", foo)

	retput, err := api.Put("/check_bundle_metrics/138169", metric)
	log.Println(retput)
}


json = {
	metrics: [{
		status: 'available',
		name: 'nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`system',
		type: 'numeric'
	}]
}