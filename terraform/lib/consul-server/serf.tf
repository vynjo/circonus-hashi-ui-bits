resource "circonus_graph" "serf-coordinate-adjustment" {
  name = "Consul Serf Coordinate Adjustment: ${var.hostname}"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-coordinate-adjustment.name}"
    metric_type = "${circonus_metric.serf-coordinate-adjustment.type}"
    axis        = "left"
    color       = "#7e17d9"
    name        = "Coordinate Adjustment Time (ms)"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
}

resource "circonus_graph" "serf-events" {
  name       = "Consul Serf Events: ${var.hostname}"
  line_style = "interpolated"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-events.name}"
    metric_type = "${circonus_metric.serf-events.type}"
    axis        = "left"
    color       = "#b5c52d"
    name        = "Serf Events"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-events-consul-new-leader.name}"
    metric_type = "${circonus_metric.serf-events-consul-new-leader.type}"
    axis        = "left"
    color       = "#4fa18e"
    name        = "${var.hostname} became New Consul Leader"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-member-failed.name}"
    metric_type = "${circonus_metric.serf-member-failed.type}"
    axis        = "left"
    color       = "#af5779"
    name        = "${var.hostname} observed N members fail"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-member-flap.name}"
    metric_type = "${circonus_metric.serf-member-flap.type}"
    axis        = "left"
    color       = "#b5c52d"
    name        = "${var.hostname} observed N members flap"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-member-join.name}"
    metric_type = "${circonus_metric.serf-member-join.type}"
    axis        = "left"
    color       = "#5fa54e"
    name        = "${var.hostname} observed N members join"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-member-left.name}"
    metric_type = "${circonus_metric.serf-member-left.type}"
    axis        = "left"
    color       = "#8e69a2"
    name        = "${var.hostname} observed N members leave"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft", "subsystem:serf"]
}

resource "circonus_graph" "serf-member-flap" {
  name       = "Consul Serf Member Flaps: ${var.hostname}"
  line_style = "interpolated"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-member-flap.name}"
    metric_type = "${circonus_metric.serf-member-flap.type}"
    axis        = "left"
    color       = "#7e17d8"
    name        = "Number of flaps"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
}

resource "circonus_graph" "serf-msgs" {
  name       = "Consul Serf Messages Sent and Received: ${var.hostname}"
  line_style = "interpolated"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-msgs-sent.name}"
    metric_type = "${circonus_metric.serf-msgs-sent.type}"
    axis        = "left"
    color       = "#7e17d8"
    name        = "Number of Messages Sent"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-msgs-received.name}"
    metric_type = "${circonus_metric.serf-msgs-received.type}"
    axis        = "left"
    color       = "#657aa7"
    name        = "Number of Messages Received"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
}

resource "circonus_graph" "serf-snapshots" {
  name       = "Consul Serf Snapshot Operations: ${var.hostname}"
  line_style = "interpolated"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-snapshot-append-line.name}"
    metric_type = "${circonus_metric.serf-snapshot-append-line.type}"
    axis        = "left"
    color       = "#7e17d8"
    name        = "Number of Snapshot Append Line operations"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.serf-snapshot-compact.name}"
    metric_type = "${circonus_metric.serf-snapshot-compact.type}"
    axis        = "right"
    color       = "#657aa7"
    name        = "Number of Snapshot Compact operations"
  }

  left {
    max = 1
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
}
