resource "circonus_check" "serf-member-flap" {
  name   = "Serf Member Flap (Merged Histogram)"
  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`serf`member`flap* (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}", "subsystem:serf", "use:error"]
    type = "histogram"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_graph" "serf-member-flap" {
  name        = "Consul Serf Messages Flap Messages (Merged Histogram)"
  description = "The aggregate number of member flaps"
  line_style  = "stepped"

  metric {
    check       = "${circonus_check.serf-member-flap.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis        = "left"
    color       = "#657aa6"
    name        = "Serf Flaps"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_check" "serf-coordinate-adjustment" {
  name = "Consul Serf Coordinate Adjustment (Merged Histogram)"

  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`serf`coordinate`adjustment-ms* (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}", "subsystem:serf"]
    type = "histogram"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_graph" "serf-coordinate-adjustment" {
  name       = "Consul Serf Coordinate Adjustment (Merged Histogram)"
  line_style = "stepped"

  metric {
    check       = "${circonus_check.serf-coordinate-adjustment.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis        = "left"
    color       = "#657aa6"
    name        = "Coordinate Adjustments (ms)"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_check" "serf-messages-received" {
  name = "Consul Serf Messages Received (Merged Histogram)"

  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`serf`msgs`received* (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}", "subsystem:serf"]
    type = "histogram"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_check" "serf-messages-sent" {
  name = "Consul Serf Messages Sent (Merged Histogram)"

  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`serf`msgs`sent* (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}", "subsystem:serf"]
    type = "histogram"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}

resource "circonus_graph" "serf-messages-sent-received" {
  name        = "Consul Serf Messages Sent and Received (Merged Histogram)"
  description = "The aggregate number of sent/received Serf messages"
  line_style  = "stepped"

  metric {
    check       = "${circonus_check.serf-messages-sent.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis        = "left"
    color       = "#657aa6"
    name        = "Serf Messages Sent"
  }

  metric {
    check       = "${circonus_check.serf-messages-received.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis        = "left"
    color       = "#5fa54e"
    name        = "Serf Messages Received"
  }

  tags = ["${var.consul_tags}", "subsystem:serf"]
}
