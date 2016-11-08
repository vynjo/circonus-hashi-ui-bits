package main

import (
// 	"log"
	"os"
	"flag"
	"fmt"
  	"encoding/json"
	circapi "github.com/circonus-labs/circonus-gometrics/api"
)

type Metric struct {
	Active             string              `json:"_active,omitempty"`
	Check              string              `json:"_check,omitempty"`
	CheckActive        string              `json:"_check_active,omitempty"`
	CheckBundle        string              `json:"_last_modified,omitempty"`
	CheckTags          []string            `json:"_last_modifed_by,omitempty"`
	CheckUUID          string              `json:"_check_uuid,omitempty"`
	Cid                string              `json:"_cid,omitempty"`
	Histogram          string              `json:"_histogram"`
	MetricName         string              `json:"_metric_name"`
	MetricType         string              `json:"_metric_type"`
	Tags               []string            `json:"tags,omitempty"`
	Units              string              `json:"units"`
}
   

func main() {
	
	searchPtr := flag.String("search_string", "", "Search term to find metrics")
// 	tokenPtr := flag.String("token", "", "Circonus API Token")
    
    flag.Parse()

	fmt.Println("Search Term:", *searchPtr)
// 	fmt.Println("API Token:", *tokenPtr)
	
	
	cfg := &circapi.Config{}

	// set any of these you'd like (obviously api token is required)
	cfg.URL = os.Getenv("CIRCONUS_API_URL")
	cfg.TokenKey = os.Getenv("CIRCONUS_API_TOKEN")
	cfg.TokenApp = os.Getenv("CIRCONUS_API_APP")

	// just so we can get some debug output (delete or set to false to stop debug messages)
	cfg.Debug = true

	api, err := circapi.NewAPI(cfg)
	if err != nil {
		panic(err)
	}

	ret, err := api.Get("/metric?search=" + *searchPtr)
	if err != nil {
		panic(err)
	}
	
	json.Parser := json.NewDecoder(ret)
	
	fmt.Println(json.Parser)
	
	
// 	var m []Metric
// 	
// 	m, err = json.Marshal(ret)
// 	fmt.Println("m = ", m)
// 	
// 	for i := 0; i < len(m); i++ {
// 		fmt.Println(m[i])
//     }
// 	fmt.Println("Field = ", len(m))
	
// 	for l := range metrics {
// 		fmt.Printf("Id = %v, Name = %v", metrics[l]._active, metrics[l]._metric_name)
// 		fmt.Println()
//     }
	
}

// {
//         "_active": true,
//         "_check": "/check/169757",
//         "_check_active": true,
//         "_check_bundle": "/check_bundle/138167",
//         "_check_tags": [
//             "hs-type:client",
//             "service:hashistack",
//             "service:nomad"
//         ],
//         "_check_uuid": "3cb46142-2ead-ec0b-f1a9-eed8e2bca997",
//         "_cid": "/metric/169757_nomad`nc-2`client`allocs`fabio`fabio`fa3b4740-79ab-3c4d-671b-eb4a27048be7`fabio`cpu`throttled_time",
//         "_histogram": "false",
//         "_metric_name": "nomad`nc-2`client`allocs`fabio`fabio`fa3b4740-79ab-3c4d-671b-eb4a27048be7`fabio`cpu`throttled_time",
//         "_metric_type": "numeric",
//         "tags": [],
//         "units": null
//     },
//     

// 	str, err := json.Marshal("{ metrics: " +string(ret) + "}")
// 	if err != nil {
// 		fmt.Println("[ERROR] marshling output %+v", err)
// 		return
// 	}
// 
// // 	fmt.Printf("%#v", string(ret))
// 	
// 		fmt.Println(str)
// 	
// 	for m := 0; m < 10; m++ {
// 		fmt.Println(string(str[m]))
// 	}
// }

 
// for (var item in body) {
// 		var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
// 		metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
// 		console.log("Disabled ", body[item]._metric_name);
// 	}
//  	var metric_list_str = '{ "metrics" : [' + metric_list + ']}';
// 	var metric_json = JSON.parse(metric_list_str);
// 	api.put(check_id_path, metric_json, (code, error, body) => {
// 	    if (error !== null) {
// 	        console.error(error);
// 	        process.exit(1);
// 	    }
// 	    console.dir(body);
// 	});
// });


/*

this assumes you've done some basic setup:

mkdir test
cd test
export GOPATH=$(pwd)
# save this code as cmtest.go
go get -d .
go run cmtest.go

*/