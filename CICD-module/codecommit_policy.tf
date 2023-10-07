resource "aws_iam_policy" "vprofile-code-admin-repo-fullaccess" {
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "codecommit:*",
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "codecommit:ListRepositoriesForApprovalRuleTemplate",
        "codecommit:CreateApprovalRuleTemplate",
        "codecommit:UpdateApprovalRuleTemplateName",
        "codecommit:GetApprovalRuleTemplate",
        "codecommit:ListApprovalRuleTemplates",
        "codecommit:DeleteApprovalRuleTemplate",
        "codecommit:ListRepositories",
        "codecommit:UpdateApprovalRuleTemplateContent",
        "codecommit:UpdateApprovalRuleTemplateDescription"
      ],
      "Resource": "*"
    },
    {
      "Sid": "VisualEditor1",
      "Effect": "Allow",
      "Action": "codecommit:*",
      "Resource": "arn:aws:codecommit:${var.region}:${data.aws_caller_identity.current.account_id}:${var.repository_name}"
    }
  ]
}
EOF
}