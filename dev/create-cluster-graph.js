'use strict';

var stdio = require('stdio');
var ops = stdio.getopt({
    'id': {key: 'c', args: 1, mandatory: true, description: 'Metric Cluster ID'},
    'token': {key: 'token', args: 1, mandatory: true, description: 'Circonus AP Token'},
    'title': {key: 'title', args: 1, mandatory: true, description: 'Graph Name'},
    'tags': {key: 'tags', args: 1, description: 'a key/value pair of tags - i.e. "type:cluster, datacenter:aws-west"'}
});

/* const args = process.argv; */

const api = require('circonusapi2');

const cluster_graph_config = {
    "access_keys": [],
    "composites": [],
    "datapoints": [],
    "description": "",
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
            "metric_cluster": "/metric_cluster/" + ops.id,
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
    "tags": [ops.tags],
    "title": ops.title};

/* console.log(cluster_graph_config); */

api.setup(ops.token, 'Nomad');
const cluster_output = api.post('/graph', cluster_graph_config, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
    console.dir(body);
});

console.log(cluster_output)