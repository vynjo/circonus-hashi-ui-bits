# circonus-hashi-ui-bits
<h2>Tools for Circonus and Hashicorp integration</h2>

Current tools include:

### Terraform (!!!)

<p>Finally, Monitoring as Code! The Terraform repo for all things Circonus. It is actively being built out.</p>

[Details here](https://github.com/vynjo/circonus-hashi-ui-bits/tree/master/terraform-circonus)

### If you don't want to use Terraform, there are go, and node.js tools as well:
### GO Version for:
- <b>deactivate-complete-allocs</b> Deactivation of "Complete" Allocations.
- <b>create_cgc</b> - Create Cluster, Graph, and CAQL Check for Numeric or Histogram metric types
- <b>create_cluster</b> - Creating a Metric Cluster from a Query
- <b>create_cluster_and_graph</b> - Creating a Metric Cluster and Graphfrom a Query
- <b>delete_checks_by_tag</b> - Delete all checks with TAG
- <b>delete_clusters_by_tag</b> - Delete all clusters with TAG
- <b>delete_graphs_by_tag</b> - Delete all clusters with TAG

##E Node.js Versions for:
- create-cluster.js
- deactivate-complete-lost-allocs.js
- deactivate-metrics.js
- deactivate-complete-allocs.js
- deactivate-lost-allocs.js
- find-running-allocations.js
