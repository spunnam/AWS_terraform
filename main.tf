# main.tf
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0e731c8a588258d0d"
  subnet_id              = "subnet-0ad8498fde7ac062d"
  instance_type          = "t2.micro"
  key_name               = "EC2 Practice"
  vpc_security_group_ids = ["sg-095763b3c130900bb"]

  user_data = <<-EOF
  #!/bin/bash
  # Use this for your user data (script from top to bottom)
  # install httpd (Linux 2 version)
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  sudo rm /var/www/html/index.html
  aws s3 cp s3://demo-bucket-891377224694/index.html index.html
  sudo mv /home/ec2-user/index.html /var/www/html/
  EOF

  tags = {
    Name = "new_terraform_instance"
  }
}
