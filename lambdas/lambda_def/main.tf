provider "aws" {
  region = "us-east-1"
}

module "lambda_role" {
  source = "./lambda_role"
  stage = var.stage
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "example_lambda_${var.stage}"
  handler      = "index.lambda_handler"
  runtime      = "python3.8"
  filename     = "${var.filepath}/index.zip"
  role = module.lambda_role.role_arn
  source_code_hash = filebase64sha256("${var.filepath}/index.py")

  depends_on = [
    module.lambda_role.attach_iam_policy_to_iam_role,
    data.archive_file.zip_the_python_code
  ]

  environment {
    variables = {
      KEY1 = "value1",
      KEY2 = "value2",
    }
  }
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = var.filepath
  output_path = "${var.filepath}/index.zip"
}
