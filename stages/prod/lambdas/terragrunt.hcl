terraform {
  source = "../../../lambdas"
}

inputs = {
  stage = "prod"
}

include {
  path = find_in_parent_folders()
}