resource "circonus_metric_cluster" "cpu-kern" {
  name        = "${var.human_name} CPU Kernel"
  description = "${var.cpu-kernel-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`system"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`system"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization"]

  # unit = "%"
}

resource "circonus_metric_cluster" "cpu-throttled-periods" {
  name        = "${var.human_name} CPU Throttled Periods"
  description = "${var.cpu-throttled-periods-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`throttled_periods"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`throttled_periods"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:saturation"]
}

resource "circonus_metric_cluster" "cpu-throttled-time" {
  name        = "${var.human_name} CPU Throttled Time"
  description = "${var.cpu-throttled-time-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`throttled_time"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`throttled_time"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:saturation"]

  # unit = "nanoseconds"
}

resource "circonus_metric_cluster" "cpu-total-percent" {
  name        = "${var.human_name} CPU Total Percentage"
  description = "${var.cpu-total-percentage-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`total_percent"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`total_percent"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization"]

  # unit = "%"
}

resource "circonus_metric_cluster" "cpu-total-ticks" {
  name        = "${var.human_name} CPU Total Ticks"
  description = "${var.cpu-total-ticks-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`total_ticks"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`total_ticks"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization"]

  # unit = "ticks"
}

resource "circonus_metric_cluster" "cpu-user" {
  name        = "${var.human_name} CPU Userland"
  description = "${var.cpu-user-description}"

  query {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`cpu`user"

    type = "average"
  }

  query {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`user"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization"]

  # unit = "ticks"
}

resource "circonus_graph" "cpu" {
  name        = "Job ${var.job_name}-${var.task_group}: CPU usage Aggregate"
  description = "The cluster-wide aggregate of CPU time, both kernel and userland, that task group ${var.task_group} has consumed in the job ${var.human_name} (${var.job_name})."

  metric_cluster {
    query     = "${circonus_metric_cluster.cpu-user.id}"
    aggregate = "sum"
    axis      = "left"
    color     = "#657aa6"
    name      = "Userland CPU"
  }

  metric_cluster {
    query     = "${circonus_metric_cluster.cpu-kern.id}"
    aggregate = "sum"
    axis      = "left"
    color     = "#7e17d8"
    name      = "Kernel CPU"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization"]
}

resource "circonus_graph" "memory-aggregate" {
  name        = "Job ${var.job_name}-${var.task_group}: RSS memory Aggregate"
  description = "The cluster-wide aggregate of RSS memory consumed by the task group ${var.task_group} in the job ${var.human_name} (${var.job_name})."

  metric_cluster {
    query     = "${circonus_metric_cluster.memory-rss.id}"
    aggregate = "sum"
    axis      = "left"
    color     = "#4fa18e"
    name      = "Memory RSS"
  }

  metric_cluster {
    query     = "${circonus_metric_cluster.memory-cache.id}"
    aggregate = "sum"
    axis      = "left"
    color     = "#b5c52d"
    name      = "Memory Cache"
  }

  metric_cluster {
    query     = "${circonus_metric_cluster.memory-kernel-usage.id}"
    aggregate = "sum"
    axis      = "left"
    color     = "#af5779"
    name      = "Kernel Usage"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]
}

resource "circonus_graph" "memory-per-task" {
  name        = "Job ${var.job_name}-${var.task_group}: RSS memory per task"
  description = "Cluster-wide view of the RSS memory usage for each task in task group ${var.task_group} in the job ${var.human_name} (${var.job_name})."

  metric_cluster {
    query     = "${circonus_metric_cluster.memory-rss-active.id}"
    name      = "Memory RSS"
    aggregate = "none"
    color     = "#4fa18e"
    axis      = "left"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_metric_cluster.memory-rss.cluster_id}
resource "circonus_metric_cluster" "memory-cache" {
  name        = "${var.human_name} Memory Cache"
  description = "${var.memory-cache-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`cache"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`cache"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]

  # unit = "bytes"
}

resource "circonus_metric_cluster" "memory-kernel-max-usage" {
  name        = "${var.human_name} Memory Kernel Max Usage"
  description = "${var.memory-kernel-max-usage-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`kernel_max_usage"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`kernel_max_usage"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]
}

resource "circonus_metric_cluster" "memory-kernel-usage" {
  name        = "${var.human_name} Memory Kernel Usage"
  description = "${var.memory-kernel-usage-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`kernel_usage"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`kernel_usage"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]

  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_metric_cluster.memory-rss.cluster_id}
resource "circonus_metric_cluster" "memory-max-usage" {
  name        = "${var.human_name} Memory Max Usage"
  description = "${var.memory-max-usage-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`max_usage"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`max_usage"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]

  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_metric_cluster.memory-rss.cluster_id}
resource "circonus_metric_cluster" "memory-swap" {
  name        = "${var.human_name} Memory Swap"
  description = "${var.memory-swap-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`swap"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`swap"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:saturation"]

  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_metric_cluster.memory-rss.cluster_id}
resource "circonus_metric_cluster" "memory-rss" {
  name        = "${var.human_name} Memory RSS"
  description = "${var.memory-rss-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`rss"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`rss"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_metric_cluster.memory-rss.cluster_id}
resource "circonus_metric_cluster" "memory-rss-active" {
  name        = "${var.human_name} Memory RSS (Active)"
  description = "${var.memory-rss-description}"

  query {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    definition = "*`${var.job_name}-${var.task_group}`memory`rss (active:1)"

    type = "average"
  }

  query {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    definition = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`rss (active:1)"

    type = "average"
  }

  tags = ["${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization"]
}
