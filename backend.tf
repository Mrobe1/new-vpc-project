terraform {
  backend "s3" {
    bucket = "talent-mike-states"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}