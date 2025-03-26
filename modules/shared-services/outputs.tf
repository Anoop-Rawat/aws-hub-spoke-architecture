# modules/shared-services/outputs.tf
output "security_group_id" {
  value = aws_security_group.shared.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.main.id
}