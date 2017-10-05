variable "consul_tags" {
  type    = "list"
  default = ["app:consul", "app:consul-server", "source:consul"]
}
