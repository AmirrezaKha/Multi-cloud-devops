# variables.tf
variable "requester_vpc_id" {}
variable "accepter_vpc_id" {}
variable "peer_region" {}
variable "tags" {
  type    = map(string)
  default = {}
}