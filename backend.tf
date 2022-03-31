terraform {
  backend "s3" {
    bucket = "talent-mike-states"
    key    = "Users/michael.roberts/Documents/Cloudreach/Repositories/Labs/training-vpc-lab/new-vpc-project/.terraform/terraform.tfstate"
    # DynamoDB can be used for locking terraform state file to avoid collisions
    dynamodb_table = "terraform-lock"
  }
}