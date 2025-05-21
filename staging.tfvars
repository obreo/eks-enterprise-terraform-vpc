
name = "kubernetes-staging"
vpc_settings = {
  vpc_cidr_block             = "10.10.0.0/16"
  public_subnet_cidr_blocks  = ["10.10.0.0/22","10.10.4.0/22"]
  private_subnet_cidr_blocks = ["10.10.8.0/22","10.10.12.0/22"]
  create_private_subnets_nat = true
  availability_zones         = ["us-east-1a", "us-east-1b"]
  security_group = {
    ports       = [80, 443]
    ip_protocol = "tcp"
    source = "0.0.0.0/0"
  }
  include_eks_tags = {
    cluster_name    = "kubernetes-staging"
    shared_or_owned = "owned"
  }
}
