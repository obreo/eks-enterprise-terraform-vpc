    bucket       = "abra-terraform-states"
    key          = "kubernetes/prod_terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true

    # Command
    # terraform init -backend-config=environments/production/backend.tfvars