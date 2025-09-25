# vpc/outputs.tf
# Since you're using a VPC module, reference the module outputs

# These outputs will depend on what the VPC module provides.
# Adjust the output names and values based on the actual outputs of your VPC module.

# To call these outputs after applying the configuration, use:
# terraform output <output_name>

# To use these outputs in another module, you can reference them in a state block as:
# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "your-terraform-state-bucket"
#     key    = "path/to/your/vpc/terraform.tfstate"
#     region = "your-region"
#   }
# }

# Then you can access the outputs like:
# data.terraform_remote_state.vpc.<output_name>

# Outputs based on common VPC attributes:

output "security_group_ids" {
  description = "Default security group ID"
  value       = module.vpc.security_group_ids
}

output "public_subnet_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_route_table_id" {
  description = "Default security group ID"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "Default security group ID"
  value       = module.vpc.private_route_table_id
}