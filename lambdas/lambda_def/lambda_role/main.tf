resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_terraform_execution_role_${var.stage}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "lambda_execution_policy" {

  name         = "aws_iam_policy_for_terraform_aws_lambda_role_${var.stage}"
  path         = "/"
  description  = "AWS IAM Policy for managing aws lambda role"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role        = aws_iam_role.lambda_execution_role.name
  policy_arn  = aws_iam_policy.lambda_execution_policy.arn
}