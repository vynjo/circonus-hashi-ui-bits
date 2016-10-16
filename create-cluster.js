'use strict';

const api = require('circonusapi2');

const cluster_config = {
    "name": "Nomad Client Disk - Available",
    "queries": [
      {
        "query": "*nc-*client`host`disk*available",
        "type": "average"

      }
    ],
    "description": "All web requests",
    "tags": [
      "service:hashistack"
    ]
};

api.setup('7339c41b-48ab-617e-8859-c60ab96edb90', 'Nomad');
api.post('/metric_cluster', cluster_config, (code, error, body) => {
    if (error !== null) {
        console.error(error);
        process.exit(1);
    }
    console.dir(body);
});
