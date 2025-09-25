module "vpc" {
  source = "git::https://github.com/obreo/iac-modules.git//terraform//vpc?ref=dev"
  name   = var.name
  vpc_settings = {
    vpc_cidr_block             = var.vpc.vpc_cidr_block
    public_subnet_cidr_blocks  = var.vpc.public_subnet_cidr_blocks  # Optional if private subnet cidr created
    private_subnet_cidr_blocks = var.vpc.private_subnet_cidr_blocks # Optional if public subnet cidr created
    create_private_subnets_nat = {}
    availability_zones         = var.vpc.availability_zones

    include_eks_tags = { # Optional, Required for EKS cluster.
      cluster_name    = var.vpc.include_eks_tags.cluster_name
      shared_or_owned = var.vpc.include_eks_tags.shared_or_owned # Defaults to "owned" for a single k8s ingress service (single alb endpoint per ingress), that will then use nginx controller as shared
    }

    # There is no concpet for public and private subnets in ipv6, but it is required to organize the infrastructure.
    enable_aws_ipv6_cidr_block = {
      public_cidr_count_prefix64  = var.vpc.enable_aws_ipv6_cidr_block.public_cidr_count_prefix64
      private_cidr_count_prefix64 = var.vpc.enable_aws_ipv6_cidr_block.private_cidr_count_prefix64
    }
  }

  # Key value map of security group names and their settings
  security_groups = var.security_groups
}

