
resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instanceType
  subnet_id = var.sub1id
  user_data = "${file("./modules/ec2/userdata.sh")}"
  security_groups = var.sgid
  associate_public_ip_address = true
}
resource "aws_instance" "web2" {
  ami = var.ami
  instance_type = var.instanceType
  subnet_id = var.sub2id
  user_data = "${file("./modules/ec2/userdata2.sh")}"
  security_groups = var.sgid
  associate_public_ip_address = true
}



output "web_instance_id" {
  value = aws_instance.web.id
}

output "web2_instance_id" {
  value = aws_instance.web2.id
}
