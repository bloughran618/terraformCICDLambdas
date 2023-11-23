output "role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}

output "attach_iam_policy_to_iam_role" {
  value = aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role
}