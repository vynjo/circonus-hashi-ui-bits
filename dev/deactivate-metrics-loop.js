
/* var Type = require('type-of-is'); */

var stdio = require('stdio');
var ops = stdio.getopt({
    'string': {key: 's', args: 1, mandatory: true, description: 'Allocation ID'},
    'token': {key: 't', args: 1, mandatory: true, description: 'Circonus AP Token'},
    'plan': {key: 'p', args: 1, type: Boolean, description: 'Show Plan but do not delete'}
});

const args = process.argv;

var findMore = true;

do {
	findMore = setTimeout( DoMetricDeactivation(ops.token, ops.string, ops.plan), 5000);
	console.log("findMore out = ", findMore)

}
while (findMore);

function testMetric(token, string, plan) {
	const api = require('circonusapi2');
	var metric_list = [];
	var metric_list_str = "";
	var check_id_path = null;
	var endpoint = "/metric?search=(active:1)" + "*" + string +"*&size=100";
	var findMore = true;

	api.setup(ops.token, 'Nomad');

	api.get(endpoint, null, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        
	    }
	 });
	 console.log(body)
};



function DoMetricDeactivation(token, string, plan) {
	const api = require('circonusapi2');
	var metric_list = [];
	var metric_list_str = "";
	var check_id_path = null;
	var endpoint = "/metric?search=(active:1)" + "*" + string +"*&size=100";
	var findMore = true;

	api.setup(ops.token, 'Nomad');

	api.get(endpoint, null, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.log("error = ", error)
		if (body.length > 0) {
			console.log("Deactivating the following", body.length, "metrics:");
			for (var item in body) {
				var check_id_path = body[0]._check_bundle.replace('check_bundle', 'check_bundle_metrics');
				metric_list.push('{"status": "available" , "name" : "' + body[item]._metric_name + '", "type": "' + body[item]._metric_type + '"}');
				console.log("Metric:", body[item]._metric_name);
			}
			if (plan == true) {
				console.log("End of plan");
				console.log("findMore in = ", findMore)
				return findMore;
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
			return true;
		} else  {
			console.log("No metrics were found");
			return false;
		}
	});
};




