terraform {
  source = "../../../lambdas"
}

inputs = {
  stage = "gamma"
}

include {
  path = find_in_parent_folders()
}