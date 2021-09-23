variable "resource_group" {
  description = "resource_group"
  type = object({
    name    = string
    location = string
  })
}

variable "prefix" {
  description = "k8 prefix"
  type = string
}