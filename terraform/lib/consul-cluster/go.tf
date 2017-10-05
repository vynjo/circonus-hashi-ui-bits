resource "circonus_check" "runtime-gc-pause" {
  name   = "Consul's runtime GC Pause Time (Merged Histogram)"
  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric:histogram("consul`runtime`gc_pause_ns* (active:1)") | histogram:merge()
EOF
  }

  metric {
    name = "output[1]"
    tags = ["${var.consul_tags}"]
    type = "histogram"
    unit = "nanoseconds"
  }

  tags = ["${var.consul_tags}", "subsystem:go"]
}

resource "circonus_graph" "runtime-gc-pause" {
  name        = "Consul GC Pause Time (all agents)"
  description = "The amount of time that Consul spends paused due to Go's GC (in aggregate across all Consul agents)"
  line_style  = "stepped"

  metric {
    check       = "${circonus_check.runtime-gc-pause.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis        = "left"
    color       = "#7e17d8"
    name        = "GC Pause Time"
  }

  left {
    # Cap the max Y axis to ~3ms to get a really useful distribution.  If
    # necessary this value can be removed or increased as necessary.
    max = "${3 * 1000 * 1000}"
  }

  tags = ["${var.consul_tags}", "subsystem:go", "subsystem:gc"]
}
