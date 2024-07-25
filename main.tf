module "vpc" {
  source = "./modules/vpc"
}

module "subnet" {
  source = "./modules/subnets"
  vpcid = module.vpc.vpc_id
}

module "sg" {
  source = "./modules/sg"
  vpcid = module.vpc.vpc_id
}

module "igw" {
  source = "./modules/igw"
  vpcid = module.vpc.vpc_id
}

module "rt" {
  source = "./modules/rt"
  vpcid = module.vpc.vpc_id
  igwid = module.igw.igw_id
  sub1id = module.subnet.sub1_id
  sub2id = module.subnet.sub2_id
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  instanceType = var.instanceType
  sub1id = module.subnet.sub1_id
  sub2id = module.subnet.sub2_id
  sgid = [module.sg.sg_id]

}

module "lb" {
  source = "./modules/lb"
  sgid = [module.sg.sg_id]
  subnets = [module.subnet.sub1_id, module.subnet.sub2_id]
  vpcid = module.vpc.vpc_id
  instance1_id = module.ec2.web_instance_id
  instance2_id = module.ec2.web2_instance_id
}
