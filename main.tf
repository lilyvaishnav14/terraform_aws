resource "aws_vpc" "vpc" {
	cidr_block       = "10.0.0.0/16"

}

resource "aws_subnet" "sub1" {
  cidr_block = "10.0.0.0/17"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "sub2" {
  cidr_block = "10.0.128.0/17"
  vpc_id = aws_vpc.vpc.id
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

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id
  
  
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = aws_subnet.sub1.id
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.rt2.id
  subnet_id = aws_subnet.sub2.id
}

resource "aws_instance" "web" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
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
  egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
}