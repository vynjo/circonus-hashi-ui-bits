provider "circonus" {
  key     = "${var.circonus_api_token}"
  api_url = "${var.circonus_api_url}"
}
