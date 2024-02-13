# main.tf
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-0e731c8a588258d0d"
  subnet_id              = "subnet-0ad8498fde7ac062d"
  instance_type          = "t2.micro"
  iam_instance_profile   = "DemoRoleForEC2"
  key_name               = "EC2 Practice"
  vpc_security_group_ids = ["sg-095763b3c130900bb"]

  user_data = <<-EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    
    # Install AWS CLI
    yum install -y aws-cli
    
    # Download the file from S3 bucket
    aws s3 cp s3://demo-bucket-891377224694/index.html /home/ec2-user/index.html
    
    # Install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    
    # Start and enable httpd service
    systemctl start httpd
    systemctl enable httpd
    
    # Remove the default index.html
    rm /var/www/html/index.html
    
    # Move the downloaded index file to the web server directory
    mv /home/ec2-user/index.html /var/www/html/
    
    # Restart httpd for changes to take effect
    systemctl restart httpd
  EOF


  tags = {
    Name = "new_terraform_instance"
  }
}
