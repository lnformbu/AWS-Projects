# outputs.tf - Output values in alphabetical order

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}
