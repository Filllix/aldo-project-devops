provider "aws" {
region = "ap-southeast-1"
}

module "vpc" {
source = "./modules/vpc"
vpc_cidr = "10.0.0.0/16"
subnet_cidr = "10.0.1.0/24"
az = "ap-southeast-1a"
}

module "ec2" {
source = "./modules/ec2"
ami = "ami-0df7a207adb9748c7"
instance_type = "t3.micro"
key_name = "devops-project"

subnet_id = module.vpc.subnet_id
vpc_id = module.vpc.vpc_id
}


