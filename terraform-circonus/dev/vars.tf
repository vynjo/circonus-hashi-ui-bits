/*variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}*/

variable "circonus_account_name" {
  description = "The name of the Circonus Account"
  default = "Hashicorp-dev"
}

variable "circonus_api_token" {
  default = "2c1518f9-10ae-49b8-9b04-c386616aae09"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "environment" {
  default = "development"
}
