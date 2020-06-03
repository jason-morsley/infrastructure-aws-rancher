#      _   _           _        ___  
#     | \ | |         | |      |__ \ 
#     |  \| | ___   __| | ___     ) |
#     | . ` |/ _ \ / _` |/ _ \   / / 
#     | |\  | (_) | (_| |  __/  / /_ 
#     |_| \_|\___/ \__,_|\___| |____|

module "rancher-node-2-ec2" {

  source = "jason-morsley/ec2/aws"

  name = local.node_2_name

  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  vpc_id = module.rancher-vpc.id

  iam_instance_profile_name = module.rancher-iam-role.instance_profile_name

  public_subnet_id = module.rancher-vpc.public_subnet_ids[1]

  security_group_ids = [
    module.rancher-allow-all-sg.id
  ]

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = local.cluster_id_tag

  bucket_name = local.bucket_name

  docker = true

  mock_depends_on = [
    module.rancher-s3-bucket
  ]

}