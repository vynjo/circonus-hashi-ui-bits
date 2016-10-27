
var stdio = require('stdio');

var ops = stdio.getopt({
    'nomadip': {key: 'n', args: 1, mandatory: true, description: 'Nomad Server API IP Address'},
    'token': {key: 't', args: 1, mandatory: true, description: 'Circonus AP Token'},
    'plan': {key: 'p', args: 1, type: Boolean, description: 'Show Plan but do not delete'}
});

const args = process.argv;

var http = require("http");

var url = "http://" + ops.nomadip+ ":4646/v1/allocations";
var allocToDeactivate = [];
var body = "", allocations;
// get is a simple wrapper for request()
// which sets the http method to GET
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
        console.log("Found", allocations.length, "allocations in total");
        for (var item in allocations) {
			console.log("Allocation:", allocations[item].ID.substr(0,8), allocations[item].JobID, allocations[item].DesiredStatus, allocations[item].ClientStatus);
			if (allocations[item].ClientStatus == "complete") {
				console.log("Deactivate:", allocations[item].ID.substr(0,8))
				allocToDeactivate.push(allocations[item].ID.substr(0,8));
				if (ops.plan == true) {
					ShowMetricsTodDeactivate(ops.token, allocations[item].ID.substr(0,8))
				} else {
					DoMetricDeactivation(ops.token, allocations[item].ID.substr(0,8))
				}
			}
		}
		printalloc(allocToDeactivate.length);
		console.log("Will Deactivate: ", allocToDeactivate);
    }); 

}); 

function printalloc(alloc) {
	console.log("Found", alloc, "which are complete")
}

function ShowMetricsTodDeactivate(token, string) {
	const api = require('circonusapi2');
	var metric_list = [];
	var metric_list_str = "";
	var check_id_path = null;
	var endpoint = "/metric?search=(active:1)" + "*" + string +"*&size=100";

	api.setup(ops.token, 'Nomad');

	api.get(endpoint, null, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
		if (body.length > 0) {
// 			console.log("Plan calls for the following", body.length, "metrics to be dactivated:");
			for (var item in body) {
				var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
				metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
				console.log("Metric:", body[item]._metric_name);
			}
		} 
	}
)};

function DoMetricDeactivation(token, string) {
	const api = require('circonusapi2');
	var metric_list = [];
	var metric_list_str = "";
	var check_id_path = null;
	var endpoint = "/metric?search=(active:1)" + "*" + string +"*&size=100";

	api.setup(ops.token, 'Nomad');

	api.get(endpoint, null, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
		if (body.length > 0) {
			console.log("Deactivating the following", body.length, "metrics:");
			for (var item in body) {
				var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
				metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
				console.log("Metric:", body[item]._metric_name);
			}
			if (ops.plan == true) {
				console.log("End of plan");
			}
			console.log("Initating Deactivation of", body.length, " metrics...");
		 	var metric_list_str = '{ "metrics" : [' + metric_list + ']}';
			var metric_json = JSON.parse(metric_list_str);
			api.put(check_id_path, metric_json, (code, error, body) => {
			    if (error !== null) {
			        console.error(error);
			        process.exit(1);
			    }
			    console.dir(body);
		
			});
		} else 
			console.log("No metrics were found");
	});
	};


