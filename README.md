# Built Iac using Terraform

![Image](https://github.com/user-attachments/assets/8dda9bef-1859-420b-8960-db6f66a23457)



# AWS Infrastructure with Terraform 🚀

This project provisions an AWS infrastructure using Terraform. It demonstrates the use of **VPC**, **public subnets**, **EC2 instances**, and an **Application Load Balancer (ALB)** to distribute traffic between servers.



# Key Features 📋

- **VPC**: A Virtual Private Cloud is created to host the infrastructure.
- **Public Subnets**: Two public subnets are created within the VPC.
- **EC2 Instances**: 
  - Two EC2 instances (`Instance A` and `Instance B`) are launched, each placed in a separate subnet and sharing a common security group.
  - Each instance is configured using a user data script to install Apache and create a custom `index.html` file.
  - The `index.html` displays:
    - Server details (`Server 1` or `Server 2`)
    - Instance name (`Instance A` or `Instance B`)
    - Page details (`Page 1` or `Page 2`)
- **Application Load Balancer (ALB)**:
  - Balances incoming requests across the two EC2 instances.
  - When accessing the Load Balancer's DNS, the displayed page alternates between `Instance A` and `Instance B` upon refreshing.

## How It Works 🔄
