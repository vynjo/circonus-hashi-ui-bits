# circonus-hashi-ui-bits
<h2>Tools for Circonus and Hashicorp integration</h2>

Environment variables can be set so **apiurl, app, key,** and/or **nomadurl** parameters do not need to be set:
- CIRCONUS_API_KEY="API_TOKEN_FROM_YOUR_CIRCONUS_ACCOUNT"
- CIRCONUS_API_APP="Name_of_App"
- CIRCONUS_API_URL="https://api.circonus.com/v2/"
- NOMAD_API_URL="http://IP_OF_NOMAD_SERVER:4646/v1/allocations"

Current tools include:

### GO Version for:
<p>**deactivate-complete-allocs** Deactivation of "Complete" Allocations.</p>
<p>**create_cgc** - Create Cluster, Graph, and CAQL Check for Numeric or Histogram metric types accepts the following parameters:</p>

- **apiurl** (string) Base Circonus API URL [https://api.circonus.com/] (CIRCONUS_API_URL)
- **app** (string) Circonus API Token App [nomad-metric-reaper] (CIRCONUS_API_APP)
- **debug** Enable Circonus API debugging
- **key**	(string) Circonus API Token Key [none] (CIRCONUS_API_KEY)
- **nomadurl**	(string) Base Nomad API URL [http://localhost:4646/] (NOMAD_API_URL)


<p>**create_cluster.go** - Creating a Metric Cluster from a Query</p>
<p>**create_cluster_and_graph.go** - Creating a Metric Cluster and Graphfrom a Query</p>

Each accepts the following flags:

- **apiurl** (string) Base Circonus API URL [https://api.circonus.com/] (CIRCONUS_API_URL)
- **app** (string) Circonus API Token App [nomad-metric-reaper] (CIRCONUS_API_APP)
- **debug** Enable Circonus API debugging
- **key**	(string) Circonus API Token Key [none] (CIRCONUS_API_KEY)
- **query** (string) The Query used to search

      sample: -query "nomad*runtime*gc_pause_ns"
- **title** (string) The name of the Cluster
      -title "Nomad runtime gc_pause_ns"
- **tags** (string) Tags to include
      - tags "creator:api,role:client,service:nomad,data-type:histogram,group:primary"

<p>**delete_checks_by_tag.go** - Delete a set of checks that contain a tag or set of tags</p>
<p>**delete_clusters_by_tag.go** - Delete a set of clusters that contain a tag or set of tags</p>
<p>**delete_graphs_by_tag.go** - Delete a set of graphs that contain a tag or set of tags</p>

Accepts **apiurl, app, key,** and **tag**

<p>**deactivate-metrics_by_search.go** - Delete a set of metrics searched for via query string.</p>

Accepts **query*

### Node.js versions for
- node/create-cluster.js
- node/deactivate-complete-lost-allocs.js
- node/deactivate-metrics.js
- node/deactivate-complete-allocs.js
- node/deactivate-lost-allocs.js
- node/find-running-allocations.js

Requires circonusapi2 and stdio
- npm install circonusapi2
- npm install stdio
