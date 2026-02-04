terraform {
  backend "s3" {
    bucket         = "terraform-states-v-1.0"
    key            = "drift-detection/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}