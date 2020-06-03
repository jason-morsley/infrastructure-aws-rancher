#    _____                  _               
#   |  __ \                | |              
#   | |__) |__ _ _ __   ___| |__   ___ _ __ 
#   |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   

# Install Rancher on the above Kubernetes cluster...
resource "null_resource" "install-rancher" {

  depends_on = [
    aws_route53_record.a-record,
    module.rancher-cluster
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "bash ${path.module}/scripts/install_rancher.sh"
    environment = {
      FOLDER    = "${path.cwd}/k8s"
      NAMESPACE = var.namespace
      HOSTNAME  = "${var.subdomain}.${var.domain}"
    }
  }

}

# Is Rancher ready...?
//resource "null_resource" "is-concourse-ready" {
//
//  depends_on = [
//    null_resource.install-rancher
//  ]
//
//  # https://www.terraform.io/docs/provisioners/local-exec.html
//
//  provisioner "local-exec" {
//    command = "bash ${path.module}/${local.shared_scripts_folder}/kubernetes/are_deployments_ready.sh ${path.cwd}/k8s/kube-config.yaml ${var.namespace}"
//  }
//
//}

# Configure Route53...
//module "route53" {
//
//  source = "../terraform-aws-kubernetes-cluster/modules/route53"
//
//  domain    = var.domain
//  subdomain = var.subdomain
//  public_ip = module.rancher-cluster.public_ip
//
//}