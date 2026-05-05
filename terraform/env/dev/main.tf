module "vpc" {
    source = "../../modules/vpc"

    vpc_cidr    = var.vpc_cidr
    env         = var.env
    subnet_cidr = var.subnet_cidr
    az          = var.az
}

module "ec2" {
    source = "../../modules/ec2"

    ami           = var.ami
    instance_type = var.instance_type
    subnet_id     = module.vpc.public_subnet_id
    vpc_id        = module.vpc.vpc_id
    env           = var.env

    key_name      = var.key_name
    instance_name = "dev-ec2"
}

resource "aws_eip" "my_ip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.instance_id
  allocation_id = aws_eip.my_ip.id
}