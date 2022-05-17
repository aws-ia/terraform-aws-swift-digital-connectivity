resource "aws_iam_role" "role" {
  name                 = var.name
  permissions_boundary = var.permissions_boundary
  assume_role_policy = jsonencode(
    {
      "Version" : "2008-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : var.trusted_aws_services
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_policy" "policy" {
  name   = var.name
  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each = toset(var.attach_policies)

  role       = aws_iam_role.role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "profile" {
  name = var.name
  role = aws_iam_role.role.name
}

output "arn" {
  value = aws_iam_role.role.arn
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.profile.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.profile.name
}
