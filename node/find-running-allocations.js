'use strict';

const api = require('circonusapi2');
var http = require('http');
var stdio = require('stdio');

var ops = stdio.getopt({
    'nomadip': {key: 'i', args: 1, mandatory: true, description: 'IP of Nomad API Server'},
    'plan': {key: 'p', args: 1, type: Boolean, description: 'Show Plan but do not delete'}
});

const args = process.argv;


var url = "";
var foundAllocations = [];
var runningAllocations = [];

url = "http://" + ops.nomadip + ":4646/v1/allocations";

findRunningAllocs(url);

function findRunningAllocs (url) {

	var allocations = [];
	var body = "", allocations;
	var runningAllocations = [];
	
	var request = http.get(url, function (response) {
	    // data is streamed in chunks from the server
	    // so we have to handle the "data" event    
	
	    response.on("data", function (chunk) {
	        body += chunk;
	    }); 
	    response.on("end", function (err) {
	        // finished transferring data
	        // dump the raw data
	        allocations = JSON.parse(body); //Parse into list of allocations
	        for (var item in allocations) {
	// 			console.log("Allocation:", allocations[item].ID.substr(0,8), allocations[item].JobID, allocations[item].DesiredStatus, allocations[item].ClientStatus);
				if (allocations[item].ClientStatus == "running") {
					runningAllocations.push(allocations[item].ID.substr(0,8));
				}
			}
			console.log("Found", allocations.length, "allocations in total, and", runningAllocations.length, "running");
			console.log(runningAllocations);
			
	    }); 
	}); 
	
	
}

function printalloc(alloc) {
	console.log("Found", alloc, "which are running:")
}
