resource "aws_launch_configuration" "example" {
  image_id        = "ami-0eb82ff4044778f35"
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instance.id]
  user_data       = <<-EOF
              #!/bin/bash
              echo "HELLO, WORLD! This is a simple web server." > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"


  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow incoming requests from any IP address

  }


}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  min_size = var.min_size
  max_size = var.max_size

  # availability_zones = [var.region]
  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

}

# Create Application Load Balancer(ALB)
resource "aws_lb" "example" {
  name               = "${var.cluster_name}-example"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb.id]

}

# Create a ALB listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  #By default, return a simple 404 page
  default_action {

    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}
#By default, AWS ALBs don't allow any incoming or outgoing traffic, therefore a new security group will
#be created to receive incoming requests on port 80, and outgoing requests on all ports to perform health checks

resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"

  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Create target group for ASG.
# Target groups will perform health checks on individual servers and will take care of sending requests to them.
resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}


resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {

    path_pattern {
      values = ["*"]
    }
  }

  action {

    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}
