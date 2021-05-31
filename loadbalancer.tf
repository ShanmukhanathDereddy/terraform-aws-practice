## HTTP Load balamcer ##

# Create application load balancer

resource "aws_lb" "http" {
  name               = "http-lb"
  subnets            = [ aws_subnet.http.*.id ]
  load_balancer_type = "application"
  tags = {
    Name = "http-lb"
  }
}

# create listener for load balancer http

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.http.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.http.arn
    type             = "forward"
  }
}

# create target group for load balancer
resource "aws_lb_target_group" "http" {
  name     = "http-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform.id
  tags = {
    name = "http-lb-target-group"
  }
}

#Adding instances to target group
resource "aws_lb_target_group_attachment" "http" {
  for_each         = var.http_instance_names
  target_group_arn = aws_lb_target_group.http.id
  target_id        = aws_instance.http[each.key].id
  port             = 80
}

## DB Load Balancer ##

#create a application load balancer
resource "aws_lb" "db" {
  name               = "db-lb"
  subnets            = [ aws_subnet.db.*.id ]
  load_balancer_type = "application"
  tags = {
    Name = "db-lb"
  }
}

## create a load balancer listner
resource "aws_lb_listener" "db" {
  load_balancer_arn = aws_lb.db.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.db.arn
  }
}

# create a target group for DB LB
resource "aws_lb_target_group" "db" {
  name     = "db-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform.id
  tags = {
    Name = "db-lb-target-group"
  }
}

# Add instances to target group
resource "aws_lb_target_group_attachment" "db" {
  for_each         = var.db_instance_names
  target_group_arn = aws_lb_target_group.db.id
  target_id        = aws_instance.db[each.key].id
  port             = 80
}
