# Terraform & Circonus

##<b>Monitoring as Code</b>

This is the Terraform repo for all things Circonus. It is actively being built out.

## Usage

There is one directory per Circonus account (e.g. `dev`). This can be duplicated to have identical environments (prod, staging, etc.)

Inside of `dev` is
- a top-level `GNUMakefile` that handles the manual execution of the Terraform.
- `lib` directory with sample implementations
     - aws
     - circonus account info
     - consul cluster
     - consul server
     - nomad jobs
     - nomad server & client

Lots of TBD's:
- Vault Server monitoring
- alerts are currently commented out
     - slack
     - pagerduity
     - sms
     - email
- PostgreSQL
- MySQL
- and more circonus check types

## To configure your Consul, Nomad or Vault instances:
### Nomad Client - add the following to your client.hcl file:
`telemetry {
	circonus_api_token = "CIRCONUS_API_TOKEN"
	publish_allocation_metrics = "true"
	publish_node_metrics = "true"
	circonus_check_tags = "type:client, service:hashistack, service:nomad"
     circonus_submission_interval = "1s"
}`

### Nomad Server - add the following to your server.hcl file:
`telemetry {
	circonus_api_token = "CIRCONUS-API-TOKEN"
	circonus_check_tags = "type:server, service:hashistack, service:nomad"
     circonus_submission_interval = "1s"
}`

Specifics of configuring your Consul, Vault, and Nomad clients and servers for Circonus telemetry can be found in the hashiconf-napa-2016 github repo
- https://github.com/vynjo/hashiconf-napa-2016

Those details will be included here shortly.
