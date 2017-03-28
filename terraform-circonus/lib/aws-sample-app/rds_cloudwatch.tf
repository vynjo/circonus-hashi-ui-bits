variable "rds_tags" {
  type = "list"

  default = [
    "app:postgresql",
    "app:rds",
    "author:terraform",
    "source:cloudwatch",
  ]
}

resource "circonus_metric" "cpu" {
  name = "CPUUtilization"
  tags = ["${var.rds_tags}"]
  type = "numeric"
  unit = "%"
}

resource "circonus_check" "rds_stats" {
  collector {
    id = "${var.collectors[0]}"
  }

  name  = "${var.check_name}"
  notes = "${var.check_notes}"

  cloudwatch {
    api_key    = "${var.aws_access_key_id}"
    api_secret = "${var.aws_secret_access_key}"

    dimmensions = {
      DBInstanceIdentifier = "atlas-production"
    }

    metric = [
      "CPUUtilization",
    ]

    # "DatabaseConnections",
    # "DiskQueueDepth",
    # "FreeStorageSpace",
    # "FreeableMemory",
    # "MaximumUsedTransactionIDs",
    # "NetworkReceiveThroughput",
    # "NetworkTransmitThroughput",
    # "ReadIOPS",
    # "ReadLatency",
    # "ReadThroughput",
    # "SwapUsage",
    # "TransactionLogsDiskUsage",
    # "TransactionLogsGeneration",
    # "WriteIOPS",
    # "WriteLatency",
    # "WriteThroughput",

    namespace = "${var.namespace}"
    url       = "https://monitoring.us-east-1.amazonaws.com"
  }

  metric {
    name = "${circonus_metric.cpu.name}"
    tags = ["${circonus_metric.cpu.tags}"]
    type = "${circonus_metric.cpu.type}"
    unit = "${circonus_metric.cpu.unit}"
  }

  tags = ["${var.rds_tags}"]
}
