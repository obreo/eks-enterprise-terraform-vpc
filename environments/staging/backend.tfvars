    bucket       = "abra-terraform-states"
    key          = "kubernetes/vpc/staging.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true

# To run the initialization with this backend config file, use:
# terraform init -backend-config=environments/staging/backend.tfvars