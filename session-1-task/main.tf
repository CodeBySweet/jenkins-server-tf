# Launch EC2 instance
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  subnet_id              = var.default_subnet_id

  user_data = file("data.sh")

  tags = {
    Name = "JenkinsInstance"
  }
}
