provider"aws" {
  region = var.aws_region
}

module "network" {
  source    = "./modules/network"
  vpc_cidr  = var.vpc_cidr
  aws_region = var.aws_region
}

module "alb" {
  source      = "./modules/network/alb"
  vpc_id      = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  alb_sg_id   = module.network.alb_sg_id
}

module "ec2" {
  source         = "./modules/network/ec2"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  ec2_count      = var.ec2_count
  subnet_ids     = module.network.public_subnet_ids
  vpc_id         = module.network.vpc_id
  alb_sg_id      = module.network.alb_sg_id
  target_group_arn = module.alb.target_group_arn
}
