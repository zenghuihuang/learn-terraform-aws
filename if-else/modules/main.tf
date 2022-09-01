terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only-policy"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "cloudwatch_full_access_only" {
  name   = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}

variable "cloudwatch_full_access" {
  description = "Full access to cloudwatch when set to true"
  type        = bool
}

variable "iam_user" {
  description = "A new IAM user"
  type        = string
}

resource "aws_iam_user" "example" {
  name = var.iam_user
}

resource "aws_iam_user_policy_attachment" "user_cloudwatch_full_access" {
  count = var.cloudwatch_full_access ? 1 : 0

  user       = aws_iam_user.example.name
  policy_arn = aws_iam_policy.cloudwatch_full_access_only.arn
}