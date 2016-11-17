#!/usr/bin/env node

// load the https module
var https = require('https');

https.request({
  host: 'api.circonus.com',
  path: '/metric_cluster',
  headers: {
    'X-Circonus-App-Name': 'Nomad',
    'X-Circonus-Auth-Token': '7339c41b-48ab-617e-8859-c60ab96edb90',
    'Accept': 'application/json'
  },
  'method': 'POST',
}, function (response) {

  // collect the body while we're getting chunks of it
  var body = '';
  response.on('data', function (chunk) { body += chunk; });

  // once we've got 'em all, handle them
  response.on('end', function () {
    // parse the JSON body
    result = JSON.parse(body);

    // handle errors by extracting the code/message from the response
    if (response.statusCode < 200 || response.statusCode >= 300) {
      console.log( response.statusCode + ': ' 
        + result.code + ' (' + result.message + ')');
      return;
    }

    // result holds the data from the server
    console.log(result);
  });
}).end();

// here's where we specify the data we want to POST
r.write()(JSON.stringify({
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
}));
