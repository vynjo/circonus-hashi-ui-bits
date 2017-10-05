variable "aws_access_key_id" {
  type = "string"
}

variable "aws_secret_access_key" {
  type = "string"
}

variable "check_name" {
  type = "string"
}

variable "check_notes" {
  type    = "string"
  default = ""
}

variable "collectors" {
  type = "list"
}

variable "namespace" {
  type    = "string"
  default = "AWS/RDS"
}
