output "arn" {
  value = aws_iam_role.role.arn
  description = "IAM Role ARN"
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.profile.arn
  description = "IAM Profile ARN"
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.profile.name
  description = "IAM Profile Name"
}
