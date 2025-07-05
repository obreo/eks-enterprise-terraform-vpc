variable "name" {
  description = "Metadata for the VPC"
  type        = string
}

variable "vpc" {
  type = object({
    vpc_cidr_block             = string
    public_subnet_cidr_blocks  = list(string)
    private_subnet_cidr_blocks = list(string)
    create_private_subnets_nat = bool
    availability_zones         = list(string)

    include_eks_tags = object({
      cluster_name    = string
      shared_or_owned = string
    })

    enable_aws_ipv6_cidr_block = object({
      public_cidr_count_prefix64  = number
      private_cidr_count_prefix64 = number
    })
  })
}

variable "security_groups" {
  type = map(object({
    name        = optional(string)
    description = optional(string)
    tags        = optional(map(string))

    inbound = optional(object({
      rule_description = optional(string)
      ports            = optional(list(number))
      ip_protocol      = optional(string, "tcp")
      destination = optional(object({
        cidr_ipv4      = optional(string)
        cidr_ipv6      = optional(string)
        security_group = optional(string)
        prefix_list_id = optional(string)
      }))
    }))
  }))
}

