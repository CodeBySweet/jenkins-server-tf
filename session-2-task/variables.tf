variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "my_ip" {
  description = "My public IP address"
  type        = list(any)
}

# variable "public_subnet" {
#   description = "Default subnet ID"
#   type        = string
# }

# Ports for Jenkins
variable "ports" {
  description = "List of ports to open for Jenkins"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

# Environment Variable
variable "env" {
  type        = string
  default     = "Dev"
  description = "This is My Dev Environment"
}

# VPC Name Variable
variable "vpc_name" {
  type        = string
  default     = "My-VPC"
}

# Security Group Name Variable
variable "security_group_name" {
  type        = string
  default     = "VPC-SG"
}

# Public/Private Subnets' AZs
variable "subnets_az" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "Public Subnets Avaialability Zones"
}

# Public/Private Subnets Name
variable "subnet_name" {
  type    = list(number)
  default = [1, 2, 3]
}

# Public Subnets CIDR Blocks
variable "public_subnet_cidr_block" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  description = "List of Public Subnets' CIDR Block"
}

# Private Subnets CIDR Blocks
variable "private_subnet_cidr_block" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  description = "List of Private Subnets' CIDR Block"
}


# List of Ports for VPC SG
variable "sg_ports" {
  type        = list(number)
  default     = [22, 80, 443, 8080]
  description = "List of ports"
}