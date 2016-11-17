
package main

import (
	"encoding/json"
	"fmt"
)

type Foo struct {
    Number int    `json:"number"`
    Title  string `json:"title"`
}


type Metriclist struct {
	Label		string   	`json:"metrics"`
	Metric 		
}

type Metric struct {
	Name		string   	`json:"name"`
	Status		string		`json:"status"`
	MetricType	string		`json:"type"`
}

type Results struct {
    Matches []Match     
}

// nested within sbserver response
type Match struct {
    Name		string   	`json:"name"`
	Status		string		`json:"status"`
	MetricType	string		`json:"type"`
}

func main() {
	
	c := &Metriclist{
		Metric: Metric{
			Name: "nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`memory`kernel_max_usage",
			Status: "available", 
			MetricType: "numberic",
		},
	}
	foo_marshalled, err := json.Marshal(c)
	if err != nil {
			panic(err)
		}
	fmt.Println( string(foo_marshalled)) // write response to ResponseWriter (w)
	
// 	json := `{metrics: [{Status: "available", Name: "nomad`nc-5`client`allocs`hashiapp`hashiapp`422f1f87-792a-cce3-97dd-3d15ade35619`hashiapp`cpu`system", MetricType: "numeric"}]}`
	
	jsonResponse := `{metrics:[{name:"nomad\client","platformType":"ANY_PLATFORM","threatEntryType":"URL","threat":{"url":"http://testsafebrowsing.appspot.com/apiv4/ANY_PLATFORM/MALWARE/URL/"}}]}`
	
	foobar, err := json.Marshal(c)
	if err != nil {
			panic(err)
		}
	fmt.Println( string(foobar))
	
	fmt.Println(jsonResponse)
}
	
	
// 	foo_marshalled1, err := json.Marshal(Metric{Name: "nomad", Status: "available", MetricType: "numeric"})
// 	if err != nil {
// 			panic(err)
// 		}
// 	fmt.Println( string(foo_marshalled1))