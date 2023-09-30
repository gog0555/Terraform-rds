module "network" {
  source = "../../modules/network"

  env  = var.env
  name = var.name

  cidr_block = var.cidr_block
  subnet     = var.subnet
  vpc_id     = module.network.vpc_id
}


module "ec2" {
  source = "../../modules/ec2"

  env  = var.env
  name = var.name

  vpc_id        = module.network.vpc_id
  public_subnet = module.network.public_subnet

  instance_ami  = var.instance_ami
  instance_type = var.instance_type

  depends_on = [module.network]
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  env  = var.env
  name = var.name

  instance_ami  = var.instance_ami
  instance_type = var.instance_type

  ec2_sg_id     = module.ec2.ec2_sg_id
  public_subnet = module.network.public_subnet

  depends_on = [module.network]
}

module "rds" {
  source = "../../modules/rds"

  env  = var.env
  name = var.name

  db_storage        = var.db_storage
  db_storage_type   = var.db_storage_type
  db_name           = var.db_name
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  db_username       = var.db_username
  db_password       = var.db_password

  vpc_id         = module.network.vpc_id
  public_subnet  = module.network.public_subnet
  private_subnet = module.network.private_subnet

  ec2_sg_id     = module.ec2.ec2_sg_id

  depends_on = [module.network]
}
