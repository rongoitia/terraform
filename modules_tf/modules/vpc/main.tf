#######################
# VPC
#######################
resource "aws_vpc" "main" {
  cidr_block                    = var.cidr_block
  enable_dns_hostnames          = var.enable_dns_hostnames
  tags = {
       Name                     = "${var.app_name}-${var.environment}-vpc"
  }
}

#######################
# Public subnets
#######################
resource "aws_subnet" "public-a" {
  vpc_id                        = aws_vpc.main.id
  cidr_block                    = var.cidr_block_a
  availability_zone             = var.az_a

  tags = {
          Name                  = "${var.app_name}-${var.environment}-public-subnet-a"
         }
}

resource "aws_subnet" "public-b" {
  vpc_id                        = aws_vpc.main.id
  cidr_block                    = var.cidr_block_b
  availability_zone             = var.az_b

  tags = {
          Name                  = "${var.app_name}-${var.environment}-public-subnet-b"
         }
  }

resource "aws_subnet" "public-c" {
  vpc_id                        = aws_vpc.main.id
  cidr_block                    = var.cidr_block_c
  availability_zone             = var.az_c
  tags = {
          Name                  = "${var.app_name}-${var.environment}-public-subnet-c"
         }
  }

#######################
# Private subnets
#######################
resource "aws_subnet" "private-a" {
  vpc_id     			= aws_vpc.main.id
  cidr_block 			= var.cidr_block_d
  availability_zone 		= var.az_a
  tags = {
    	  Name 			= "${var.app_name}-${var.environment}-private-subnet-a"
  	 }
}

resource "aws_subnet" "private-b" {
  vpc_id     			= aws_vpc.main.id
  cidr_block 			= var.cidr_block_e
  availability_zone 		= var.az_b
  tags = {
    	  Name		        = "${var.app_name}-${var.environment}-private-subnet-b"
  	 }
}

resource "aws_subnet" "private-c" {
  vpc_id     			= aws_vpc.main.id
  cidr_block 			= var.cidr_block_f
  availability_zone 		= var.az_c
  tags = {
       	  Name 			= "${var.app_name}-${var.environment}-private-subnet-c"
  	 }
}

#######################
# Elastic IP Nat
#######################
resource "aws_eip" "eip-nat-gw" {
  vpc      = true
  tags = {
          Name 			= "${var.app_name}-${var.environment}-eip-nat-gw"
  	 }
}

#######################
# NAT Gateway
#######################
resource "aws_nat_gateway" "nat-gw" {
  allocation_id 		= aws_eip.eip-nat-gw.id
  subnet_id     		= aws_subnet.public-a.id

  tags = {
          Name 			= "${var.app_name}-${var.environment}-nat-gw"
  	 }
}

#######################
# Internet gateway
#######################
resource "aws_internet_gateway" "it-gw" {
  vpc_id 			= aws_vpc.main.id
  tags = {
    	  Name 			= "${var.app_name}-${var.environment}-internet-gateway"
  	 }
}

#######################
# Route tables
#######################
resource "aws_route_table" "public-rt" {
  vpc_id 			= aws_vpc.main.id

  route {
    cidr_block 			= var.rt_cidr_block
    gateway_id 			= aws_internet_gateway.it-gw.id
  }

  tags = {
    	  Name 			= "${var.app_name}-${var.environment}-public-route-table"
  	 }
  lifecycle {
    ignore_changes = all
  }

}

resource "aws_route_table" "private-rt" {
  vpc_id 			= aws_vpc.main.id

  route {
    cidr_block 			= var.rt_cidr_block
    gateway_id 			= aws_nat_gateway.nat-gw.id
  }
  tags = {
    	  Name 			= "${var.app_name}-${var.environment}-private-route-table"
  	 }
  lifecycle {
    ignore_changes = all
  }

}


#############################
# Route - Subnet Associations
#############################
resource "aws_route_table_association" "public-association-a" {
  subnet_id      		=  aws_subnet.public-a.id
  route_table_id 		= aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-association-b" {
  subnet_id      		= aws_subnet.public-b.id
  route_table_id 		= aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public-association-c" {
  subnet_id      		= aws_subnet.public-c.id
  route_table_id 		= aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-association-a" {
  subnet_id      		= aws_subnet.private-a.id
  route_table_id 		= aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-association-b" {
  subnet_id      		= aws_subnet.private-b.id
  route_table_id 		= aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-association-c" {
  subnet_id      		= aws_subnet.private-c.id
  route_table_id 		= aws_route_table.private-rt.id
}

resource "aws_vpc_endpoint" "sns" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.sns"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-b.id,aws_subnet.private-c.id]
  security_group_ids  = [aws_vpc.main.default_security_group_id]

  private_dns_enabled = true
  tags = {
    	  Name 			    = "${var.app_name}-${var.environment}-ep-sns"
  	 }
}

resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private-a.id,aws_subnet.private-b.id,aws_subnet.private-c.id]
  security_group_ids  = [aws_vpc.main.default_security_group_id]

  private_dns_enabled = true
  tags = {
    	  Name 			    = "${var.app_name}-${var.environment}-ep-sqs"
  	 }
}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}