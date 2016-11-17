package main

import (
	"log"
	"os"
	circapi "github.com/circonus-labs/circonus-gometrics/api"
	"reflect"
)

/*

this assumes you've done some basic setup:

mkdir test &&  cd test
export GOPATH=$(pwd)

# save this code as cmtest.go

# download the dependencies
go get -d .

# at a minimum do:
export CIRCONUS_API_TOKEN="a valid token"
# optionally:
#export CIRCONUS_API_APP="app name associated with token"
#export CIRCONUS_API_URL="a valid url, default is https://api.circonus.com/v2"

# run the test
go run cmtest.go

*/

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
	log.Println(reflect.TypeOf(ret))
	log.Println(string(ret))
}