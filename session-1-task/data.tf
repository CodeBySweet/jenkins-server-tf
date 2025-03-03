# Fetches the default VPC in the AWS account
data "aws_vpc" "default_vpc" {
  default = true
}

output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

# Retrieves the most recent Ubuntu 20.04 AMI from Canonical's AWS account.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}