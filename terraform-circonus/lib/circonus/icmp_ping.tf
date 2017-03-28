variable "latency_tags" {
  type = "list"

  default = [
    "app:circonus",
    "author:terraform",
    "resource:network",
  ]
}

resource "circonus_check" "icmp_latency" {
  collector {
    id = "${var.collectors_enterprise[0]}"
  }

  name = "ICMP Latency from Enterprise Collector"

  notes = <<EOF
This check measures the network latency between our Enterprise Collector(s) and
api.circonus.com.
EOF

  icmp_ping {
    count = 1
  }

  target = "api.circonus.com"

  period = "60s"

  metric {
    name = "${circonus_metric.icmp_latency.name}"
    tags = ["${circonus_metric.icmp_latency.tags}"]
    type = "${circonus_metric.icmp_latency.type}"
    unit = "${circonus_metric.icmp_latency.unit}"
  }

  tags = ["${var.latency_tags}"]
}

resource "circonus_metric" "icmp_latency" {
  name = "minimum"
  type = "numeric"
  unit = "seconds"
  tags = ["${var.latency_tags}"]
}
