# EKS Enterprise - IaC - VPC

This infrastructure defines a **VPC architecture** for an **AWS EKS cluster** using a Terraform custom module.

The architecture aims to deploy a **dual-stack, multi-AZ infrastructure** with NAT, Egress-only, and Internet Gateways.

The infrastructure is integrated with **Application Load Balancer Controller VPC tags**, so they are recognized automatically once the controller is setup.

This VPC infrastructure is dual-stack, meaning it uses both **IPv6** and **IPv4**:

* **IPv6:** used for Kubernetes-native IPv6 pods.
* **IPv4:** used to connect Kubernetes to AWS IPv4-based services via NAT. Most AWS services, including the EKS API, support IPv4 or dual-stack only, but not IPv6-only.

The **NAT gateway** connects the EKS cluster to AWS services over IPv4 endpoints. For client access, the **Application Load Balancer (ALB)** is dual-stack to receive connections from both IPv6 and IPv4 and forward them to IPv6-only pods.

IPv6 subnets are routed to **Egress-only Internet Gateways** for outbound internet connectivity.

---

# GitOps Workflow

This module integrates with **GitHub Actions** workflow using **OpenID Connect (OIDC)** to authenticate with AWS. The workflow:

1. Clones the source repository.
2. Retrieves the updated Terraform module.
3. Plans and applies the deployment per environment.

* **Staging:** replicates production.
* **Development:** verifies the plan before moving to staging or production.

---

# Prerequisites

* Terraform
* Configured AWS CLI with permissions for VPC resources.
* Private S3 bucket with `PutObject` and `GetObject` permissions for Terraform state.

---

# How to Use Template

1. Clone the main branch.
2. Configure `environments/ENVIRONMENT/backend.tfvars` to connect to the S3 bucket per environment.
3. Configure `environments/ENVIRONMENT/ENVIRONMENT.tfvars` with the required environment variables.

By default, **only production and staging environments** are created. The development environment uses the staging state for verification; resources are not deployed, only validated by the workflow.

4. Deploy the infrastructure:

```bash
terraform init -backend-file "environments/ENV/backend.tfvars"

terraform plan -var-file "environments/ENV/ENV.tfvars" -out=tfplan

terraform apply "tfplan"
```

For further configuration, refer to the [VPC module](https://github.com/obreo/iac-modules.git/terraform/vpc?ref=main).
