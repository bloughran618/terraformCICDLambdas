module "pkg1" {
  source = "./lambda_def"
  stage = var.stage
  filepath = "${path.module}/python/pkg1/src"
}