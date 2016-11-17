'use strict';

const api = require('circonusapi2');
var stdio = require('stdio');
var ops = stdio.getopt({
    'query': {key: 'c', args: 1, mandatory: true, description: 'Metric Cluster Query'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
    'title': {args: 1, args: 1, mandatory: true, description: 'Metric Cluster Name'},
    'description': {key: 'description', args: 1, description: 'Metric Cluster Description'},
    'tags': {key: 'tags', args: 1, description: 'a key/value pair of tags (no spaces) - i.e. type:cluster,datacenter:aws-west'}
});

const args = process.argv;

var cluster_id = {};

var query_string = "search:metric:average("

const cluster_config = {
    "name": ops.title,
    "queries": [
      {
        "query": ops.query,
        "type": "average"

      }
    ],
    "description": ops.description,
    "tags": ops.tags
};

const caql_config = {
  display_name: "CAQL",
  config: {
        query: 'search:metric:average("nomad*runtime*free_count (active:1)") | histogram()',
  },
  metrics: [
    {
      name: "Foobar",
      status: "active",
      type: "histogram"
    }
  ],
  target: "q._caql",
  period: 60,
  status: "active",
  tags: ops.tags,
  timeout: 10,
  type: "caql",
  brokers: [
        "/broker/1490"
    ],
}

var body1;

api.setup(ops.token, 'Nomad');

var request = require("request");
var data;




request( api.post('/check_bundle', caql_config, (code, error, body) => {
	 if (error !== null) {
        console.error(error);
        process.exit(1);
    }
    data = body;
}));

console.log(data);
   

/*
api.post('/metric_cluster', cluster_config, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }

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
	    "style": "line",
	    "tags": ops.tags,
	    "title": ops.title};

	api.post('/graph', cluster_graph_config, (code, error, body) => {
	    if (error !== null) {
	        console.error(error);
	        process.exit(1);
	    }
	    console.dir(body);
	});
});
*/
