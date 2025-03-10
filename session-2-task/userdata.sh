#!/bin/bash
# Update package lists to ensure we install the latest versions
sudo apt update

# Install Java Runtime Environment (JRE) and Java Development Kit (JDK)
sudo apt-get install default-jre -y  # Install default JRE
sudo apt-get install default-jdk -y  # Install default JDK

# Download and add the Jenkins repository key to verify package authenticity
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add the Jenkins repository to the system sources list
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again to include Jenkins packages
sudo apt-get update

# Install Jenkins
sudo apt-get install jenkins -y

# Start the Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Change system hostname to 'jenkins' for easier identification
sudo hostnamectl set-hostname jenkins

# Install Nginx web server to use as a reverse proxy for Jenkins
sudo apt-get update && sudo apt-get install nginx -y

# Create an Nginx configuration file for Jenkins reverse proxy
sudo tee /etc/nginx/sites-available/jenkins <<-EOF
server {
    listen 80;  # Listen on port 80 for HTTP traffic
    server_name jenkins.innovatespheres.org www.jenkins.innovatespheres.org;  # Define domain names

    location / {
        proxy_pass http://localhost:8080;  # Forward requests to Jenkins running on port 8080
        proxy_set_header Host \$host;  # Preserve the original host header
        proxy_set_header X-Real-IP \$remote_addr;  # Forward client IP address
    }
}
EOF

# Create a symbolic link to enable the Nginx configuration
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/

# Test Nginx configuration syntax and reload the service if no errors are found
sudo nginx -t
sudo systemctl reload nginx

# Install Certbot for automatic SSL certificate management
sudo apt-get install certbot python3-certbot-nginx -y

# Wait for 60 seconds to ensure services are fully started before issuing SSL certificate
sleep 60 

# Obtain and configure an SSL certificate using Certbot for the Jenkins domain
certbot --nginx \
    --non-interactive \
    --agree-tos \
    --email testingdevops77@gmail.com \  # Email for Let's Encrypt notifications
    --redirect \  # Redirect HTTP to HTTPS
    -d jenkins.innovatespheres.org \  # Primary domain
    -d www.jenkins.innovatespheres.org  # Alternative domain

# Reload Nginx to apply SSL certificate changes
sudo systemctl reload nginx

