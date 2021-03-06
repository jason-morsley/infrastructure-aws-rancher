#      _   _           _        __ 
#     | \ | |         | |      /_ |
#     |  \| | ___   __| | ___   | |
#     | . ` |/ _ \ / _` |/ _ \  | |
#     | |\  | (_) | (_| |  __/  | |
#     |_| \_|\___/ \__,_|\___|  |_|

module "rancher-node-1-ec2" {

  source = "jason-morsley/ec2/aws"

  name = local.node_1_name

  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  vpc_id = module.rancher-vpc.id

  iam_instance_profile_name = module.rancher-iam-role.instance_profile_name

  public_subnet_id = module.rancher-vpc.public_subnet_ids[0]

  security_group_ids = [
    module.rancher-allow-all-sg.id
  ]

  availability_zone = data.aws_availability_zones.available.names[0]

  tags = local.cluster_id_tag

  bucket_name = local.bucket_name

  docker = true

  mock_depends_on = [
    module.rancher-s3-bucket
  ]

}