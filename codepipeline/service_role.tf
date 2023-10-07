
resource "aws_iam_role" "codepipeline_service_role" {
  name = var.codepipeline_service_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name   = "AWSCodePipelineServiceRole-${var.region}-${var.pipeline_name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codepipeline:StartPipelineExecution"
      ],
      "Resource": [
        "arn:aws:codepipeline:${var.region}:${var.account_id}:${var.pipeline_name}"
      ]
    }
  ]
}
EOF
}
}