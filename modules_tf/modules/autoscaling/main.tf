resource "random_string" "random" {
  length           = 3
  special          = false
  lower             = false

  lifecycle {
    create_before_destroy = true
  }
}

#######################
#Launch Configuration
#######################
resource "aws_launch_configuration" "backend_lc" {
  name			                  = "${var.app_name}-${var.environment}-backend-lc-${random_string.random.result}"
  image_id                    = var.ecs_ami_id
  instance_type               = var.backend_instance_type
  key_name                    = var.key_name
  security_groups             = [var.security_group_id_backend]
  associate_public_ip_address = false
  user_data                   = <<EOF
#!/bin/bash
# Add cluster to ECS configuration
echo "ECS_CLUSTER=workera-${var.environment}-backend" >> /etc/ecs/ecs.config
# Change Local hostname
sudo hostnamectl set-hostname workera-${var.environment}-backend.localdomain
echo "HOSTNAME=workera-${var.environment}-backend" >> /etc/sysconfig/network
echo "127.0.0.1  workera-${var.environment}-backend.localdomain workera-${var.environment}-backend localhost4 localhost4.localdomain4" >> /etc/hosts
# Vanta Agent
VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# Update
sudo yum update-minimal --security -y
sudo yum updgrade -y
sudo reboot
EOF
  #user_data                   = filebase64(data.archive_file.backend_user_data.output_path)
  iam_instance_profile 	      = var.ecs_instance_profile_name
  root_block_device {
    volume_size               = 30
    encrypted                 = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "odoo_lc" {
  name			                  = "${var.app_name}-${var.environment}-odoo-lc-${random_string.random.result}"
  image_id                    = var.ecs_ami_id
  instance_type               = var.odoo_instance_type
  key_name                    = var.key_name
  security_groups             = [var.security_group_id_odoo]
  associate_public_ip_address = false
  user_data                   = <<EOF
#!/bin/bash
# Add cluster to ECS configuration
echo "ECS_CLUSTER=workera-${var.environment}-odoo" >> /etc/ecs/ecs.config
# Change Local hostname
sudo hostnamectl set-hostname workera-${var.environment}-odoo.localdomain
echo "HOSTNAME=workera-${var.environment}-odoo" >> /etc/sysconfig/network
echo "127.0.0.1  workera-${var.environment}-odoo.localdomain workera-${var.environment}-odoo localhost4 localhost4.localdomain4" >> /etc/hosts
# Vanta Agent
VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# Update
sudo yum update-minimal --security -y
sudo yum updgrade -y
sudo  reboot
EOF
  iam_instance_profile 	      = var.ecs_instance_profile_name
  root_block_device {
    volume_size               = 30
    encrypted                 = true
  }

  lifecycle {
    create_before_destroy     = true
  }
}

# resource "aws_launch_configuration" "matching_lc" {
#   name			                  = "${var.app_name}-${var.environment}-matching-lc-${random_string.random.result}"
#   image_id                    = var.ecs_ami_id
#   instance_type               = var.matching_instance_type
#   key_name                    = var.key_name
#   security_groups             = [var.security_group_id_matching]
#   associate_public_ip_address = false
#   user_data                   = <<EOF
# #!/bin/bash
# # Add cluster to ECS configuration
# echo "ECS_CLUSTER=workera-${var.environment}-matching" >> /etc/ecs/ecs.config
# # Change Local hostname
# sudo hostnamectl set-hostname workera-${var.environment}-matching.localdomain
# echo "HOSTNAME=workera-${var.environment}-matching" >> /etc/sysconfig/network
# echo "127.0.0.1  workera-${var.environment}-matching.localdomain workera-${var.environment}-matching localhost4 localhost4.localdomain4" >> /etc/hosts
# # Vanta Agent
# # Update
# sudo yum update-minimal --security -y
# sudo yum updgrade -y
# VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# sudo  reboot
# EOF
#   iam_instance_profile 	      = var.ecs_instance_profile_name
#   root_block_device {
#     volume_size               = 30
#     encrypted                 = true
#   }

#   lifecycle {
#     create_before_destroy     = true
#   }
# }

resource "aws_launch_configuration" "celery_lc" {
  name			                  = "${var.app_name}-${var.environment}-celery-lc-${random_string.random.result}"
  image_id                    = var.ecs_ami_id
  instance_type               = var.celery_instance_type
  key_name                    = var.key_name
  security_groups             = [var.security_group_id_celery]
  associate_public_ip_address = false
  user_data                   = <<EOF
#!/bin/bash
# Add cluster to ECS configuration
echo "ECS_CLUSTER=workera-${var.environment}-celery" >> /etc/ecs/ecs.config
# Change Local hostname
sudo hostnamectl set-hostname workera-${var.environment}-celery.localdomain
echo "HOSTNAME=workera-${var.environment}-celery" >> /etc/sysconfig/network
echo "127.0.0.1  workera-${var.environment}-celery.localdomain workera-${var.environment}-celery localhost4 localhost4.localdomain4" >> /etc/hosts
# Vanta Agent
VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# Update
sudo yum update-minimal --security -y
sudo yum updgrade -y
sudo  reboot
EOF
  iam_instance_profile 	      = var.ecs_instance_profile_name
  root_block_device {
    volume_size               = 30
    encrypted                 = true
  }

  lifecycle {
    create_before_destroy     = true
  }
}

###################
#Autoscaling group with LC
###################
resource "aws_autoscaling_group" "backend_asg" {
  launch_configuration          = aws_launch_configuration.backend_lc.name
  name                          = "${var.app_name}-${var.environment}-backend-asg"
  min_size 			                = var.backend_min
  max_size 			                = var.backend_max
  desired_capacity     		      = var.backend_desired
  #target_group_arns            = var.target_group_arns
  health_check_grace_period 	  = "0"
  health_check_type         	  = "EC2"
  default_cooldown          	  = "300"
  vpc_zone_identifier		        = var.ecs_subnet_group_list
  protect_from_scale_in         = false
  enabled_metrics           = [
          "GroupAndWarmPoolDesiredCapacity",
          "GroupAndWarmPoolTotalCapacity",
          "GroupDesiredCapacity",
          "GroupInServiceCapacity",
          "GroupInServiceInstances",
          "GroupMaxSize",
          "GroupMinSize",
          "GroupPendingCapacity",
          "GroupPendingInstances",
          "GroupStandbyCapacity",
          "GroupStandbyInstances",
          "GroupTerminatingCapacity",
          "GroupTerminatingInstances",
          "GroupTotalCapacity",
          "GroupTotalInstances",
          "WarmPoolDesiredCapacity",
          "WarmPoolMinSize",
          "WarmPoolPendingCapacity",
          "WarmPoolTerminatingCapacity",
          "WarmPoolTotalCapacity",
          "WarmPoolWarmedCapacity",
        ]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-backend"
    propagate_at_launch = true
  }
  
}

resource "aws_autoscaling_group" "odoo_asg" {
  launch_configuration          = aws_launch_configuration.odoo_lc.name
  name                          = "${var.app_name}-${var.environment}-odoo-asg"
  min_size 			                = var.odoo_min
  max_size 			                = var.odoo_max
  desired_capacity     		      = var.odoo_desired
  #target_group_arns            = var.target_group_arns
  health_check_grace_period 	  = "0"
  health_check_type         	  = "EC2"
  default_cooldown          	  = "300"
  vpc_zone_identifier		        = var.ecs_subnet_group_list
  protect_from_scale_in         = false

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-odoo"
    propagate_at_launch = true
  }
}

