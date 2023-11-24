terraform {
  source = "../../../lambdas"
}

inputs = {
  stage = "beta"
}

include {
  path = find_in_parent_folders()
}