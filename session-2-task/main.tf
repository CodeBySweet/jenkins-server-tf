# Provisions an EC2 instance for Jenkins with specified configurations.
resource "aws_instance" "jenkins_server" {
  ami                         = "ami-04b4f1a9cf54c11d0"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  subnet_id                   = aws_subnet.public-subnet[0].id
  iam_instance_profile        = aws_iam_instance_profile.s3_jenkins_profile.name
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Name = "JenkinsInstance"
  }
}

# Defines an IAM role that the EC2 instance can assume to interact with AWS services.
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attaches a policy to the IAM role, granting permissions for EC2 and S3 actions.
resource "aws_iam_role_policy" "ec2_s3_policy" {
  name = "ec2-s3-policy"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Creates an IAM instance profile to attach the IAM role to the EC2 instance.
resource "aws_iam_instance_profile" "s3_jenkins_profile" {
  name = "jenkins-profile"
  role = aws_iam_role.ec2_s3_role.name
}