# resource "aws_autoscaling_group" "matching_asg" {
#   launch_configuration          = aws_launch_configuration.matching_lc.name
#   name                          = "${var.app_name}-${var.environment}-matching-asg"
#   min_size 			                = var.matching_min
#   max_size 			                = var.matching_max
#   desired_capacity     		      = var.matching_desired
#   #target_group_arns            = var.target_group_arns
#   health_check_grace_period 	  = "0"
#   health_check_type         	  = "EC2"
#   default_cooldown          	  = "300"
#   vpc_zone_identifier		        = var.ecs_subnet_group_list
#   protect_from_scale_in         = false

#   tag {
#     key                 = "Name"
#     value               = "${var.app_name}-${var.environment}-matching"
#     propagate_at_launch = true
#   }
# }

resource "aws_autoscaling_group" "celery_asg" {
  launch_configuration          = aws_launch_configuration.celery_lc.name
  name                          = "${var.app_name}-${var.environment}-celery-asg"
  min_size 			                = var.celery_min
  max_size 			                = var.celery_max
  desired_capacity     		      = var.celery_desired
  #target_group_arns            = var.target_group_arns
  health_check_grace_period 	  = "0"
  health_check_type         	  = "EC2"
  default_cooldown          	  = "300"
  vpc_zone_identifier		        = var.ecs_subnet_group_list
  protect_from_scale_in         = false

  tag {
    key                 = "Name"
    value               = "${var.app_name}-${var.environment}-celery"
    propagate_at_launch = true
  }
}

