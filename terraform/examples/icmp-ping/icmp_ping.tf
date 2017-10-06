
/* You can specify an Enterprise Collector by using the following instead:
    id = "${var.collectors_enterprise[0]}"
*/
resource "circonus_check" "icmp_ping" {
  collector {
    id = "/broker/2512"
  }

  name       = "ICMP Latency from Public Collector"
  notes      = <<EOF
This check measures the network latency between a Collector and a target host.
EOF

  icmp_ping {
    count = 1
  }

  target = "${var.ping_target}"

  /*target = "${var.ping_target}"*/

  period = "60s"

  metric {
    name = "${circonus_metric.icmp_minimum.name}"
    tags = ["${circonus_metric.icmp_minimum.tags}"]
    type = "${circonus_metric.icmp_minimum.type}"
    unit = "${circonus_metric.icmp_minimum.unit}"
    active = true
  }
  metric {
    name = "${circonus_metric.icmp_available.name}"
    tags = ["${circonus_metric.icmp_available.tags}"]
    type = "${circonus_metric.icmp_available.type}"
    unit = "${circonus_metric.icmp_available.unit}"
    active = true
  }
  metric {
    name = "${circonus_metric.icmp_average.name}"
    tags = ["${circonus_metric.icmp_average.tags}"]
    type = "${circonus_metric.icmp_average.type}"
    unit = "${circonus_metric.icmp_average.unit}"
    active = true
  }
  metric {
    name = "${circonus_metric.icmp_count.name}"
    tags = ["${circonus_metric.icmp_count.tags}"]
    type = "${circonus_metric.icmp_count.type}"
    unit = "${circonus_metric.icmp_count.unit}"
    active = true
  }
  metric {
    name = "${circonus_metric.icmp_maximum.name}"
    tags = ["${circonus_metric.icmp_maximum.tags}"]
    type = "${circonus_metric.icmp_maximum.type}"
    unit = "${circonus_metric.icmp_maximum.unit}"
    active = true
  }

  tags = [ "${var.ping_tags}" ]
}

resource "circonus_metric" "icmp_minimum" {
  name = "minimum"
  type = "numeric"
  unit = "seconds"
  tags = [ "${var.ping_tags}" ]
}
resource "circonus_metric" "icmp_available" {
  name = "available"
  type = "numeric"
  unit = "null"
  tags = [ "${var.ping_tags}" ]
}
resource "circonus_metric" "icmp_average" {
  name = "average"
  type = "numeric"
  unit = "seconds"
  tags = [ "${var.ping_tags}" ]
}
resource "circonus_metric" "icmp_count" {
  name = "count"
  type = "numeric"
  unit = "null"
  tags = [ "${var.ping_tags}" ]
}
resource "circonus_metric" "icmp_maximum" {
  name = "maximum"
  type = "numeric"
  unit = "seconds"
  tags = [ "${var.ping_tags}" ]
}

/*
The following are 2 graphs which are samples you can customize, duplicate, or throw away.
*/
resource "circonus_graph" "icmp_ping" {
  name = "Ping Latency to ${var.ping_target} from Ashburn, VA Broker"
  description = "The minimum and maximum ping time between ${var.ping_target} and Ashburn, VA Broker"
  line_style = "stepped"

  metric {
    check = "${circonus_check.icmp_ping.checks[0]}"
    metric_name = "minimum"
    metric_type = "numeric"
    axis = "left"
    color = "#17b6d6"
    name = "Ping Minimum Latency"
  }
  metric {
    check = "${circonus_check.icmp_ping.checks[0]}"
    metric_name = "maximum"
    metric_type = "numeric"
    axis = "left"
    color = "#17b6d6"
    name = "Ping Maximum Latency"
  }

  tags = [ "${var.ping_tags}" ]
}

resource "circonus_graph" "icmp_ping_roundtrip" {
  name = "Ping Roundtrip to ${var.ping_target} from Ashburn, VA Broker"
  description = "The round trip ping time between ${var.ping_target} and Ashburn, VA Broker"
  line_style = "stepped"

  metric {
    check = "${circonus_check.icmp_ping.checks[0]}"
    metric_name = "average"
    metric_type = "numeric"
    axis = "left"
    color = "#17b6d6"
    name = "Ping Roundtrip Time"
  }

  tags = [ "${var.ping_tags}" ]
}
