# *-description's taken from https://www.nomadproject.io/docs/agent/telemetry.html

variable "cpu-kernel-description" {
  type    = "string"
  default = "Total CPU resources consumed by the task in the system space"
}

variable "cpu-throttled-periods-description" {
  type    = "string"
  default = "Number of periods when the container hit its throttling limit (`nr_throttled`)"
}

variable "cpu-throttled-time-description" {
  type    = "string"
  default = "Total time that the task was throttled (`throttled_time`)"
}

variable "cpu-total-percentage-description" {
  type    = "string"
  default = "Total CPU resources consumed by the task across all cores"
}

variable "cpu-total-ticks-description" {
  type    = "string"
  default = "CPU ticks consumed by the process in the last collection interval"
}

variable "cpu-user-description" {
  type    = "string"
  default = "An aggregation of all userland CPU usage for this Nomad job."
}

variable "environment" {
  type = "string"
}

variable "human_name" {
  description = "The human-friendly name for this job"
  type        = "string"
}

variable "job_name" {
  type        = "string"
  description = "The Nomad Job Name (or its prefix)"
}

variable "job_tags" {
  type        = "list"
  description = "Tags that should be added to this job's resources"
}

variable "memory-cache-description" {
  type    = "string"
  default = "Amount of memory cached by the task"
}

variable "memory-kernel-usage-description" {
  type    = "string"
  default = "Amount of memory used by the kernel for this task"
}

variable "memory-max-usage-description" {
  type    = "string"
  default = "Maximum amount of memory ever used by the kernel for this task"
}

variable "memory-kernel-max-usage-description" {
  type    = "string"
  default = "Maximum amount of memory ever used by the tasks in this job."
}

variable "memory-rss-description" {
  type    = "string"
  default = "An aggregation of all resident memory for this Nomad job."
}

variable "memory-swap-description" {
  type    = "string"
  default = "Amount of memory swapped by the task"
}

variable "nomad-tags" {
  type    = "list"
  default = ["source:nomad"]
}

variable "task_group" {
  type        = "string"
  description = "The name of the task group"
}
