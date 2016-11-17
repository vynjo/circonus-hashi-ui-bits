package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "net/http/httputil"
)

func main() {
    var body []byte
    var response *http.Response
    var request *http.Request

    url := "http://104.196.144.155:4646/v1/allocations"
    request, err := http.NewRequest("GET", url, nil)
    if err == nil {
        request.Header.Add("Content-Type", "application/json")
        debug(httputil.DumpRequestOut(request, true))
        response, err = (&http.Client{}).Do(request)
    }

    if err == nil {
        defer response.Body.Close()
        debug(httputil.DumpResponse(response, true))
        body, err = ioutil.ReadAll(response.Body)
    }

    if err == nil {
        fmt.Printf("%s", body)
    } else {
        log.Fatalf("ERROR: %s", err)
    }
}

func debug(data []byte, err error) {
    if err == nil {
        fmt.Printf("%s\n\n", data)
    } else {
        log.Fatalf("%s\n\n", err)
    }
}