###########################################
# Security Group
###########################################
resource "aws_security_group" "sg_db" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-db-sg"
  description   = "PostgreSQL DB security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-db-sg"
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["172.16.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_ec2" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-ec2-sg"
  description   = "EC2 security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-ec2-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    description = "sisense"
    protocol    = "tcp"
    cidr_blocks = ["107.23.195.228/32","54.236.224.46/32"]
  }
}

resource "aws_security_group" "sg_ecs" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-ecs-sg"
  description   = "ECS Clusters security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-ecs-sg"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_security_group" "sg_ecs_backend" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-backend-ecs-sg"
  description   = "ECS Clusters security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-backend-ecs-sg"
  }

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs_odoo" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-odoo-ecs-sg"
  description   = "ECS Clusters security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-odoo-ecs-sg"
  }

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs_matching" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-matching-ecs-sg"
  description   = "ECS Clusters security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-matching-ecs-sg"
  }

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_ecs_celery" {
  vpc_id      	= var.vpc_id
  name 	      	= "${var.environment}-${var.app_name}-celery-ecs-sg"
  description   = "ECS Clusters security group"
  tags = {
       Name     = "${var.environment}-${var.app_name}-celery-ecs-sg"
  }

  ingress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}