resource "aws_codepipeline" "vprofile_cicd_pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_service_role.arn

  artifact_store {
    location = "elasticbeanstalk-ap-south-1-574721397869"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = var.source_stage_provider
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      configuration = {
        RepositoryName = var.source_stage_RepositoryName
        BranchName     = var.source_stage_BranchName
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      configuration = {
        ProjectName = var.build_stage_ProjectName
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployAction"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      version         = "1"
      input_artifacts = ["BuildArtifact"]
      configuration = {
        ApplicationName = var.deploy_stage_ApplicationName
        EnvironmentName = var.deploy_stage_EnvironmentName
      }
    }
  }
}


