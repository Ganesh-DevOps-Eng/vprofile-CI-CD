resource "aws_codebuild_project" "vprofile_build" {
  name         = "Vprofile-Build"
  description  = "CodeBuild project for Vprofile"
  service_role = aws_iam_role.codebuild_vprofile_build_service_role.arn
  
  # service_role = "codebuild-Vprofile-Build-service-role"

  source {
    type            = "CODECOMMIT"
    location        = "https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/Vprofile-code-repo"
    git_clone_depth = 1
    buildspec       = file("~/.ssh/buildspec.yml")
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  artifacts {
    type     = "S3"
    name     = "vprofile-build-artifacts"
    location = "elasticbeanstalk-${var.region}-${data.aws_caller_identity.current.account_id}"

    encryption_disabled = false
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "vprofile-cicd-project"
      stream_name = "buildlog"
    }
  }
  source_version = "refs/heads/vp-rem"
}


