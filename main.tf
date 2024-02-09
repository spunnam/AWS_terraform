# main.tf
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0a346c29399cd4934"
  subnet_id     = "subnet-0ad8498fde7ac062d"
  instance_type = "t2.micro"
  key_name      = "EC2 Practice"
  tags = {
    Name = "Education_Project"
  }
}
resource "aws_security_group" "sg" {
  tags = {
    type = "terraform-test-security-group"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "sg-095763b3c130900bb"
  network_interface_id = "eni-023ef9e34a6d572c8"
}


resource "github_repository" "terraform_cloud" {
  name        = "AWS_terraform"
  description = "Creating repository using Terrafrom top to create a cloud project"

  visibility = "public"
}
