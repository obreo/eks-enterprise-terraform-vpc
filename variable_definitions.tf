variable "name" {
  description = "Metadata for the VPC"
  type = string
}

variable "vpc" {
  type = object({
    vpc_cidr_block             = string
    public_subnet_cidr_blocks  = list(string)
    private_subnet_cidr_blocks = list(string)
    create_private_subnets_nat = bool
    availability_zones         = list(string)
    security_group = object({
      ports       = list(number)
      ip_protocol = string
      source = string
    })
    include_eks_tags = object({
      cluster_name    = string
      shared_or_owned = string
    })
  })
}
