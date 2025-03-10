# Fetch the hosted zone for your domain.
data "aws_route53_zone" "my_domain" {
  name = "innovatespheres.org"
}

# Create an A record for jenkins.your-domain.
resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.my_domain.zone_id
  name    = "jenkins.innovatespheres.org"
  type    = "A"
  ttl     = "300"

  records = [aws_instance.jenkins_server.public_ip] # Ensure this is a list of strings
}

# Create an A record for www.jenkins.your-domain.
resource "aws_route53_record" "www_jenkins" {
  zone_id = data.aws_route53_zone.my_domain.zone_id
  name    = "www.jenkins.innovatespheres.org"
  type    = "A"
  ttl     = "300"

  records = [aws_instance.jenkins_server.public_ip] # Ensure this is a list of strings
}