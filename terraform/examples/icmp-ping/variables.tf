
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
variable "circonus_api_token" {
  default = "9598206a-25fb-c279-f37d-asdfasdfadsf"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "check_name" {
     default = "ICMP_Ping"
}

variable "environment" {
  description = "Specify the environment (e.g. prod, staging, etc)"
  type        = "string"
  default = "testing"
}

variable "check_notes" {
  default = "A check to ping times."
}

variable "target" {
  default = "api.circonus.com"
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

provider "circonus" {
  key     = "${var.circonus_api_token}"
  api_url = "${var.circonus_api_url}"
}

variable "ping_tags" {
  type = "list"
  default = [
    "app:circonus",
    "author:terraform",
    "resource:network",
  ]
}

variable "ping_target" {
  default = "www.google.com"
}
# variable "collectors_enterprise" {
#   default = "${data.circonus_collector.home_broker.id}"
# }
#
# variable "collectors_public" {
#    default = ["${data.circonus_collector.ashburn.id}", "${data.circonus_collector.chicago.id}"]
# }
