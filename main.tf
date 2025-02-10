resource "aws_vpc" "vpc-tf" {
  cidr_block = var.cidr
}
resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.vpc-tf.id
  cidr_block = var.cidr_sub
  availability_zone = var.az1
  map_public_ip_on_launch = true
}


resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.vpc-tf.id
  cidr_block = var.cidr_sub2
  availability_zone = var.az2
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "int-gateway" {
  vpc_id = aws_vpc.vpc-tf.id
}

resource "aws_route_table" "rout-table" {
  vpc_id = aws_vpc.vpc-tf.id

  route {
    cidr_block = var.rt_route
    gateway_id = aws_internet_gateway.int-gateway.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.rout-table.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.rout-table.id
}

resource "aws_security_group" "web-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-tf.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "arvind-s3-bucket-from--aws01"
}

resource "aws_instance" "webserver1" {
  ami                    = var.ami_id
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.sub1.id
  user_data              = base64encode(file("script1.sh"))
}

resource "aws_instance" "webserver2" {
  ami                    = var.ami_id
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.sub2.id
  user_data              = base64encode(file("script2.sh"))
}

resource "aws_lb" "app-load-bal" {
  name               = "app-load-bal"
  internal           = false
  load_balancer_type = var.loadbal-type

  security_groups = [aws_security_group.web-sg.id]
  subnets         = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "web"
  }
}

resource "aws_lb_target_group" "target-gp" {
  name     = "target-grp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-tf.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.target-gp.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.target-gp.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app-load-bal.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.target-gp.arn
    type             = "forward"
  }
}

output "loadbalancerdns" {
  value = aws_lb.app-load-bal.dns_name
}