resource "aws_vpc" "vpc" {
	cidr_block       = "10.0.0.0/16"

}

resource "aws_subnet" "sub1" {
  cidr_block = "10.0.0.0/17"
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "sub2" {
  cidr_block = "10.0.128.0/17"
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id
  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.igw.id
  }
  
}

# resource "aws_route_table" "rt2" {
#   vpc_id = aws_vpc.vpc.id
# }

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.sub1.id
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.sub2.id
}

resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instanceType
  subnet_id = aws_subnet.sub1.id
  user_data = "${file("userdata.sh")}"
  security_groups = [ aws_security_group.sg.id ]
  associate_public_ip_address = true
}
resource "aws_instance" "web2" {
  ami = var.ami
  instance_type = var.instanceType
  subnet_id = aws_subnet.sub2.id
  user_data = "${file("userdata2.sh")}"
  security_groups = [ aws_security_group.sg.id ]
  associate_public_ip_address = true
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_lb" "test" {
  # name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]
}

resource "aws_lb_target_group" "tg" {
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "attach1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web.id
  port = 80

}

resource "aws_lb_target_group_attachment" "attach2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web2.id
  port = 80

}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.test.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}