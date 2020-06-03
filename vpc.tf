#     __      __  _____     _____ 
#     \ \    / / |  __ \   / ____|
#      \ \  / /  | |__) | | |     
#       \ \/ /   |  ___/  | |     
#        \  /    | |      | |____ 
#         \/     |_|       \_____|

module "rancher-vpc" {

  source = "jason-morsley/vpc/aws"

  name = var.vpc_name

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs = var.public_cidrs
  #private_subnet_cidrs = var.private_cidrs

  public_subnet_tags = local.cluster_id_tag

  //availability_zones = data.aws_availability_zones.available.names
  availability_zones = [ 
    data.aws_availability_zones.available.names[0],
    data.aws_availability_zones.available.names[1],
    data.aws_availability_zones.available.names[2]
  ]

}