# variables.tf
variable "cluster_id" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}

variable "tags" {
  type = map(string)
  default = {}
}
