# codepipeline_service_role name

variable "codepipeline_service_name" {
  default = "vprofile-codepipeline-service-role"
}

# artifact_store
variable "artifact_store_location" {
  default = "elasticbeanstalk-ap-south-1-574721397869"
}


#### Source Stage
variable "source_stage_provider" {
  default = "CodeCommit"
}
variable "source_stage_RepositoryName" {
  default = "Vprofile-code-repo"
}

variable "source_stage_BranchName" {
  default = "vp-rem"
}

variable "build_stage_ProjectName" {
  default = "Vprofile-Build"
}

variable "deploy_stage_ApplicationName" {
  default = "vprofile-eb-app"
}

variable "deploy_stage_EnvironmentName" {
  default = "vprofile-eb-env"
}
#################
# variable "region" {
#   description = "AWS region"
#   default     = "ap-south-1"
# }

variable "account_id" {
  description = "AWS account ID"
  default     = "574721397869"
}

variable "pipeline_name" {
  description = "CodePipeline name"
  default     = "vprofile-cicd-pipeline"
}
