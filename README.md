# Terraform AWS Infrastructure

## Introduction
This project contains Terraform scripts to automate the creation and management of infrastructure on AWS. The scripts define various AWS resources and their configurations to help you quickly set up and manage your cloud infrastructure.

## Features
- Automated provisioning of AWS resources
- Modular and reusable Terraform code
- Easy customization and configuration

## Prerequisites
Before you begin, ensure you have the following:
- Terraform installed 
- AWS account with appropriate permissions
- AWS CLI configured with your credentials

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/lilyvaishnav14/terraform_aws.git
    cd terraform_aws
    ```

2. Initialize Terraform:
    ```sh
    terraform init
    ```

3. Plan your infrastructure:
    ```sh
    terraform plan
    ```

4. Apply the Terraform scripts to create the infrastructure:
    ```sh
    terraform apply
    ```

5. Destroy the infrastructure:
    If you need to remove the infrastructure, you can use:
    ```sh
    terraform destroy
    ```