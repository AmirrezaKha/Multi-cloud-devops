# variables.tf
variable "synapse_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "storage_fs_id" {}
variable "admin_user" {}
variable "admin_pass" {}
variable "tags" {
  type    = map(string)
  default = {}
}