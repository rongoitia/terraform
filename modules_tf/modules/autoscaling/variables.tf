# ### Security groups

variable "security_group_id" {
   description = "Set the id of the security group for ecs intances"
}

variable "security_group_id_backend" {
   description = "Set the id of the security group for ecs intances"
}

variable "security_group_id_odoo" {
   description = "Set the id of the security group for ecs intances"
}

# variable "security_group_id_matching" {
#    description = "Set the id of the security group for ecs intances"
# }

variable "security_group_id_celery" {
   description = "Set the id of the security group for ecs intances"
}

variable "environment" {
   description = "Set environment name"
}

variable "app_name" {
   description = "Set app name"
}

variable "ecs_subnet_group_list" {
   description = "Set the list of the subnets"
}

variable "key_name" {
   description = "Set the name of the key for ssh"
}
variable "ecs_ami_id" {
   description = "Set the AMI ID For EC2"
}

variable "ecs_instance_profile_name" {
   description = "Set name of ec2 instance profile"
}

variable "vanta_key" {
   description = "Set vantakey for ec2"
}

######## Backend
variable "backend_desired" {
  description = "Number of desired instances"
}

variable "backend_max" {
  description = "Number of max instances"
}

variable "backend_min" {
  description = "Number of min instances"
}

variable "backend_instance_type" {
  description = "Type of instance"
}

######## Odoo
variable "odoo_desired" {
  description = "Number of desired instances"
}

variable "odoo_max" {
  description = "Number of max instances"
}

variable "odoo_min" {
  description = "Number of min instances"
}

variable "odoo_instance_type" {
  description = "Type of instance"
}

# ######## Matching
# variable "matching_desired" {
#   description = "Number of desired instances"
# }

# variable "matching_max" {
#   description = "Number of max instances"
# }

# variable "matching_min" {
#   description = "Number of min instances"
# }

# variable "matching_instance_type" {
#   description = "Type of instance"
# }

######## Celery
variable "celery_desired" {
  description = "Number of desired instances"
}

variable "celery_max" {
  description = "Number of max instances"
}

variable "celery_min" {
  description = "Number of min instances"
}

variable "celery_instance_type" {
  description = "Type of instance"
}