#######################
# Capacity Providers
#######################
# resource "aws_ecs_capacity_provider" "backend_cp" {
#   name = "backend-cp"

#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = aws_autoscaling_group.backend_asg.arn
#     managed_termination_protection = "DISABLED"

#     managed_scaling {
#       status                    = "ENABLED"
#       target_capacity           = 100
#     }
#   }
# }

# resource "aws_ecs_capacity_provider" "odoo_cp" {
#   name = "odoo-cp"

#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = aws_autoscaling_group.odoo_asg.arn
#     managed_termination_protection = "DISABLED"

#     managed_scaling {
#       status                    = "ENABLED"
#       target_capacity           = 100
#     }
#   }
# }

# resource "aws_ecs_capacity_provider" "matching_cp" {
#   name = "matching-cp"

#   auto_scaling_group_provider {
#     auto_scaling_group_arn         = aws_autoscaling_group.matching_asg.arn
#     managed_termination_protection = "DISABLED"

#     managed_scaling {
#       status                    = "ENABLED"
#       target_capacity           = 100
#     }
#   }
# }


#####################
# Autoscaling Policy
#####################
resource "aws_autoscaling_policy" "backend_asg_policy" {
  name                   = "${var.app_name}-${var.environment}-backend-CPU"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend_asg.name
  target_tracking_configuration {
  	predefined_metric_specification {
    		predefined_metric_type = "ASGAverageCPUUtilization"
  	}
  target_value = 70.0
  }

  lifecycle {
    ignore_changes = all
  }

}

resource "aws_autoscaling_policy" "odoo_asg_policy" {
  name                   = "${var.app_name}-${var.environment}-odoo-CPU"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.odoo_asg.name
  target_tracking_configuration {
  	predefined_metric_specification {
    		predefined_metric_type = "ASGAverageCPUUtilization"
  	}
  target_value = 70.0
  }

  lifecycle {
    ignore_changes = all
  }

}

# resource "aws_autoscaling_policy" "matching_asg_policy" {
#   name                   = "${var.app_name}-${var.environment}-matching-CPU"
#   adjustment_type        = "ChangeInCapacity"
#   policy_type            = "TargetTrackingScaling"
#   autoscaling_group_name = aws_autoscaling_group.matching_asg.name
#   target_tracking_configuration {
#   	predefined_metric_specification {
#     		predefined_metric_type = "ASGAverageCPUUtilization"
#   	}
#   target_value = 70.0
#   }

#   lifecycle {
#     ignore_changes = all
#   }

# }

resource "aws_autoscaling_policy" "celery_asg_policy" {
  name                   = "${var.app_name}-${var.environment}-celery-CPU"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.celery_asg.name
  target_tracking_configuration {
  	predefined_metric_specification {
    		predefined_metric_type = "ASGAverageCPUUtilization"
  	}
  target_value = 70.0
  }

  lifecycle {
    ignore_changes = all
  }

}


