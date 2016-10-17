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

api.setup(ops.token, 'Nomad');

cluster_id = api.post('/metric_cluster', cluster_config, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
    return body;
});
