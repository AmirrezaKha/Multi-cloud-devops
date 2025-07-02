# variables.tf
variable "account_name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "location" {
  type = string
}

variable "container_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}
