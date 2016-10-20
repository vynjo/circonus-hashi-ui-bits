'use strict';

const api = require('circonusapi2');

var Type = require('type-of-is');

var stdio = require('stdio');
var ops = stdio.getopt({
    'allocid': {key: 'c', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
});

const args = process.argv;

var metric_list = [];
var metric_list_str = "";
var check_id_path = null;
var endpoint = "/metric?search=" + ops.allocid;

api.setup(ops.token, 'Nomad');

api.get(endpoint, null, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	
	for (var item in body) {
		var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
		metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
		console.log("Disabled ", body[item]._metric_name);
	}
 	var metric_list_str = '{ "metrics" : [' + metric_list + ']}';
	var metric_json = JSON.parse(metric_list_str);
	api.put(check_id_path, metric_json, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.dir(body);
	});
});
