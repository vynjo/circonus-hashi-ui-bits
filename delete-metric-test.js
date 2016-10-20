'use strict';

const api = require('circonusapi2');

var Type = require('type-of-is');

var stdio = require('stdio');
var ops = stdio.getopt({
    'allocid': {key: 'c', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
});

const args = process.argv;

var metric_to_delete = "";

var endpoint = "/metric?search=" + ops.allocid;

api.setup(ops.token, 'Nomad');

api.get(endpoint, null, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	
	for (var item in body) {
		var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');

		metric_to_delete = '{ "metrics" : [' + 
							'{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}]}';
		var metric_json = JSON.parse(metric_to_delete);

		api.put(check_id_path, metric_json, (code, error, body) => {
		    if (error !== null) {
		        console.error(error);
		        process.exit(1);
		    }
		    console.dir(body);
		});
		console.log("Disabled ", body[item]._metric_name);
	}
});
/*
		metric_to_delete = ('{ name: ' + body[item]._metric_name + ', status: available}');
		console.log(JSON.stringify(body[item]._metric_name));
		console.log(JSON.stringify(metric_to_delete));
*/

	
/*
	var check_id_path = '"' + body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics') + '"';
	var check_id_path = check_id_path.replace(/ /g,'');
*/
	
/* 	var metrics_list = "metrics: " + JSON.stringify(metrics_to_delete); */
/* 	var metrics_list = metrics_list.replace(/\"/g, ""); */
	
/*
	console.log("Path = ", check_id_path);
	console.log("Metrics = ", metrics_list);
*/

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

/*
		metric_to_delete = JSON.stringify({
			  "metrics": [
			    {
			      "status": "available",
			      "name": body[item]._metric_name,
			    }
			  ]
			});
*/
//  		var metric_to_delete = metric_to_delete.replace(/\"/g, "");

	





FIRST ATTEMPT:


'use strict';

const api = require('circonusapi2');

var Type = require('type-of-is');

var stdio = require('stdio');
var ops = stdio.getopt({
    'allocid': {key: 'c', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
});

const args = process.argv;

var metric_to_delete = "";

var endpoint = "/metric?search=" + ops.allocid;

var check_id = "";

console.log(Type(check_id));

/* const check_id_path = ""; */

api.setup(ops.token, 'Nomad');

api.get(endpoint, null, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	
	for (var item in body) {
		var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
// 		var check_id_path = check_id_path.replace(/\"/g, "");
		console.log(check_id_path)
		console.log(body[item]);
		metric_to_delete = '{ "metrics" : [' + 
							'{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}]}';
// 		console.log(metric_to_delete);
		var metric_json = JSON.parse(metric_to_delete);
		console.log(metric_json);


 		console.log(metric_to_delete);
		console.log(typeof(metric_to_delete));
		api.put(check_id_path, metric_json, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.dir(body);
	});
}

});
/*
		metric_to_delete = ('{ name: ' + body[item]._metric_name + ', status: available}');
		console.log(JSON.stringify(body[item]._metric_name));
		console.log(JSON.stringify(metric_to_delete));
*/

	
/*
	var check_id_path = '"' + body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics') + '"';
	var check_id_path = check_id_path.replace(/ /g,'');
*/
	
/* 	var metrics_list = "metrics: " + JSON.stringify(metrics_to_delete); */
/* 	var metrics_list = metrics_list.replace(/\"/g, ""); */
	
/*
	console.log("Path = ", check_id_path);
	console.log("Metrics = ", metrics_list);
*/

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

/*
		metric_to_delete = JSON.stringify({
			  "metrics": [
			    {
			      "status": "available",
			      "name": body[item]._metric_name,
			    }
			  ]
			});
*/
//  		var metric_to_delete = metric_to_delete.replace(/\"/g, "");

	





