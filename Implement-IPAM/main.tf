#----------------------------------------------------------------------------------------------------
# Define an IP Address Management (IPAM) resource
#----------------------------------------------------------------------------------------------------

resource "awscc_ec2_ipam" "main" {
  operating_regions = [ # Specify the operating regions for the IPAM
    {
      region_name = "us-east-1" # First operating region: US East (N. Virginia)
    },
    {
      region_name = "us-east-2" # Second operating region: US East (Ohio)
    }
  ]

  tags = [{ # Tags for organizing and identifying the IPAM resource
    key   = "Name"
    value = "global-ipam"
  }]
}

#----------------------------------------------------------------------------------------------------
# Create an IPAM pool acting as the root pool for IPv4 address allocation
#----------------------------------------------------------------------------------------------------

resource "awscc_ec2_ipam_pool" "root" {
  address_family = "ipv4"                                       # Specify IPv4 as the address family
  ipam_scope_id  = awscc_ec2_ipam.main.private_default_scope_id # Use the default private scope ID from the main IPAM
  auto_import    = false                                        # Disable automatic import of CIDR blocks

  provisioned_cidrs = [ # Define the CIDR block to allocate in the root pool
    {
      cidr = "10.0.0.0/16" # The CIDR block for the root IPAM pool
    }
  ]

  tags = [{ # Tags for easy identification of the root IPAM pool
    key   = "Name"
    value = "top-level-pool"
  }]
}

#----------------------------------------------------------------------------------------------------
# Create a regional IPAM pool for the us-east-1 region
#----------------------------------------------------------------------------------------------------

resource "awscc_ec2_ipam_pool" "useast1" {
  address_family      = "ipv4"                                       # Specify IPv4 as the address family
  auto_import         = false                                        # Disable automatic import of CIDR blocks
  ipam_scope_id       = awscc_ec2_ipam.main.private_default_scope_id # Use the default private scope ID from the main IPAM
  locale              = "us-east-1"                                  # Set the locale to US East (N. Virginia)
  source_ipam_pool_id = awscc_ec2_ipam_pool.root.ipam_pool_id        # Link to the root IPAM pool for CIDR management

  provisioned_cidrs = [ # Define the CIDR block for the us-east-1 regional pool
    {
      cidr = "10.0.0.0/17" # The CIDR block for the regional pool
    }
  ]

  tags = [{ # Tags for easy identification of the us-east-1 pool
    key   = "Name"
    value = "regional-pool-us-east-1"
  }]
}

#----------------------------------------------------------------------------------------------------
# Create a regional IPAM pool for the us-east-2 region
#----------------------------------------------------------------------------------------------------

resource "awscc_ec2_ipam_pool" "useast2" {
  address_family      = "ipv4"                                       # Specify IPv4 as the address family
  auto_import         = false                                        # Disable automatic import of CIDR blocks
  ipam_scope_id       = awscc_ec2_ipam.main.private_default_scope_id # Use the default private scope ID from the main IPAM
  locale              = "us-east-2"                                  # Set the locale to US East (Ohio)
  source_ipam_pool_id = awscc_ec2_ipam_pool.root.ipam_pool_id        # Link to the root IPAM pool for CIDR management

  provisioned_cidrs = [ # Define the CIDR block for the us-east-2 regional pool
    {
      cidr = "10.0.128.0/17" # The CIDR block for the regional pool
    }
  ]

  tags = [{ # Tags for easy identification of the us-east-2 pool
    key   = "Name"
    value = "regional-pool-us-east-2"
  }]
}


#----------------------------------------------------------------------------------------------------
# Define an AWS VPC resource in the us-east-1 region
#----------------------------------------------------------------------------------------------------
resource "aws_vpc" "useast1" {
  ipv4_ipam_pool_id   = awscc_ec2_ipam_pool.useast1.id # Specify the IPv4 IPAM pool ID for CIDR block allocation
  ipv4_netmask_length = 24                             # Set the netmask length for the VPC to /24, defining the size of the CIDR block

  tags = {             # Tags for identifying and organizing the VPC
    Name = "us-east-1" # Tag name for easy reference to the us-east-1 VPC
  }
}


#----------------------------------------------------------------------------------------------------
# Define an AWS VPC resource in the us-east-2 region
#----------------------------------------------------------------------------------------------------
resource "aws_vpc" "useast2" {
  provider = aws.useast2 # Use the AWS provider configuration with the alias "useast2" for the us-east-2 region

  ipv4_ipam_pool_id   = awscc_ec2_ipam_pool.useast2.id # Specify the IPv4 IPAM pool ID for CIDR block allocation
  ipv4_netmask_length = 24                             # Set the netmask length for the VPC to /24, defining the size of the CIDR block

  tags = {             # Tags for identifying and organizing the VPC
    Name = "us-east-2" # Tag name for easy reference to the us-east-2 VPC
  }
}
