module "vpc" {
  source = "github.com/obreo/effortless-eks/tree/main/modules/vpc"
  name   = var.name
  vpc_settings = {
    vpc_cidr_block             = var.vpc.vpc_cidr_block # Required
    public_subnet_cidr_blocks  = var.vpc.public_subnet_cidr_blocks # Optional if private subnet cidr created
    private_subnet_cidr_blocks = var.vpc.private_subnet_cidr_blocks # Optional if public subnet cidr created
    create_private_subnets_nat = var.vpc.create_private_subnets_nat # Optional, defaults to true
    availability_zones         = var.vpc.availability_zones
    security_group = { # Optional
      ports       = var.vpc.security_group.ports
      ip_protocol = var.vpc.security_group.ip_protocol # Defaults to "tcp", for all ports "-1"
      source = { # Only one source is allowed.
        cidr_ipv4   = var.vpc.security_group.source
      }
      ssh_port = {}
    }
    include_eks_tags = { # Optional, Required for EKS cluster.
      cluster_name    = var.vpc.include_eks_tags.cluster_name
      shared_or_owned = var.vpc.include_eks_tags.shared_or_owned # Defaults to "owned"
    }
  }
}