# AWS Infrastructure Automation using Terraform

Provision a production-ready Amazon EKS (Elastic Kubernetes Service) platform on AWS using Terraform. This project demonstrates Infrastructure as Code (IaC) by automating the deployment of networking, Kubernetes infrastructure, and remote state management.

---

## Project Overview

This project automates the creation of an AWS infrastructure required to run Kubernetes workloads on Amazon EKS.

Instead of manually provisioning resources through the AWS Console, Terraform is used to create a reusable and scalable infrastructure that can be deployed consistently across multiple environments.

---

## Architecture

AWS Account
│
├── VPC
│ ├── Public Subnets (2 AZs)
│ ├── Private Subnets (2 AZs)
│ ├── Internet Gateway
│ ├── NAT Gateway
│ └── Route Tables
│
├── Amazon EKS Cluster
│ ├── Managed Control Plane
│ └── Managed Node Group
│
└── Amazon S3
└── Terraform Remote State

---

## Features

- Infrastructure as Code using Terraform
- Production-style Amazon EKS Cluster
- Custom VPC across two Availability Zones
- Public and Private Subnets
- NAT Gateway for private internet access
- Managed EKS Node Group
- Remote Terraform State stored in Amazon S3
- Modular and reusable Terraform code
- Environment-based configuration (Dev, Staging, Production)
- Terraform Outputs for cluster access

---

## AWS Services Used

- Amazon VPC
- Amazon EKS
- Amazon EC2
- Amazon IAM
- Amazon S3
- NAT Gateway
- Internet Gateway
- Route Tables
- Security Groups

---

## Tools & Technologies

- Terraform
- AWS CLI
- kubectl
- eksctl
- Git
- Linux

---

## Project Structure

```
terraform-aws-eks-platform-dev/

├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── main.tf
├── versions.tf
├── backend.tf
├── modules/
│ ├── networking/
│ └── eks/
└── README.md
```

---

## Prerequisites

Before deploying the infrastructure, install:

- Terraform
- AWS CLI
- kubectl
- eksctl

Also configure AWS credentials:

```bash
aws configure
```

---

## Deployment Steps

### Clone Repository

```bash
git clone https://github.com/shubhangichavan024/terraform-aws-eks-platform-dev.git

cd terraform-aws-eks-platform-dev
```

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Preview Infrastructure

```bash
terraform plan
```

### Deploy Infrastructure

```bash
terraform apply
```

---

## Verify EKS Cluster

Update kubeconfig

```bash
aws eks update-kubeconfig --region ap-south-1 --name <cluster-name>
```

Verify Nodes

```bash
kubectl get nodes
```

Verify Cluster

```bash
kubectl get pods -A
```

---

## Remote State

Terraform state is stored securely in an Amazon S3 bucket, allowing:

- Team collaboration
- Consistent deployments
- Centralized state management

---

## Learning Outcomes

Through this project, I gained hands-on experience with:

- Infrastructure as Code (IaC)
- Terraform Modules
- AWS Networking
- Amazon EKS
- Kubernetes Cluster Provisioning
- Remote State Management
- AWS IAM
- High Availability Architecture

---

## Future Improvements

- GitHub Actions CI/CD
- Helm deployment automation
- AWS Load Balancer Controller
- ArgoCD GitOps
- Prometheus & Grafana Monitoring
- Cluster Autoscaler
- Karpenter
- AWS Secrets Manager Integration

---

## Author

**Shubhangi Chavan**

- LinkedIn: https://www.linkedin.com/in/shubhangi-chavan-2820a3229/
- GitHub: https://github.com/shubhangichavan024

---

## License

This project is intended for learning and portfolio purposes.
