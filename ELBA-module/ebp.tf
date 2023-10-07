# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "vprofile_eb_app" {
  name        = "vprofile-eb-app"
  description = "Elastic Beanstalk Application"
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "vprofile_eb_env" {
  name                = "vprofile-eb-env"
  application         = aws_elastic_beanstalk_application.vprofile_eb_app.name
  solution_stack_name = "64bit Amazon Linux 2 v4.3.12 running Tomcat 8.5 Corretto 8"
  #solution_stack_name = "64bit Amazon Linux 2023 v6.0.1 running Node.js 18"
  #solution_stack_name =  "64bit Amazon Linux 2023 v4.0.1 running PHP 8.1"

  # aws elasticbeanstalk list-available-solution-stacks | grep Tomcat
  # aws elasticbeanstalk list-available-solution-stacks | Select-String "Tomcat"




  ########### other config


  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = data.aws_vpc.vprofile_vpc.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = data.aws_key_pair.my_key_pair.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id])
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = data.aws_security_group.elastic_beanstalk_sg.id
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }


  tags = {
    Name = "vprofile_eb_app"
  }

}



