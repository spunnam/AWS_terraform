# variables.tf

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# variables.tf
variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
  default     = ["subnet-086a4f95acf0fd771", "subnet-0c5d8cda9bbac7918", "subnet-0ad8498fde7ac062d"]
}


