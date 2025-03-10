# Terraform Project: Jenkins Deployment with Custom VPC

## Project Overview

This Terraform project automates the deployment of a secure and scalable Jenkins server on AWS. The infrastructure includes a custom VPC with public and private subnets, an EC2 instance for Jenkins, Route 53 DNS records, SSL configuration via CertBot, and an Nginx reverse proxy. The setup ensures secure access to Jenkins through HTTPS and restricts access to trusted IPs.

---

## Infrastructure Components

### 1. **IAM Role**
- **Permissions**:
  - Full access to EC2 (`ec2:*`).
  - Full access to S3 (`s3:*`).

### 2. **Custom VPC (`vpc.tf`)**
- **Features**:
  - 3 public subnets.
  - 3 private subnets.
  - Jenkins server deployed in a **public subnet**.
- **Reusability**: VPC configuration is reused from a previous Terraform session.

### 3. **Route 53 DNS (`route53.tf`)**
- **A Records**:
  - `jenkins.your-domain`
  - `www.jenkins.your-domain`

### 4. **SSL Configuration (`userdata.sh`)**
- **CertBot**: Automates SSL certificate generation and renewal for HTTPS.

### 5. **Nginx Reverse Proxy (`userdata.sh`)**
- **Function**:
  - Routes traffic from **ports 80/443** to **localhost:8080** (Jenkins).
- **Purpose**: Secures Jenkins behind HTTPS and simplifies access.

### 6. **Security Group (`sg.tf`)**
- **Ingress Rules**:
  - **Port 443 (HTTPS)**: Open to **Akumo IP** and **Home IP**.
  - **Port 22 (SSH)**: Open to **Akumo IP** and **Home IP**.
  - **Port 8080 (Jenkins Web UI)**: **Temporary** (remove after Nginx proxy is configured).

---

## File Structure

```sh
SESSION-2-TASK/
│── backend.tf                 # Backend configuration (e.g., S3, DynamoDB)
│── data.tf                    # Data sources (e.g., existing AWS resources)
│── main.tf                    # Main Terraform configuration
│── outputs.tf                 # Outputs (e.g., instance IPs, DNS names)
│── providers.tf               # Provider configurations (AWS, etc.)
│── README.md                  # Project documentation (this file)
│── route53.tf                 # Route 53 A record definitions
│── sg.tf                      # Security group configurations
│── userdata.sh                # User data script (Jenkins, Nginx, CertBot)
│── variables.tf               # Variable definitions
│── versions.tf                # Terraform required versions
│── vpc.tf                     # VPC and subnet configurations
```


---

## Deployment Instructions

### Prerequisites
- **Terraform installed**: [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- **AWS CLI configured** with appropriate credentials
- **Domain configured** in AWS Route 53

### Steps

1. **Initialize Terraform**
   ```sh
   terraform init
2. **Apply the Configuration**
Deploy the infrastructure using:
   ```sh
   terraform apply -auto-approve
3. **Verify Jenkins**
   - Access Jenkins at:
      https://jenkins.your-domain
   - Ensure Nginx proxy is functioning correctly.

---

### Jenkins Setup
1. **Unlock Jenkins**
Once the instance is running, retrieve the initial admin password:
```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
Paste the password into the Jenkins UI at:
https://jenkins.your-domain
2. **Install Suggested Plugins**
Select **"Install suggested plugins"** to complete the setup.

3. **Create Admin User**
Set up an admin username and password.

---

### Post-Deployment Notes
**Security Groups**
- After successful deployment, **remove the 8080 ingress rule** from the security group to ensure all traffic flows through Nginx.
**SSL Renewal**
CertBot certificates expire every 90 days. Set up auto-renewal using:
```sh
sudo certbot renew --dry-run
```

---

### Troubleshooting
**Jenkins Not Accessible?**
- Check **Nginx logs**:
```sh
sudo journalctl -u nginx --no-pager | tail -20
```
- Verify firewall/security group rules:
 - Ensure ports 80, 443, and 22 are correctly open.
- Confirm Jenkins is running:
```sh
systemctl status jenkins
```

### SSL Certificate Issues?
Check **CertBot logs**:
```sh
sudo journalctl -u certbot --no-pager | tail -20
```
