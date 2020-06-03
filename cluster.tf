#      _____                  _
#     |  __ \                | |
#     | |__) |__ _ _ __   ___| |__   ___ _ __
#     |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#     | | \ \ (_| | | | | (__| | | |  __/ |
#     |_|  \_\__,_|_| |_|\___|_| |_|\___|_|
#            _____ _           _            
#           / ____| |         | |           
#          | |    | |_   _ ___| |_ ___ _ __ 
#          | |    | | | | / __| __/ _ \ '__|
#          | |____| | |_| \__ \ ||  __/ |   
#           \_____|_|\__,_|___/\__\___|_|   

module "rancher-cluster" {

  source = "jason-morsley/kubernetes-cluster/aws"

  cluster_name = var.cluster_name

  bucket_name = local.bucket_name

  ec2_data = [
    {
      user = "ubuntu"
      role = ["controlplane", "etcd", "worker"]
      public_ip = module.rancher-node-1-ec2.public_ip
      private_ip = module.rancher-node-1-ec2.private_ip
      encoded_private_key = module.rancher-node-1-ec2.encoded_private_key
    },
        {
          user = "ubuntu"
          role = ["controlplane", "etcd", "worker"]
          public_ip = module.rancher-node-2-ec2.public_ip
          private_ip = module.rancher-node-2-ec2.private_ip
          encoded_private_key = module.rancher-node-2-ec2.encoded_private_key
        },
        {
          user = "ubuntu"
          role = ["controlplane", "etcd", "worker"]
          public_ip = module.rancher-node-3-ec2.public_ip
          private_ip = module.rancher-node-3-ec2.private_ip
          encoded_private_key = module.rancher-node-3-ec2.encoded_private_key
        }
  ]

  mock_depends_on = [
    module.rancher-vpc,
    module.rancher-allow-all-sg,
    module.rancher-node-1-ec2,
    module.rancher-node-2-ec2,
    module.rancher-node-3-ec2
  ]

}