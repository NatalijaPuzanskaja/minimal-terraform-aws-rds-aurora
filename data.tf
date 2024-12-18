################################################################################
# VPC
################################################################################
data "aws_vpc" "internal" {
  tags = {
    "vpc:type"  = "internal"
    "Name"      = "internal"
  }
}

################################################################################
# Subnets
################################################################################
data "aws_subnets" "internal" {
  filter {
    name    = "vpc-id"
    values  = [data.aws_vpc.internal.id]
  }

  filter {
    name    = "tag:subnet:type"
    values  = ["internal"]
  }
}

################################################################################
# Availability Zones
################################################################################
data "aws_availability_zones" "region" {
  state = "available"
}

################################################################################
# AMI
################################################################################
data "aws_ami" "amazon_linux_2_ssm" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}
