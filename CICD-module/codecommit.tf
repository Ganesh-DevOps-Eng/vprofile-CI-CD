resource "aws_codecommit_repository" "Vprofile_code_repo" {
  repository_name = var.repository_name
  description     = var.description
}


# Create IAM User
resource "aws_iam_user" "vprofile" {
  name = var.iam_user_name
}
# Enable SSH access for IAM User
resource "aws_iam_user_ssh_key" "vprofile_IAMssh" {
  username    = aws_iam_user.vprofile.name
  encoding    = "SSH"
  public_key  = file("~/.ssh/vprofile.pub")
}
# Attach CodeCommit policy to the IAM User
resource "aws_iam_user_policy_attachment" "vprofile-code-admin" {
  user       = aws_iam_user.vprofile.name
  policy_arn = aws_iam_policy.vprofile-code-admin-repo-fullaccess.arn
}

# Output SSH Key ID
output "ssh_key_id" {
  value = aws_iam_user_ssh_key.vprofile_IAMssh.fingerprint
}
