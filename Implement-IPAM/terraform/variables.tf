# variables.tf - Variables in alphabetical order

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "The Amazon Machine Image (AMI) to use"
  type        = string
  default     = "ami-12345678"
}
