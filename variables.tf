#     __      __        _       _     _           
#     \ \    / /       (_)     | |   | |          
#      \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___ 
#       \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#        \  / (_| | |  | | (_| | |_) | |  __/\__ \
#         \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

# AWS

variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "region" {
  type = string
  default = "eu-west-2" # London
}

# VPC...

variable "vpc_name" {
  type = string
  default = "rancher"
}


variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16" # 65,531 (65,536 possible - 5 reserved by AWS)
}

variable "public_cidrs" {
  type = list(string)
  # Each is 251 (256 possible - 5 reserved by AWS)
  default = [
    "10.0.2.0/24",
    "10.0.4.0/24",
    "10.0.6.0/24"
  ]
}

//variable "private_cidrs" {
//  type = list(string)
//  # Each is 251 (256 possible - 5 reserved by AWS)
//  default = [
//    "10.0.1.0/24",
//    "10.0.3.0/24",
//    "10.0.5.0/24"
//  ] 
//}

# IAM Role

variable "iam_role_name" {
  type = string
  default = "rancher"
}

# EC2 (Node)

variable "ec2_name" {
  type = string
  default = "rancher-node"
}

variable "ec2_instance_type" {
  type = string
  default = "t3a.2xlarge"
}

# Cluster

variable "cluster_name" {
  type = string
  default = "rancher"
}

variable "namespace" {
  default = "cattle-system"
}

# Rancher


# Route 53

variable "domain" {
  default = "jasonmorsley.io"
}
variable "subdomain" {
  default = "rancher"
}
