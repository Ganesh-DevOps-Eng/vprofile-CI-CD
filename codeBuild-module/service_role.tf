
resource "aws_iam_role" "codebuild_vprofile_build_service_role" {
  name               = "codebuild-vprofile-Build-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name = "codebuild-vprofile-Build-service-role-policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/Vprofile-Build",
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/Vprofile-Build:*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::codepipeline-${var.region}-${data.aws_caller_identity.current.account_id}-*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:codecommit:${var.region}:${data.aws_caller_identity.current.account_id}:Vprofile-code-repo"
      ],
      "Action": [
        "codecommit:GitPull"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::elasticbeanstalk-${var.region}-${data.aws_caller_identity.current.account_id}",
        "arn:aws:s3:::elasticbeanstalk-${var.region}-${data.aws_caller_identity.current.account_id}/*"
      ],
      "Action": [
        "s3:PutObject",
        "s3:GetBucketAcl",
        "s3:GetBucketLocation"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:BatchPutCodeCoverages"
      ],
      "Resource": [
        "arn:aws:codebuild:${var.region}:${data.aws_caller_identity.current.account_id}:report-group/Vprofile-Build-*"
      ]
    }
  ]
}
EOF
  }

  inline_policy {
    name = "CodeBuildCloudWatchLogsInlinePolicy-Vprofile-Build-ap-south-1"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:vprofile-cicd-project",
        "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:vprofile-cicd-project:*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    }
  ]
}
EOF
}
}