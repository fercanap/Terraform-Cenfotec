# AWS Final Lab – Terraform Project

This project demonstrates the deployment of a well-architected infrastructure on AWS using Terraform. It includes a Virtual Private Cloud (VPC), subnets, routing, bastion host, Application Load Balancer (ALB), Auto Scaling Group (ASG), and secure access configuration—all deployed using Infrastructure as Code (IaC) principles.

## 📦 Project Structure

```
aws-final-lab/
│
├── main.tf                    # Root module to orchestrate all submodules
├── variables.tf               # Input variables for the root module
├── terraform.tf               # Terraform backend and provider settings
├── autoscalingGroups/        # Auto Scaling Group and Launch Template
├── ec2/                      # Bastion host instance
├── key/                      # SSH key pair definition
├── loadbalancer/             # ALB, Target Groups, Listener
├── network/                  # VPC, Subnets, Routes, IGW, NAT
├── securityGroups/           # Security Groups for each layer
├── config/                   # User data scripts for instance configuration
├── scripts/                  # Cleanup and diagnostic automation scripts
└── outputs.tf                # Outputs for SSH and ALB URL
```

## 🚀 Getting Started

### Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.5
- SSH Key (`key.pem`) with correct permissions
- Permissions to create and destroy resources in AWS (EC2, VPC, IAM, ASG, etc.)

### Terraform Cloud Backend

Make sure you’ve configured the correct Terraform Cloud workspace in `terraform.tf`:

```hcl
cloud {
  organization = "fercanap"
  workspaces {
    name = "aws-final-lab"
  }
}
```

## ⚙️ How to Deploy

```bash
# Initialize and validate
terraform init
terraform validate

# Plan and apply all resources
terraform plan
terraform apply --auto-approve
```

After completion, check the outputs:

```bash
terraform output bastion_ssh_command
terraform output web_alb_url
```

## �� Testing the Environment

- SSH to the bastion host using the output command.
- Access the deployed web app via the Application Load Balancer URL.

## 🧹 Cleanup

To destroy all provisioned AWS resources and reset the environment:

```bash
# Run Terraform destroy (recommended if no external changes were made)
terraform destroy --auto-approve

# Or run the custom cleanup script if some resources were imported or manually created
./aws_cleanup_full.sh
```

## 🛠️ Troubleshooting

Use the diagnosis script to check for remaining AWS resources or failed deletions:

```bash
./aws_diagnose_lab.sh > diagnostico_output.txt
```

You can review the output file and validate what is still running in your AWS account.

## ✍️ Author

- **Fernando Canales (fercanap)**
- GitHub: [github.com/fercanap](https://github.com/fercanap)
