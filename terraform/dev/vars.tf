/*variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}*/

variable "circonus_account_name" {
  description = "The name of the Circonus Account"
  default = "YOUR ACCOUNT NAME HERE"
}

variable "circonus_api_token" {
  default = "CIRCONUS_API_TOKEN"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "environment" {
  default = "development OR prod, etc. HERE"
}
