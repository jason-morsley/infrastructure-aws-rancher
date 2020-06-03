#     ____        _               _       
#    / __ \      | |             | |      
#   | |  | |_   _| |_ _ __  _   _| |_ ___ 
#   | |  | | | | | __| '_ \| | | | __/ __|
#   | |__| | |_| | |_| |_) | |_| | |_\__ \
#    \____/ \__,_|\__| .__/ \__,_|\__|___/
#                    | |                  
#                    |_|

# VPC...

output "vpc_id" {
  value = module.rancher-vpc.id
}

output "private_subnet_ids" {
  value = module.rancher-vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.rancher-vpc.public_subnet_ids
}

output "availability_zone_names" {
  value = data.aws_availability_zones.available.names
}

# EC2...

output "ec2_private_dns" {
  value = module.rancher-node-1-ec2.private_dns
}

output "ec2_public_dns" {
  value = module.rancher-node-1-ec2.public_dns
}

output "ec2_private_ip" {
  value = module.rancher-node-1-ec2.private_ip
}

output "ec2_public_ip" {
  value = module.rancher-node-1-ec2.public_ip
}

# Load Balancer

output "load_balancer_dns_name" {
  value = aws_lb.this.dns_name
}

# Cluster

output "cluster_export_kubeconfig_command" {
  value = module.rancher-cluster.export_kubeconfig_command
}

output "cluster_kubectl_kubeconfig_command" {
  value = module.rancher-cluster.kubectl_kubeconfig_command
}

