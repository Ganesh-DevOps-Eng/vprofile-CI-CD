module "VPC-module" {
  source = "./VPC-module"
}

module "ELBA-module" {
  source     = "./ELBA-module"
  depends_on = [module.VPC-module]
}

module "RDS-module" {  
  source     = "./RDS-module"
  depends_on = [module.ELBA-module]
}

module "Provisioner-module" {
  source     = "./Provisioner-module"
  depends_on = [module.RDS-module]
}

module "CICD-module" {
  source     = "./CICD-module"
  depends_on = [module.Provisioner-module]
}

module "codeBuild-module" {
  source     = "./codeBuild-module"
  depends_on = [module.CICD-module]
}

module "codepipeline" {
  source     = "./codepipeline"
  depends_on = [module.codeBuild-module]
}

