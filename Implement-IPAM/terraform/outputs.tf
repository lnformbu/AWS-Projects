
output "ipam_id" {
  description = "The ID of the IPAM resource"
  value       = awscc_ec2_ipam.main.id
}


output "private_scope_id" {
  description = "The default private scope ID of the IPAM"
  value       = awscc_ec2_ipam.main.private_default_scope_id
}


output "root_ipam_pool_id" {
  description = "The ID of the root IPAM pool"
  value       = awscc_ec2_ipam_pool.root.ipam_pool_id
}


output "useast1_ipam_pool_id" {
  description = "The ID of the us-east-1 regional IPAM pool"
  value       = awscc_ec2_ipam_pool.useast1.ipam_pool_id
}

output "useast2_ipam_pool_id" {
  description = "The ID of the us-east-2 regional IPAM pool"
  value       = awscc_ec2_ipam_pool.useast2.ipam_pool_id
}

output "useast1_vpc_id" {
  description = "The ID of the VPC in the us-east-1 region"
  value       = aws_vpc.useast1.id
}

output "useast2_vpc_id" {
  description = "The ID of the VPC in the us-east-2 region"
  value       = aws_vpc.useast2.id
}
