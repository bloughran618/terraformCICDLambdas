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
  filename     = data.archive_file.zip_the_python_code.output_path
  role = module.lambda_role.role_arn
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256

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

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${var.filepath}/requirements.txt -t ${var.filepath}/"
  }

  triggers = {
    dependencies_versions = filemd5("${var.filepath}/requirements.txt")
    source_versions = filemd5("${var.filepath}/index.py")
  }
}

data "archive_file" "zip_the_python_code" {
  depends_on = [null_resource.install_dependencies]
  excludes   = [
    "__pycache__",
    "venv",
  ]

  type        = "zip"
  source_dir  = var.filepath
  output_path = "${var.filepath}/lambda_function.zip"
}
