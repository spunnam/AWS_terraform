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

resource "aws_lb" "lb_practice" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["sg-095763b3c130900bb"]
  subnets                    = ["subnet-086a4f95acf0fd771", "subnet-0c5d8cda9bbac7918", "subnet-0ad8498fde7ac062d"]
  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }
}

# Create a target group
resource "aws_lb_target_group" "test_lb_tg" {
  name        = "alb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "vpc-08cf7b837ce92277b"
  target_type = "instance"
}

# Attach the target group to the ALB
resource "aws_lb_listener" "lb_practice" {
  load_balancer_arn = aws_lb.lb_practice.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.example.arn
    type             = "forward"
  }
}
resource "aws_lb_target_group_attachment" "example" {
  count            = 1
  target_group_arn = aws_lb_target_group.test_lb_tg.arn
  target_id        = aws_instance.ec2_instance.id
}


