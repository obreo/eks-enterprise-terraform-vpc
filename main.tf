module "vpc" {
  source = "git::https://github.com/obreo/effortless-eks.git//modules/vpc?ref=main"
  name   = var.name
  vpc_settings = {
    vpc_cidr_block             = var.vpc.vpc_cidr_block
    public_subnet_cidr_blocks  = var.vpc.public_subnet_cidr_blocks # Optional if private subnet cidr created
    private_subnet_cidr_blocks = var.vpc.private_subnet_cidr_blocks # Optional if public subnet cidr created
    create_private_subnets_nat = var.vpc.create_private_subnets_nat # Optional, defaults to true
    availability_zones         = var.vpc.availability_zones

    include_eks_tags = { # Optional, Required for EKS cluster.
      cluster_name    = var.vpc.include_eks_tags.cluster_name
      shared_or_owned = var.vpc.include_eks_tags.shared_or_owned # Defaults to "owned" which is used for a single k8s ingress service, that will then use nginx controller as shared
    }

    enable_aws_ipv6_cidr_block = {
      public_cidr_count_prefix64 = var.vpc.enable_aws_ipv6_cidr_block.public_cidr_count_prefix64
      private_cidr_count_prefix64 = var.vpc.enable_aws_ipv6_cidr_block.private_cidr_count_prefix64
    }
  }

  security_groups = var.security_groups
}

