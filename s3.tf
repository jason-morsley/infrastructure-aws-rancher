#       _____   ____      
#      / ____| |___ \    
#     | (___     __) |  
#      \___ \   |__ <  
#      ____) |  ___) |  
#     |_____/  |____/  

module "rancher-s3-bucket" {

  source = "jason-morsley/s3-bucket/aws"

  name = local.bucket_name

}