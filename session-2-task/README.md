# Terraform Project: Jenkins Deployment with Custom VPC

## Project Overview

This Terraform project sets up a secure and scalable Jenkins deployment on AWS. It includes a custom VPC with public and private subnets, an EC2 instance for Jenkins, Route 53 DNS records, SSL configuration via CertBot, and an Nginx reverse proxy.

---

## Infrastructure Components

### 1. IAM Role
- Attached permissions:
  - `ec2:*` (Full EC2 access)
  - `s3:*` (Full S3 access)

### 2. Custom VPC (`vpc.tf`)
- Configured with:
  - **3 public subnets**
  - **3 private subnets**
  - (Code reused from Terraform Session)
- **Jenkins Server** is deployed in a **public subnet**.

### 3. Route 53 DNS (`route53.tf`)
- Creates **A records** for:
  - `jenkins.your-domain`
  - `www.jenkins.your-domain`

### 4. SSL Configuration (`userdata.sh`)
- Configured using **CertBot** for HTTPS support.

### 5. Nginx Proxy (`userdata.sh`)
- Acts as a reverse proxy for Jenkins:
  - Traffic on **ports 80/443** is forwarded to **localhost:8080** (Jenkins).

### 6. Security Group (`sg.tf`)
- Ingress rules:
  - **Port 443 (HTTPS)**: Open to **Akumo IP, Home IP**
  - **Port 22 (SSH)**: Open to **Akumo IP, Home IP**
  - **Port 8080 (Jenkins Web UI)**: **Must be removed after Nginx proxy is configured**.

---

## File Structure

