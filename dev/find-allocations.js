'use strict';

const api = require('circonusapi2');
var stdio = require('stdio');
var ops = stdio.getopt({
    'allocid': {key: 'c', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
});

const args = process.argv;

var endpoint = "/metric?search=" + ops.allocid;

var metrics_to_delete = [];

var metrics_list = "";

/* const check_id_path = ""; */

api.setup(ops.token, 'Nomad');

api.get(endpoint, null, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	
	for (var item in body) {
		metrics_to_delete.push('{ name: ' + body[item]._metric_name + ', status: available},');
	}
	
	var check_id_path = '"' + body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics') + '"';
	var check_id_path = check_id_path.replace(/ /g,'');
	
	var metrics_list = "metrics: " + JSON.stringify(metrics_to_delete);
/* 	var metrics_list = metrics_list.replace(/\"/g, ""); */
	
	console.log("Path = ", check_id_path);
	console.log("Metrics = ", metrics_list);

/*
	console.log(metrics_to_delete);
	console.log(body[0]._check_bundle);
*/
/* 	console.log("ID = ", check_id_path); */

/*
	api.put("/check_bundle_metrics/138167", "metrics: [" + metrics_to_delete + "]", (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.dir(body);
	});
*/

	
});




