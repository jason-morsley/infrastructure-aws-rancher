#      _   _      _                      _    
#     | \ | |    | |                    | |   
#     |  \| | ___| |___      _____  _ __| | __
#     | . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ /
#     | |\  |  __/ |_ \ V  V / (_) | |  |   < 
#     |_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\
#           _                     _                         
#          | |                   | |                           
#          | |     ___   __ _  __| |
#          | |    / _ \ / _` |/ _` |
#          | |___| (_) | (_| | (_| |
#          |______\___/ \__,_|\__,_|
#                ____        _                           
#               |  _ \      | |                          
#               | |_) | __ _| | __ _ _ __   ___ ___ _ __ 
#               |  _ < / _` | |/ _` | '_ \ / __/ _ \ '__|
#               | |_) | (_| | | (_| | | | | (_|  __/ |   
#               |____/ \__,_|_|\__,_|_| |_|\___\___|_|   

# https://www.terraform.io/docs/providers/aws/r/lb.html

resource "aws_lb_target_group" "http" {
  name     = "http-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = module.rancher-vpc.id
}

resource "aws_lb_target_group" "https" {
  name     = "https-tg"
  port     =443
  protocol = "TCP"
  vpc_id   = module.rancher-vpc.id
}

resource "aws_lb_target_group_attachment" "http-1" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = module.rancher-node-1-ec2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "https-1" {
  target_group_arn = aws_lb_target_group.https.arn
  target_id        = module.rancher-node-1-ec2.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "http-2" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = module.rancher-node-2-ec2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "https-2" {
  target_group_arn = aws_lb_target_group.https.arn
  target_id        = module.rancher-node-2-ec2.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "http-3" {
  target_group_arn = aws_lb_target_group.http.arn
  target_id        = module.rancher-node-3-ec2.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "https-3" {
  target_group_arn = aws_lb_target_group.https.arn
  target_id        = module.rancher-node-3-ec2.id
  port             = 443
}

resource "aws_lb" "this" {

  name               = "rancher-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = module.rancher-vpc.public_subnet_ids
  enable_cross_zone_load_balancing = true

  enable_deletion_protection = false

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.https.arn
  }
}