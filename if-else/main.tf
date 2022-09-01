terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_iam_policy" "cloudwatch_read_only" {
    name = "cloudwatch-read-only-policy"
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