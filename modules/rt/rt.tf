resource "aws_route_table" "rt1" {
  vpc_id = var.vpcid
  route {
	cidr_block = "0.0.0.0/0"
	gateway_id = var.igwid
  }
  
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = var.sub1id
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.rt1.id
  subnet_id = var.sub2id
}