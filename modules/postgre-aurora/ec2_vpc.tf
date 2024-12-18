################################################################################
# VPC Endpoints
################################################################################

locals {
  endpoints = {
    "endpoint-ssm" = {
      name        = "ssm"
      private_dns = false
    },
    "endpoint-ssm-messages" = {
      name        = "ssmmessages"
      private_dns = false
    },
    "endpoint-ec2-messages" = {
      name        = "ec2messages"
      private_dns = false
    },
  }
}

resource "aws_vpc_endpoint" "endpoints" {
  for_each            = local.endpoints

  vpc_id              = var.vpc_id
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${data.aws_region.current.name}.${each.value.name}"
  security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  subnet_ids          = var.subnet_ids
  private_dns_enabled = each.value.private_dns

}

################################################################################
# SG for VPC endpoints
################################################################################

resource "aws_security_group" "vpc_endpoint_sg" {
  name_prefix = "vpc-endpoint-sg"
  vpc_id      = var.vpc_id
  description = "security group for VPC endpoints"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    description = "allow all TCP within VPC CIDR"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound traffic from VPC"
  }

  tags = {
    Name = "vpc-endpoints-sg"
  }
}