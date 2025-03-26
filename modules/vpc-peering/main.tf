# modules/vpc-peering/main.tf
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.hub_vpc_id
  peer_vpc_id   = var.spoke_vpc_id
  auto_accept   = true

  tags = {
    Name = "peer-${var.hub_name}-to-${var.spoke_name}"
  }
}

