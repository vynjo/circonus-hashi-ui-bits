# circonus-hashi-ui-bits
<h2>Tools for Circonus and Hashicorp integration</h2>

Current tools include:

### Terraform (!!!)

<p>Sample in development</p>

### GO Version for:
<p>**deactivate-complete-allocs** Deactivation of "Complete" Allocations.</p>
<p>**create_cgc** - Create Cluster, Graph, and CAQL Check for Numeric or Histogram metric types accepts the following parameters:</p>
<p><b>create_cluster</b> - Creating a Metric Cluster from a Query</p>
<p><b>create_cluster_and_graph</b> - Creating a Metric Cluster and Graphfrom a Query</p>
<p><b>delete_checks_by_tag</b> - Delete all checks with TAG</p>
<p><b>delete_clusters_by_tag</b> - Delete all clusters with TAG</p>
<p><b>delete_graphs_by_tag</b> - Delete all clusters with TAG</p>

### Node.js versions for in node directory
- node/create-cluster.js
- node/deactivate-complete-lost-allocs.js
- node/deactivate-metrics.js
- node/deactivate-complete-allocs.js
- node/deactivate-lost-allocs.js
- node/find-running-allocations.js
=======
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

>>>>>>> origin/master
