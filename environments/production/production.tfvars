
name = "kubernetes-production"

vpc = {
  vpc_cidr_block             = "10.9.0.0/16"
  public_subnet_cidr_blocks  = ["10.9.0.0/22","10.9.4.0/22"]
  private_subnet_cidr_blocks = ["10.9.8.0/22","10.9.12.0/22"]
  create_private_subnets_nat = true
  availability_zones         = ["us-east-1a", "us-east-1b"]

  include_eks_tags = {
    cluster_name    = "kubernetes-production"
    shared_or_owned = "owned"
  }

  enable_aws_ipv6_cidr_block = {
    public_cidr_count_prefix64 = 2
    private_cidr_count_prefix64 = 2
  }
}

security_groups = {
    "alb_ipv4" = {
      name        = "ipv4_alb_inbound"
      description = "allowing http, https"
      tags       = {
        Environment = "Prod"
      }
      inbound = {
        ports = [80,443] # The ports to allow inbound traffic
        ip_protocol = "tcp" # The protocol to allow (e.g., tcp, udp)
        destination = {
            cidr_ipv4      = "0.0.0.0/0"
        }
      }
  }

  "alb_ipv6" = {
    name        = "ipv6_alb_inbound"
    description = "allowing http, https"
    tags       = {
      Environment = "Prod"
    }
    inbound = {
      ports = [80,443] # The ports to allow inbound traffic
      ip_protocol = "tcp" # The protocol to allow (e.g., tcp, udp)
      destination = {
          cidr_ipv6      = "::/0"
      }
    }
  }

  "eks_ipv4" = {
    name        = "ipv4_eks_inbound"
    description = "allowing http, https"
    tags       = {
      Environment = "Prod"
    }
    inbound = {
      ports = [80,443] # The ports to allow inbound traffic
      ip_protocol = "tcp" # The protocol to allow (e.g., tcp, udp)
      destination = {
          security_group = "alb_ipv4"
      }
    }
  }

  "eks_ipv6" = {
    name        = "ipv6_eks_inbound"
    description = "allowing http, https"
    tags       = {
      Environment = "Prod"
    }
    inbound = {
      ports = [80,443] # The ports to allow inbound traffic
      ip_protocol = "tcp" # The protocol to allow (e.g., tcp, udp)
      destination = {
          security_group = "alb_ipv6"
      }
    }
  }
}
