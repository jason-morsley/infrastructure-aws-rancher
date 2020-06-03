#      _____             _         _____ ____  
#     |  __ \           | |       | ____|___ \ 
#     | |__) |___  _   _| |_ ___  | |__   __) |
#     |  _  // _ \| | | | __/ _ \ |___ \ |__ < 
#     | | \ \ (_) | |_| | ||  __/  ___) |___) |
#     |_|  \_\___/ \__,_|\__\___| |____/|____/

# rancher.jasonmorsley.io

data "aws_route53_zone" "jasonmorsley-io" {

  name         = var.domain
  private_zone = false

}

resource "aws_route53_record" "a-record" {

  zone_id = data.aws_route53_zone.jasonmorsley-io.zone_id
  name    = var.subdomain
  type    = "A"
  
  #ttl     = 300
  #records = [module.rancher-node-1-ec2.public_ip]
  #records = [ aws_lb.this.dns_name ]
  
  alias {
    evaluate_target_health = false
    name = aws_lb.this.dns_name
    zone_id = aws_lb.this.zone_id
  }

}

output "route_53_name_servers" {
  value = data.aws_route53_zone.jasonmorsley-io.name_servers
}