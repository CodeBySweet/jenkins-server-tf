output "instance_public_ip" {
  description = "Public IP address of the Jenkins server"
  value       = aws_instance.jenkins_server.public_ip
}
