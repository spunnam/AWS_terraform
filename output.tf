# outputs.tf

output "instance_ip" {
  value = aws_instance.ec2_instance.public_ip
}
