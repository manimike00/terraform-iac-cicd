output "security_group_name" {
  value = aws_security_group.private_sg.name
}

output "security_group_id" {
  value = aws_security_group.private_sg.id
}

output "security_group_arn" {
  value = aws_security_group.private_sg.arn
}