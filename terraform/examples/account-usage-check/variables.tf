
### replace vynjo with your account name.
variable "account_name" {
  description = "The name of the Circonus Account to use"
  default = "Vynjo"
}
variable "circonus_account_name" {
  description = "The name of the Circonus Account"
  default = "vynjo"
}

### Replace with your API Token, either account level or user level tokens work.
variable "api_token" {
  default = "9598206a-25fb-c279-f37d-9598206a9598206a"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "check_name" {
     default = "Metric Usage"
}

variable "environment" {
  description = "Specify the environment (e.g. prod, staging, etc)"
  type        = "string"
  default = "development OR prod, etc. HERE"
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

### To find the team ID, you will need to create a slack contact group, then find the equvilant of
### \"team\":\"T7E3X6R0S\", replacing T7E3X6R0S with your team id
variable "alert_slack_team_id" {
  description = "The ID of the Slack Team"
  default = "T7E3X6R0S"
}

### Change circonus-alerts to the channel, in your team, where you want alerts to show up
variable "alert_slack_channel_name" {
  description = "The name of the Slack channel to notify (within the Slack Team)"
  default = "#circonus-alerts"
}

### (same) Change circonus-alerts to the channel, in your team, where you want alerts to show up
variable "alert_slack_escalate_channel_name" {
  description = <<EOF
The name of the Slack channel to notify (within the Slack Team) when an escalation needs to occur.
EOF
  default = "#circonus-alerts"
}

output "id" {
  value = "${circonus_check.usage.id}"
}

output "metric_names" {
  value = "${circonus_check.usage.metric.*.name}"
}
