variable "environment" {
   description = "Set environment name"
}
variable "app_name" {
   description = "Set app name"
}
variable "owner" {
   description = "Set app name"
}
variable "region" {
   description = "Set app name"
}

variable "ec2_sg_id" {
  description    = "Set Security Group id"
}

variable "ec2_ami_id" {
  description    = "Set AMI id"
}

variable "vanta_key" {
  description    = "Set Vanta key"
}

variable "subnet_id" {
  description    = "Set subnet id"
}
variable "cidr_block_d" {
   description = "Set private ip"
}

variable "instance_profile" {
  description    = "Set iam role"
}

variable "efs_odoo_id" {
   description = "Set efs id"
}

variable "secret_name" {
   description = "Set secret name"
}