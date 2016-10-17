'use strict';



var stdio = require('stdio');
var ops = stdio.getopt({
    'cID': {key: 'c', mandatory: true, description: 'Metric Cluster ID'},
    'token': {key: 't', mandatory: true, description: 'Circonus AP Token'},
    'title': {args: 1, mandatory: true},
    'tags': {key: 'o'}
});

const args = process.argv;
console.log(args);

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
            "name": "Nomad Client Disk - Available",
            "aggregate_function": "none",
            "metric_cluster": "/metric_cluster/32468",
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
    "tags": [
        "hs-type:client",
        "hs-type:visualize",
        "service:hashistack",
        "service:nomad"
    ],
    "title": "Nomad Client Disk - Available TEST2"
};

api.setup(ops.token, 'Nomad');
api.post('/graph', cluster_graph_config, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
    console.dir(body);
});

/*


curl -H 'X-Circonus-App-Name: ExampleApp' \
     -H 'X-Circonus-Auth-Token: deadbeef-badc-0ffe-edea-dbeefbadc0ff' \
     -H 'Accept: application/json' \
     -X POST \
     -d @- 'https://api.circonus.com/graph'
{
  "datapoints": [
    {
      "legend_formula": null,
      "metric_type": "numeric",
      "check_id": 62513,
      "stack": null,
      "name": "Average Ping Time",
      "data_formula": null,
      "axis": "l",
      "color": "#ffff00",
      "metric_name": "average",
      "derive": "gauge",
      "hidden": false
    }
  ],
  "title": "Ping Test"
}


{
    "_cid": "/graph/50128731-033a-c050-df35-bb419ef2dbcd",
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
            "name": "Nomad Client Disk - Available",
            "aggregate_function": "none",
            "metric_cluster": "/metric_cluster/32468",
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
    "tags": [
        "hs-type:client",
        "hs-type:visualize",
        "service:hashistack",
        "service:nomad"
    ],
    "title": "Nomad Client Disk - Available"
}
*/