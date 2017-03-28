module "circonus" {
  source = "../lib/circonus"

  account_name                      = "${var.circonus_account_name}"
  api_token                         = "${var.circonus_api_token}"
  collectors_enterprise             = ["${data.circonus_collector.GCloud-ns-3c.id}"]
  collectors_public                 = ["${data.circonus_collector.ashburn.id}", "${data.circonus_collector.chicago.id}"]
  check_name                        = "Circonus SaaS Check"
  environment                       = "${var.environment}"
}

module "consul-cluster" {
  source = "../lib/consul-cluster"
}

module "consul-server1" {
  source = "../lib/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname     = "ns-1"
  secret       = "c2b8d57778aed918"
}

module "consul-server2" {
  source = "../lib/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname     = "ns-2"
  secret       = "2ec0ad8a1123631d"
}

module "consul-server3" {
  source = "../lib/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname     = "ns-3c"
  secret       = "6ef2a5aca33a09eb"
}
