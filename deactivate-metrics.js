'use strict';

const api = require('circonusapi2');

/* var Type = require('type-of-is'); */

var stdio = require('stdio');
var ops = stdio.getopt({
    'string': {key: 's', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 't', args: 1, mandatory: true, description: 'Circonus AP Token'},
    'plan': {key: 'p', args: 1, type: Boolean, description: 'Show Plan but do not delete'}
});

const args = process.argv;

var metric_list = [];
var metric_list_str = "";
var check_id_path = null;
var endpoint = "/metric?search=(active:1)" + ops.string +"&size=100";

/* console.log(endpoint) */

api.setup(ops.token, 'Nomad');

api.get(endpoint, null, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	if (body.length > 0) {
		if (ops.plan == true) {
			console.log("Plan calls for the following", body.length, "metrics to be dactivated:");
		} else {
			console.log("Deactivating the following", body.length, "metrics:");
		}
		for (var item in body) {
			var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
			metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
			console.log("Metric:", body[item]._metric_name);
		}
		if (ops.plan == true) {
			console.log("End of plan");
		} else {
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
		};
	} else 
		console.log("No metrics were found");
});
