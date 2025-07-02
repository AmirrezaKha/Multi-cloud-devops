# main.tf
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.requester_vpc_id
  peer_vpc_id   = var.accepter_vpc_id
  auto_accept   = true
  peer_region   = var.peer_region
  tags          = var.tags
}