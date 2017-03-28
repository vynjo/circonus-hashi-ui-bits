resource "circonus_graph" "runtime-gc-pause" {
  name        = "Consul GC Pause Time: ${var.hostname}"
  description = "The amount of time that ${var.hostname}'s Consul has spent paused in the Go GC"
  line_style  = "stepped"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-gc-pause.name}"
    metric_type = "${circonus_metric.runtime-gc-pause.type}"
    axis        = "left"
    color       = "#7e17d8"
    name        = "GC Pause Time"
  }

  left {
    max = "${var.runtime_gc_pause_max}"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:go", "subsystem:gc"]
}

resource "circonus_graph" "runtime-gc-pause-line" {
  name        = "Consul GC Pause Time Line: ${var.hostname}"
  description = "The amount of time that ${var.hostname}'s Consul has spent paused in the Go GC"
  graph_style = "line"
  line_style  = "stepped"

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-total-gc-pause.name}"
    metric_type = "${circonus_metric.runtime-total-gc-pause.type}"
    axis        = "left"
    color       = "#5fa54e"
    function    = "derive"
    name        = "GC Pause Time"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-total-gc-runs.name}"
    metric_type = "${circonus_metric.runtime-total-gc-runs.type}"
    axis        = "right"
    color       = "#8e69a2"
    function    = "derive"
    name        = "Number of GC Runs"
  }

  left {
    logarithmic = 10
  }

  right {
    logarithmic = 10
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:go", "subsystem:gc"]
}

resource "circonus_graph" "runtime-memory" {
  name = "Consul Memory Usage: ${var.hostname}"

  description = <<EOF
This measures the number of bytes allocated by the Consul process on ${var.hostname}. This may
burst from time to time but should return to a steady state value.
EOF

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-alloc-bytes.name}"
    metric_type = "${circonus_metric.runtime-alloc-bytes.type}"
    color       = "#4fa18e"
    name        = "Bytes Allocated (and not freed)"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-sys-bytes.name}"
    metric_type = "${circonus_metric.runtime-sys-bytes.type}"
    color       = "#b5c52d"
    name        = "Bytes Obtained from the System"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory", "subsystem:go", "subsystem:gc"]
}

resource "circonus_graph" "runtime-allocator" {
  name = "Consul Memory Allocations: ${var.hostname}"

  description = <<EOF
This measures the number of malloc vs free counts by the Consul process on ${var.hostname}. This may
burst from time to time but should return to a steady state value.
EOF

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-free-count.name}"
    metric_type = "${circonus_metric.runtime-free-count.type}"
    color       = "#5fa54e"
    function    = "derive"
    name        = "Number of free(3) calls/second"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-malloc-count.name}"
    metric_type = "${circonus_metric.runtime-malloc-count.type}"
    color       = "#af5779"
    function    = "derive"
    name        = "Number of malloc(3) calls/second"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory", "subsystem:go", "subsystem:gc"]
}

resource "circonus_graph" "runtime-go-vs-objects" {
  name = "Consul Go Routines vs Object Count: ${var.hostname}"

  description = <<EOF
This tracks the number of running goroutines in ${var.hostname}'s Consul process
and is a general load pressure indicator. This may burst from time to time but
  should return to a steady state value.

Heap objects is the number of objects allocated on the heap and is a general
memory pressure indicator. This may burst from time to time but should return to
a steady state value.
EOF

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-num-goroutines.name}"
    metric_type = "${circonus_metric.runtime-num-goroutines.type}"
    axis        = "left"
    color       = "#4fa18e"
    name        = "Number of goroutines"
  }

  metric {
    check       = "${circonus_check.consul.check_by_collector[var.collector_id]}"
    metric_name = "${circonus_metric.runtime-heap-objects.name}"
    metric_type = "${circonus_metric.runtime-heap-objects.type}"
    axis        = "right"
    color       = "#af5779"
    name        = "Total number of allocated objects on the heap"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory", "subsystem:go", "subsystem:gc"]
}
