
output "aws_instance_public_dns" {
  description = "instance public doman name server"
  value       = aws_instance.nginx.public_dns
}
