terraform {
  backend "s3" {
    bucket = "demo-bucket-891377224694"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
