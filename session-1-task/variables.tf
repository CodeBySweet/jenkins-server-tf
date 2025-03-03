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
  type        = string
}

variable "default_subnet_id" {
  description = "Default subnet ID"
  type        = string
}

variable "ports" {
  description = "List of ports to open for Jenkins"
  type        = list(number)
  default     = [22, 8080]
}