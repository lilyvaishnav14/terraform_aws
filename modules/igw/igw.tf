resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpcid
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}