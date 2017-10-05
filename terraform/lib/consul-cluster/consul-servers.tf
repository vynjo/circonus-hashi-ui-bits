resource "circonus_metric_cluster" "catalog-service-queries" {
  name        = "Aggregate Consul Catalog Service Queries"
  description = "Aggregate catalog queries for Consul services on all consul servers"

  query {
    definition = "consul`consul`catalog`service`query`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "subsystem:catalog"]
}

resource "circonus_metric_cluster" "catalog-service-query-tags" {
  name        = "Aggregate Consul Catalog Queries for Service Tags"
  description = "Aggregate catalog queries for Consul service tags on all consul servers"

  query {
    definition = "consul`consul`catalog`service`query-tag`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "subsystem:catalog"]
}

resource "circonus_check" "kv-get" {
  name   = "Consul KV Get Latencies (Merged Histogram)"
  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`consul`http`GET`v1`kv`_ (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}", "subsystem:kv"]
    type = "histogram"
    unit = "nanoseconds"
  }

  tags = ["${var.consul_tags}", "subsystem:kv"]
}

resource "circonus_metric_cluster" "raft-replication-append-entries-logs" {
  name        = "Aggregate Consul Raft Replication Append Entries Logs"
  description = "Number of append entries the entire Consul Cluster has sent out to its peers"

  query {
    definition = "consul`raft`replication`appendEntries`logs`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "subsystem:raft"]
}

resource "circonus_metric_cluster" "raft-replication-append-entries-rpc" {
  name        = "Aggregate Consul Raft Replication Append Entry RPC Messages"
  description = "Number of append entry RPC messages sent out to all Consul Servers in the cluster"

  query {
    definition = "consul`raft`replication`appendEntries`rpc`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "subsystem:raft", "interface:rpc"]
}

resource "circonus_metric_cluster" "raft-replication-heartbeats" {
  name        = "Aggregate Consul Raft Replication Heartbeat Messages"
  description = "Number of replication heartbeat messages sent all Consul Servers in the cluster"

  query {
    definition = "consul`raft`replication`heartbeat`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "subsystem:raft"]
}
