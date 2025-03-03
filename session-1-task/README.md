# Jenkins Terraform Deployment

## Overview

This project sets up an AWS EC2 instance running Jenkins using Terraform. The configuration includes provisioning an instance, installing Jenkins, configuring security groups, and storing the Terraform state in an S3 backend.

## File Structure

```
project-folder/
│── backend.tf           # Terraform backend configuration (S3 bucket for state storage)
│── data.sh              # Bash script for Jenkins installation
│── data.tf              # Fetches default VPC and latest Ubuntu AMI
│── main.tf              # Defines EC2 instance for Jenkins
│── outputs.tf           # Outputs public IP of the instance
│── providers.tf         # AWS provider configuration
│── sg.tf                # Security group settings
│── terraform.tfvars     # Variables file with values
│── variables.tf         # Variable definitions
│── README.md            # Documentation file

```

## Deployment Steps

1. **Initialize Terraform**
    
    ```
    terraform init
    
    ```
    
    - This command initializes Terraform and configures the S3 backend for storing state.
2. **Validate Configuration**
    
    ```
    terraform validate
    
    ```
    
    - Ensures that the Terraform configuration files are syntactically correct.
3. **Plan Deployment**
    
    ```
    terraform plan
    
    ```
    
    - Shows the execution plan and previews the changes that will be applied.
4. **Apply Changes**
    
    ```
    terraform apply -auto-approve
    
    ```
    
    - Deploys the infrastructure and provisions the EC2 instance.
5. **Retrieve Public IP**
    
    ```
    terraform output instance_public_ip
    
    ```
    
    - Retrieves the public IP address of the newly created Jenkins instance.
6. **Access Jenkins**
    - Open a web browser and navigate to `http://<instance_public_ip>:8080` to access Jenkins.
7. **Destroy Infrastructure (if needed)**
    
    ```
    terraform destroy -auto-approve
    
    ```
    
    - Tears down all resources created by Terraform.

## Notes

- Ensure your AWS credentials are correctly configured.
- The security group only allows SSH (22) and Jenkins (8080) access from your public IP.
- Modify the `terraform.tfvars` file to customize values as needed.

This Terraform setup provides a quick and automated way to deploy a Jenkins server on AWS.