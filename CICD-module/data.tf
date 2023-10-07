# data "aws_iam_policy" "vprofile-code-admin-repo-fullaccess" {
#   arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
# }

# data "aws_iam_role" "codebuild_service_role" {
#   name = "codebuild-vprofile-Build-service-role"
# }

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}


data "aws_key_pair" "my_key_pair" {
  filter {
    name = "tag:Name"
    values = ["my_key_pair"]
  }
}