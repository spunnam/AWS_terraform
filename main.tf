# main.tf
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0a346c29399cd4934"
  subnet_id              = "subnet-0ad8498fde7ac062d"
  instance_type          = "t2.micro"
  key_name               = "EC2 Practice"
  vpc_security_group_ids = ["sg-095763b3c130900bb"]
  tags = {
    Name = "test instance"
  }
}
resource "aws_security_group" "sg" {
  tags = {
    type = "terraform-test-security-group"
  }
}

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = "sg-095763b3c130900bb"
#   network_interface_id = "eni-023ef9e34a6d572c8"
# }
