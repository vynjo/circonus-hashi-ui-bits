variable "account_name" {
  description = "The name of the Circonus Account to use"
}

/*variable "alert_slack_team_id" {
  description = "The ID of the Slack Team"
}

variable "alert_slack_channel_name" {
  description = "The name of the Slack channel to notify (within the Slack Team)"
}*/

/*variable "alert_slack_escalate_channel_name" {
  description = <<EOF
The name of the Slack channel to notify (within the Slack Team) when an escalation needs to occur.
EOF
}*/

variable "api_token" {}

variable "collectors_enterprise" {
  type = "list"
}

variable "collectors_public" {
  type = "list"
}

variable "check_name" {}

variable "environment" {
  description = "Specify the environment (e.g. prod, staging, etc)"
  type        = "string"
}

variable "limit_metric_name" {
  default = "_usage`0`_limit"
}

variable "check_notes" {
  default = "A check to collect telemetry regarding the metric usage of a Circonus account."
}

variable "target" {
  default = "api.circonus.com"
}

variable "used_metric_name" {
  default = "_usage`0`_used"
}

output "id" {
  value = "${circonus_check.usage.id}"
}

output "metric_names" {
  value = "${circonus_check.usage.metric.*.name}"
}
