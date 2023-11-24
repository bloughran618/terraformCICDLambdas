locals {
  parsed = regex(".*/stages/(?P<env>.*?)/.*", get_terragrunt_dir())
  env    = local.parsed.env
}

# Configure S3 as a backend
remote_state {
    backend = "s3"
    config  = {
    bucket = "terraform-cicd-lambdas-${local.env}"
#    bucket = "terraform-cicd-lambdas-${var.stage}"
    region = "us-east-1"
    key    = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
