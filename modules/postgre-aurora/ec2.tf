################################################################################
# EC2 Instance
################################################################################

resource "aws_instance" "bastion_host" {
  ami                     = var.ec2_ami
  instance_type           = "t3.nano"
  subnet_id               = var.subnet_ids[1]
  vpc_security_group_ids  = [aws_security_group.vpc_endpoint_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.bastion_host_instance_profile.name
  user_data               = templatefile("${path.module}/ec2_ssm_agent_installer.sh", {})
  disable_api_termination = false
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  tags = {
    Name = "ssm-bastion-host"
  }
}

################################################################################
# EC2 Instance Profile
################################################################################

resource "aws_iam_role" "bastion_host_role" {
  name = "EC2-SSM-Session-Manager-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bastion_host_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.bastion_host_role.name
}

resource "aws_iam_instance_profile" "bastion_host_instance_profile" {
  name = "EC2_SSM_InstanceProfile"
  role = aws_iam_role.bastion_host_role.name
}
