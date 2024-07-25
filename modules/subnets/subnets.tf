# module "vpc" {
#   source = "../vpc"
# }

resource "aws_subnet" "sub1" {
  cidr_block = "10.0.0.0/17"
  vpc_id = var.vpcid
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "sub2" {
  cidr_block = "10.0.128.0/17"
  vpc_id = var.vpcid
  availability_zone = "us-east-1b"
}

output "sub1_id" {
  value = aws_subnet.sub1.id
}

output "sub2_id" {
  value = aws_subnet.sub2.id
}