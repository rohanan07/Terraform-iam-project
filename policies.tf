resource "aws_iam_policy" "force_mfa" {
  name = "force-mfa"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowMFASetup"
        Effect = "Allow"
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:EnableMFADevice",
          "iam:GetUser",
          "iam:ListMFADevices",
          "iam:ListVirtualMFADevices",
          "iam:ResyncMFADevice"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyAllWithoutMFA"
        Effect = "Deny"
        Action = "*"
        Resource = "*"
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "education_read_only" {
  name = "education-read-only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadOnlyCoreServices"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:Get*",
          "s3:List*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Get*",
          "logs:Describe*",
          "rds:Describe*",
          "lambda:Get*",
          "lambda:List*"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "managers_view_only" {
  name = "managers-view-only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "InfraReadOnly"
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:Get*",
          "s3:List*",
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "rds:Describe*"
        ]
        Resource = "*"
      },
      {
        Sid    = "BillingAccess"
        Effect = "Allow"
        Action = [
          "aws-portal:ViewBilling",
          "aws-portal:ViewUsage",
          "ce:Get*",
          "ce:List*",
          "budgets:ViewBudget"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy" "engineers_ec2" {
  name = "engineers-ec2-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EC2FullAccess"
        Effect = "Allow"
        Action = "ec2:*"
        Resource = "*"
      },
      {
        Sid    = "DenyIAM"
        Effect = "Deny"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "engineers_s3" {
  name = "engineers-s3-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3FullAccess"
        Effect = "Allow"
        Action = "s3:*"
        Resource = "*"
      },
      {
        Sid    = "DenyIAM"
        Effect = "Deny"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "engineers_monitoring" {
  name = "engineers-monitoring-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudWatchAndLogs"
        Effect = "Allow"
        Action = [
          "cloudwatch:*",
          "logs:*"
        ]
        Resource = "*"
      },
      {
        Sid    = "DenyIAM"
        Effect = "Deny"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "engineers_lambda" {
  name = "engineers-lambda-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "LambdaFullAccess"
        Effect = "Allow"
        Action = "lambda:*"
        Resource = "*"
      },
      {
        Sid    = "DenyIAM"
        Effect = "Deny"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "engineers_rds" {
  name = "engineers-rds-full-access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "RDSFullAccess"
        Effect = "Allow"
        Action = "rds:*"
        Resource = "*"
      },
      {
        Sid    = "DenyIAM"
        Effect = "Deny"
        Action = "iam:*"
        Resource = "*"
      }
    ]
  })
}
