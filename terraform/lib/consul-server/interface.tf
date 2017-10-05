variable "collector_id" {
  description = "The ID of the collector receiving the stream of metrics"
  type        = "string"
}

variable "consul_tags" {
  type    = "list"
  default = ["app:consul", "app:consul-server", "source:consul"]
}

variable "runtime_gc_pause_max" {
  # Cap the max Y axis to ~3ms to get a really useful distribution.  If
  # necessary this value can be removed or increased as necessary.
  default = 3000000

  description = "The max Y value to use for runtime GC pauses"
}

variable "hostname" {
  type        = "string"
  description = "Consul host under observation"
}

variable "secret" {
  type        = "string"
  description = "The secret required to submit metrics on behalf of a host"
}
