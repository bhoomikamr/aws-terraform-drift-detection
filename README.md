# AWS Terraform Drift Detection

Automated infrastructure drift detection for AWS resources using **Terraform** and **GitHub Actions**.

This project provisions AWS infrastructure with Terraform and automatically checks for configuration drift between deployed AWS resources and the Terraform state file.

If drift is detected, a GitHub issue is automatically created for visibility and remediation.

---

## Features

- AWS infrastructure provisioning with Terraform
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Launch Template for EC2 instances
- Custom VPC with public/private subnets
- Security group configuration
- Remote Terraform state in S3
- State locking with DynamoDB
- Automated drift detection using GitHub Actions
- Automatic GitHub issue creation when drift is detected

---

## Architecture

The infrastructure includes:

- VPC
- Public and private subnets
- Application Load Balancer
- EC2 instances
- Auto Scaling Group
- Terraform remote backend
- GitHub Actions CI/CD workflow

### Workflow

1. Terraform provisions AWS infrastructure  
2. GitHub Actions runs `terraform plan`  
3. Terraform compares:
   - actual AWS resources
   - Terraform state  
4. If differences are found:
   - a GitHub issue is created automatically  

---

## Project Structure

```bash
aws-terraform-drift-detection/
│── .github/workflows/
│   └── drift-detect.yml
│
│── terraform/
│   ├── auto_scaling.tf
│   ├── backend.tf
│   ├── launch_template.tf
│   ├── load_balancer.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── security.tf
│   ├── variables.tf
│   └── vpc.tf
│
└── README.md
```
**Prerequisites**

Before running this project, ensure you have:

Terraform installed
AWS CLI configured
GitHub repository secrets configured
AWS IAM role for GitHub OIDC authentication

**Required GitHub Secret**

Add this secret in your GitHub repository:
```
AWS_ROLE_ARN
```
This IAM role allows GitHub Actions to access AWS securely.

**Deployment**

Initialize Terraform:

```terraform init```

Validate configuration:

```terraform validate```

Preview infrastructure:

```terraform plan```

Deploy infrastructure:

```terraform apply```

**Drift Detection Workflow**

GitHub Actions executes:
```
terraform init
terraform plan -detailed-exitcode
```

**Terraform exit codes:**

Exit Code	| Meaning
|-----------|------------|
 0	         | No changes
 1	         | Error
 2	         | Drift detected

When exit code 2 occurs:

GitHub creates an issue
Team is notified
Manual review can begin

**Example GitHub Issue**
```
Infrastructure drift detected

Drift detected by Terraform plan.
Manual intervention required.
```

**Security**

This project uses:

GitHub OIDC authentication
Temporary AWS credentials
Remote encrypted state in S3
State locking in DynamoDB

No long-term AWS keys are stored in GitHub.

**Example Use Cases**

Useful for:

DevOps portfolio projects
Infrastructure compliance monitoring
Terraform governance
Production drift monitoring
Cloud automation demonstrations

**Technologies Used**

-Terraform
-AWS
-GitHub Actions
-IAM OIDC
-EC2
-ALB
-Auto Scaling
-S3
-DynamoDB

**Future Improvements**

Possible enhancements:

Slack notifications
Email alerts
Auto-remediation
Multi-environment support
CloudWatch monitoring integration