# #######################
# # Launch Template
# #######################
# ###Backend
# resource "aws_launch_template" "backend_lt" {
#   name                      = "${var.environment}-${var.app_name}-backend-lt"
#   update_default_version    = true
#   block_device_mappings {
#     device_name             = "/dev/xvda"
#     ebs {
#       volume_size           = 30
#     }
#   }
#   disable_api_termination   = false
#   ebs_optimized             = true
#   iam_instance_profile {
#     name                    = var.ecs_instance_profile_name
#   }
#   image_id                  = var.ecs_ami_id
#   instance_initiated_shutdown_behavior = "terminate"
#   instance_type             = var.backend_instance_type
#   key_name                  = var.key_name
#   monitoring {
#     enabled                 = true
#   }
#   vpc_security_group_ids    = [var.security_group_id_backend]
#   user_data                 = base64encode(<<EOF
# #!/bin/bash
# # Add cluster to ECS configuration
# echo "ECS_CLUSTER=workera-${var.environment}-backend" >> /etc/ecs/ecs.config
# # Change Local hostname
# sudo hostnamectl set-hostname workera-${var.environment}-backend.localdomain
# echo "HOSTNAME=workera-${var.environment}-backend" >> /etc/sysconfig/network
# echo "127.0.0.1  workera-${var.environment}-backend.localdomain workera-${var.environment}-backend localhost4 localhost4.localdomain4" >> /etc/hosts
# # Vanta Agent
# VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# # Update
# sudo yum update-minimal --security -y
# sudo yum updgrade -y
# sudo  reboot
# EOF
# )
#   #user_data                = filebase64("${path.module}/${var.environment}/backend.sh")
# }
# ###Odoo
# resource "aws_launch_template" "odoo_lt" {
#   name                      = "${var.environment}-${var.app_name}-odoo-lt"
#   update_default_version    = true
#   block_device_mappings {
#     device_name             = "/dev/xvda"
#     ebs {
#       volume_size           = 30
#     }
#   }
#   disable_api_termination   = false
#   ebs_optimized             = true
#   iam_instance_profile {
#     name                    = var.ecs_instance_profile_name
#   }
#   image_id                  = var.ecs_ami_id
#   instance_initiated_shutdown_behavior = "terminate"
#   instance_type             = var.odoo_instance_type
#   key_name                  = var.key_name
#   monitoring {
#     enabled                 = true
#   }
#   vpc_security_group_ids    = [var.security_group_id_odoo]
#   user_data                 = base64encode(<<EOF
# #!/bin/bash
# # Add cluster to ECS configuration
# echo "ECS_CLUSTER=workera-${var.environment}-odoo" >> /etc/ecs/ecs.config
# # Change Local hostname
# sudo hostnamectl set-hostname workera-${var.environment}-odoo.localdomain
# echo "HOSTNAME=workera-${var.environment}-odoo" >> /etc/sysconfig/network
# echo "127.0.0.1  workera-${var.environment}-odoo.localdomain workera-${var.environment}-odoo localhost4 localhost4.localdomain4" >> /etc/hosts
# # Vanta Agent
# VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# # Update
# sudo yum update-minimal --security -y
# sudo yum updgrade -y
# sudo  reboot
# EOF
# )
# }

# ####Matching
# resource "aws_launch_template" "matching_lt" {
#   name                      = "${var.environment}-${var.app_name}-matching-lt"
#   update_default_version    = true
#   block_device_mappings {
#     device_name             = "/dev/xvda"
#     ebs {
#       volume_size           = 30
#     }
#   }
#   disable_api_termination   = false
#   ebs_optimized             = true
#   iam_instance_profile {
#     name                    = var.ecs_instance_profile_name
#   }
#   image_id                  = var.ecs_ami_id
#   instance_initiated_shutdown_behavior = "terminate"
#   instance_type             = var.matching_instance_type
#   key_name                  = var.key_name
#   monitoring {
#     enabled                 = true
#   }
#   vpc_security_group_ids    = [var.security_group_id_matching]
#   user_data                 = base64encode(<<EOF
# #!/bin/bash
# # Add cluster to ECS configuration
# echo "ECS_CLUSTER=workera-${var.environment}-matching" >> /etc/ecs/ecs.config
# # Change Local hostname
# sudo hostnamectl set-hostname workera-${var.environment}-matching.localdomain
# echo "HOSTNAME=workera-${var.environment}-matching" >> /etc/sysconfig/network
# echo "127.0.0.1  workera-${var.environment}-matching.localdomain workera-${var.environment}-matching localhost4 localhost4.localdomain4" >> /etc/hosts
# # Vanta Agent
# VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# # Update
# sudo yum update-minimal --security -y
# sudo yum updgrade -y
# sudo  reboot
# EOF
# )
# }

