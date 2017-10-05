resource "circonus_contact_group" "circonus-owners-slack-escalation" {
  name = "Circonus Owners (${title(var.environment)} Slack Escalation)"

  slack {
    channel = "${var.alert_slack_escalate_channel_name}"
    team = "${var.alert_slack_team_id}"
    username = "Circonus"
    buttons = true
  }

  tags = [
    "author:terraform",
    "environment:${var.environment}",
    "owner:infraplat",
  ]
}

resource "circonus_contact_group" "circonus-owners-slack" {
  name = "Circonus Owners (${title(var.environment)} Slack)"

  slack {
    channel = "${var.alert_slack_channel_name}"
    team = "${var.alert_slack_team_id}"
    username = "Circonus"
    buttons = true
  }

  aggregation_window = "5m"

  alert_option {
    severity = 1
    reminder = "15m"
    escalate_to = "${circonus_contact_group.circonus-owners-slack-escalation.id}"
    escalate_after = "1h"
  }

  alert_option {
    severity = 2
    reminder = "1h"
    escalate_to = "${circonus_contact_group.circonus-owners-slack-escalation.id}"
    escalate_after = "6h"
  }

  alert_option {
    severity = 3
    reminder = "6h"
  }

  alert_option {
    severity = 4
    reminder = "12h"
  }

  alert_option {
    severity = 5
    reminder = "24h"
  }

  tags = [
    "author:terraform",
    "environment:${var.environment}",
    "owner:infraplat",
  ]
}
