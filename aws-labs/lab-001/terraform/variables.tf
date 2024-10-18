





# variables.tf - Variables in alphabetical order

variable "ami" {
  description = <<info
  (Optional) AMI to use for the instance. Required unless launch_template is specified
   and the Launch Template specifes an AMI. If an AMI is specified in the Launch Template, 
   setting ami will override the AMI specified in the Launch Template.
  info
  type        = string
  default     = "ami-0ddc798b3f1a5117e"
}


variable "instance_type" {
  description = "(Optional) The type of instance to start"
  type        = string
  default     = "t2.micro"
}


variable "associate_public_ip_address" {
  description = "(Optional) Whether to associate a public IP address with an instance in a VPC."
  type        = bool
  default     = null
}

variable "key_name" {
  description = <<info
   (Optional) The name for the key pair. If neither key_name nor key_name_prefix is 
   provided, Terraform will create a unique key name using the prefix `terraform-`
   info
  type        = string
  default     = null

}


variable "algorithm" {
  description = <<info
  (String) Name of the algorithm to use when generating the private key. Currently-supported values are: `RSA`, `ECDSA`, `ED25519`.
  info
  type        = string
  default     = "RSA"
  validation {
    condition = contains(["RSA", "ECDSA", "ED25519"], var.algorithm)

    error_message = "Invalid algorithm. Supported values are: 'RSA', 'ECDSA', 'ED25519'."
  }
}

variable "rsa_bits" {
  description = <<info
 (Optional) When algorithm is RSA, the size of the generated RSA key, in bits (default: 2048).
   info
  type        = number
  default     = null

}


variable "vpc_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC."
  type        = string
  default     = 2048
}

variable "subnet_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the subnet."
  type        = string
  default     = null
}



# variable "bucket" {
#   description = <<info
#   (Optional, Forces new resource) Name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length. 
#   info
#   type        = string
#   default     = null
# }



# S3 bucket to store state file. 


variable "tags" {
  description = "Name of tag"
  type = object({
    Name       = string
    deployment = string
  })
  default = null
}



