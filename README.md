# circonus-hashi-ui-bits
<h2>Tools for Circonus and Hashicorp integration</h2>

Current tools include:

### Terraform (!!!)

<p>Finally, Monitoring as Code! The Terraform repo for all things Circonus. It is actively being built out.</p>

[Details here](https://github.com/vynjo/circonus-hashi-ui-bits/tree/master/terraform-circonus)

## Configuration info for your Consul, Nomad or Vault instance
 - tags are simply samples, please feel free to change accordingly
 - [API token can be created in your Circonus account](https://login.circonus.com/user/tokens)

### Consul Server - add the following to your server.hcl file:
```
{
	"telemetry": {
		"circonus_api_token": "CIRCONUS-API-TOKEN"
		"circonus_check_tags": "type:server, service:consul"
	}
}
```
### Consul Client - add the following to your client.hcl file:
```
{
	"telemetry": {
		"circonus_api_token": "CIRCONUS_API_TOKEN"
		"circonus_check_tags": "type:client, service:consul"
	}
}
```
### Nomad Client - add the following to your client.hcl file:
```
telemetry {
	circonus_api_token = "CIRCONUS_API_TOKEN"
	publish_allocation_metrics = "true"
	publish_node_metrics = "true"
	circonus_check_tags = "type:client, service:nomad"
}
```
### Nomad Server - add the following to your server.hcl file:
```
telemetry {
	circonus_api_token = "CIRCONUS-API-TOKEN"
	circonus_check_tags = "type:server, service:nomad"
}
```
### And lastly, your Vault Server - add the following to your vault.hcl file:
```
telemetry {
	circonus_api_token = "CIRCONUS-API-TOKEN"
	circonus_check_tags = "type:server, service:vault"
}
```
More configuring information, as well as a full stack example, can be found in the hashiconf-napa-2016 github repo
- https://github.com/vynjo/hashiconf-napa-2016
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
