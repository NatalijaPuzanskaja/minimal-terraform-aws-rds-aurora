terraform {
  backend "s3" {
    bucket = "terraform-infra"
    key = "postgre-aurora/terraform.tfstate"
    region = "eu-west-1"
  }
}
