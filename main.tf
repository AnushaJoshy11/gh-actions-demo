terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


terraform {
 backend "remote" {
   organization = "TestAnushaOrg"

   workspaces {
     name = "gh-actions-demo"
   }
 }
}

# module "ec2_instance" {
#   source  = "terraform-aws-modules/ec2-instance/aws"
#   version = "~> 3.0"

#   name          = var.ec2_name
#   ami           = "ami-0416f96ae3d1a3f29"
#   instance_type = "t2.micro"
#   key_name      = "anushakeypair"
#   monitoring    = true
#   #vpc_security_group_ids = [module.vpc.default_security_group_id]
#   vpc_security_group_ids = var.security_group_ids
#   subnet_id              = var.subnet_id
#   availability_zone = var.availability_zone

#   tags =  {
#     Terraform   = "true"
#     Environment = "dev" 
#   }
# }

  module "sns_topic" {
    source  = "terraform-aws-modules/sns/aws"
    version = "~> 3.0"

    name = "myterraformsns-topic"
  }

  module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = "my-s3-bucket"
    acl    = "private"

    versioning = {
      enabled = true
    }

  }