# ####CELERY
# resource "aws_launch_template" "celery_lt" {
#   name                      = "${var.environment}-${var.app_name}-celery-lt"
#   update_default_version    = true
#   block_device_mappings {
#     device_name             = "/dev/xvda"
#     ebs {
#       volume_size           = 30
#     }
#   }
#   disable_api_termination   = false
#   ebs_optimized             = true
#   iam_instance_profile {
#     name                    = var.ecs_instance_profile_name
#   }
#   image_id                  = var.ecs_ami_id
#   instance_initiated_shutdown_behavior = "terminate"
#   instance_type             = var.celery_instance_type
#   key_name                  = var.key_name
#   monitoring {
#     enabled                 = true
#   }
#   vpc_security_group_ids    = [var.security_group_id_celery]
#   user_data                 = base64encode(<<EOF
# #!/bin/bash
# # Add cluster to ECS configuration
# echo "ECS_CLUSTER=workera-${var.environment}-celery" >> /etc/ecs/ecs.config
# # Change Local hostname
# sudo hostnamectl set-hostname workera-${var.environment}-celery.localdomain
# echo "HOSTNAME=workera-${var.environment}-celery" >> /etc/sysconfig/network
# echo "127.0.0.1  workera-${var.environment}-celery.localdomain workera-${var.environment}-celery localhost4 localhost4.localdomain4" >> /etc/hosts
# # Vanta Agent
# VANTA_NOSTART=1 VANTA_KEY="${var.vanta_key}" bash -c "$(curl -L https://raw.githubusercontent.com/VantaInc/vanta-agent-scripts/master/install-linux.sh)"
# sudo  reboot
# EOF
# )
# }

#######################
# Autoscaling with LT
#######################
# resource "aws_autoscaling_group" "backend_asg" {
#   launch_template {
#     id                          = aws_launch_template.backend_lt.id
#     version                     = "$Default"
#   }
#   name                          = "${var.environment}-${var.app_name}-backend-asg"
#   min_size 			                = var.backend_min
#   max_size 			                = var.backend_max
#   desired_capacity     		      = var.backend_desired
#   health_check_grace_period 	  = "0"
#   health_check_type         	  = "EC2"
#   default_cooldown          	  = "300"
#   vpc_zone_identifier		        = var.ecs_subnet_group_list
#   protect_from_scale_in         = false

#   tag {
#     key                 = "Name"
#     value               = "${var.app_name}-${var.environment}-backend"
#     propagate_at_launch = true
#   }
#   tag {
#     key                 = "AmazonECSManaged"
#     value               = ""
#     propagate_at_launch = true
#   }
# }

# resource "aws_autoscaling_group" "odoo_asg" {
#   launch_template {
#     id                          = aws_launch_template.odoo_lt.id
#     version                     = "$Default"
#   }
#   name                          = "${var.environment}-${var.app_name}-odoo-asg"
#   min_size 			                = var.odoo_min
#   max_size 			                = var.odoo_max
#   desired_capacity     		      = var.odoo_desired
#   health_check_grace_period 	  = "0"
#   health_check_type         	  = "EC2"
#   default_cooldown          	  = "300"
#   vpc_zone_identifier		        = var.ecs_subnet_group_list
#   protect_from_scale_in         = false

#   tag {
#     key                 = "Name"
#     value               = "${var.app_name}-${var.environment}-odoo"
#     propagate_at_launch = true
#   }
#   tag {
#     key                 = "AmazonECSManaged"
#     value               = ""
#     propagate_at_launch = true
#   }
# }

# resource "aws_autoscaling_group" "matching_asg" {
#   launch_template {
#     id                          = aws_launch_template.backend_lt.id
#     version                     = "$Default"
#   }
#   name                          = "${var.environment}-${var.app_name}-matching-asg"
#   min_size 			                = var.matching_min
#   max_size 			                = var.matching_max
#   desired_capacity     		      = var.matching_desired
#   health_check_grace_period 	  = "0"
#   health_check_type         	  = "EC2"
#   default_cooldown          	  = "300"
#   vpc_zone_identifier		        = var.ecs_subnet_group_list
#   protect_from_scale_in         = false

#   tag {
#     key                 = "Name"
#     value               = "${var.app_name}-${var.environment}-matching"
#     propagate_at_launch = true
#   }
#   tag {
#     key                 = "AmazonECSManaged"
#     value               = ""
#     propagate_at_launch = true
#   }
# }



