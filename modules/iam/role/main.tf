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

data "aws_iam_policy" "policy" {
  dynamic "statement" {
    for_each = var.s3_bucket == null ? [] : [1]
    content {
      effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket}/*",
      "arn:aws:s3:::${var.s3_bucket}"
    ]
    }

  }

  statement {
    effect = "Allow"
    actions = [
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
      "kms:CreateGrant",
      "kms:*crypt"
    ]
    resources = [
      var.shared_kms_key_arn,
      "arn:aws:kms:*:${data.aws_caller_identity.source.account_id}:*/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue"
    ]
    resources = [
      "arn:aws:secretsmanager:*:${data.aws_caller_identity.source.account_id}:secret:*${var.app_team}*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:Desc*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam_policy" {
  name   = local.policy_name
  policy = data.aws_iam_policy_document.iam_policy.json
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