variable "host" {
  description = "host url"
  type = string
}
variable "client_certificate" {
  description = "client_certificate"
  type = string
}
variable "client_key" {
  description = "client_key"
  type = string
}
variable "cluster_ca_certificate" {
  description = "cluster_ca_certificate"
  type = string
}

variable "namespace" {
  description = "namespace"
  type = string
  default = "default"
}

variable "module_abspath" {
  description = "module_abspath"
  type = string
}