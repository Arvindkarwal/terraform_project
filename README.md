# Built Iac using Terraform

![Image](https://github.com/user-attachments/assets/8dda9bef-1859-420b-8960-db6f66a23457)



# AWS Infrastructure with Terraform 🚀

This project provisions an AWS infrastructure using Terraform. It demonstrates the use of **VPC**, **public subnets**, **EC2 instances**, and an **Application Load Balancer (ALB)** to distribute traffic between servers.



## Key Features 📋

- **VPC**: A Virtual Private Cloud is created to host the infrastructure.
- **Internet Gateway**: An Internet Gateway is attached to the VPC, enabling internet access for the resources.
- **Route Table**: A route table is created and associated with the public subnets to route traffic through the Internet Gateway.
- **Public Subnets**: Two public subnets are created within the VPC.
- **EC2 Instances**: 
  - Two EC2 instances (`Instance A` and `Instance B`) are launched, each placed in a separate subnet and sharing a common security group.
  - Each instance is configured using a user data script to install Apache and create a custom `index.html` file.
  - The `index.html` displays:
    - Server details (`Server 1` or `Server 2`)
    - Instance name (`Instance A` or `Instance B`)
    - Html Page details (`Page 1 from server-1` or `Page 2 from server-2`)
- **Application Load Balancer (ALB)**:
  - Balances incoming requests across the two EC2 instances.
  - When accessing the Load Balancer's DNS, the displayed page alternates between `Instance A` and `Instance B` upon refreshing.

## How It Works 🔄

1. A user sends a request to the **Load Balancer's DNS**.
2. The ALB forwards the request to one of the EC2 instances, distributing traffic evenly.
3. Each EC2 instance serves a unique web page:
   - `Instance A`: Displays "Server 1, Instance A, Page 1".
   - `Instance B`: Displays "Server 2, Instance B, Page 2".
4. Refreshing the page alternates the response, demonstrating the **load balancing** process.

## Technologies Used 🛠️

- **Terraform**: To provision and manage infrastructure as code.
- **AWS Services**: VPC, Internet Gateway, Route Table, EC2, ALB, Subnets, and Security Group.
- **Apache Web Server**: To host and serve web pages.


## App Page 📄


<img width="1460" alt="Image" src="https://github.com/user-attachments/assets/e118f6fd-9945-48ae-bd9a-1df2f73febd8" />
