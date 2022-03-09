### VPC
variable "cidr_block" {
  description = "Set a CIDR Block for the main VPC"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS names on the instances, this is used for instances on the public subnets"
}

#variable "sns_endpoint" {
#  description = "Set a SNS aws endpoint"
#}
#variable "sqs_endpoint" {
#  description = "Set a SNS aws endpoint"
#}


variable "az_a" {
  description = "Availabily Zone a"
}

variable "az_b" {
  description = "Availabily Zone b"
}

variable "az_c" {
  description = "Availabily Zone c"
}

variable "cidr_block_a" {
  description = "CIDR Block for the public subnet-a"
}

variable "cidr_block_b" {
  description = "CIDR Block for the public subnet-b"
}

variable "cidr_block_c" {
  description = "CIDR Block for the public subnet-c"
}

variable "cidr_block_d" {
  description = "CIDR Block for the private subnet-a"
}

variable "cidr_block_e" {
  description = "CIDR Block for the private subnet-b"
}

variable "cidr_block_f" {
  description = "CIDR Block for the private subnet-c"
}

variable "vpc_true" {
  description = "Set the Elastic inside the VPC"
}

variable "rt_cidr_block" {
  description = "Route table CIDR Block"
}

### App name
variable "app_name" {
  description = "Set App name"
}

variable "environment" {
  description = "Set environment"
}

variable "region" {
  description = "Set region"
}