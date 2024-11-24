terraform {
#   backend "s3" {
#     bucket = "terraform-infra-natalija"
#     key = "postgre-aurora/terraform.tfstate"
#     region = "eu-west-1"
#   }
  backend "remote" {
    organization = "puzanskaja"

    workspaces {
      name = "aws-rds-aurora-github-actions"
    }
  }
}
