'use strict';

const api = require('circonusapi2');
var stdio = require('stdio');
var ops = stdio.getopt({
    'query': {key: 'c', args: 1, mandatory: true, description: 'Metric Query string'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
});

const args = process.argv;

api.setup(ops.token, 'Nomad');

api.post('/metric', ops.query, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
	console.log(body)
/*
	const cluster_graph_config = {
	    "access_keys": [],
	    "composites": [],
	    "datapoints": [],
	    "description": ops.description,
	    "guides": [],
	    "line_style": null,
	    "logarithmic_left_y": null,
	    "logarithmic_right_y": null,
	    "max_left_y": null,
	    "max_right_y": null,
	    "metric_clusters": [
	        {
	            "legend_formula": null,
	            "stack": null,
	            "name": ops.title,
	            "aggregate_function": "none",
	            "metric_cluster": body._cid,
	            "axis": "l",
	            "data_formula": null,
	            "hidden": false
	        }
	    ],
	    "min_left_y": null,
	    "min_right_y": null,
	    "notes": null,
	    "overlay_sets": null,
	    "style": null,
	    "tags": ops.tags,
	    "title": ops.title};

	api.post('/check_bundle_metrics', cluster_graph_config, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.dir(body);

	}); */
});

/*
PUT /check_bundle_metrics/45315
{
  metrics: [
    {
      name: Honeydew`detectors`0`count,
      status: active,
      tags: [],
      type: numeric,
      units: seconds
    },
    {
      name: average,
      status: available,
      tags: [],
      type: numeric,
      units: seconds
    }
  ]
}
4ca13090
*/