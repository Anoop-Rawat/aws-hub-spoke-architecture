# modules/shared-services/main.tf
resource "aws_security_group" "shared" {
  vpc_id      = var.vpc_id
  name        = "${var.environment}-shared-sg"
  description = "Security group for shared services"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Add more shared services as needed (NAT Gateway, Transit Gateway, etc.)

# modules/shared-services/main.tf
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "${var.environment}-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]  # Place NAT in first public subnet

  tags = {
    Name = "${var.environment}-nat-gateway"
  }

  depends_on = [aws_eip.nat]
}

