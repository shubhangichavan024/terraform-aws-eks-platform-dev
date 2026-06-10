terraform {
  backend "s3" {
    bucket       = "terraform-eks-state-yogesh"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true # ← replaces dynamodb_table
    encrypt      = true
  }
}

// use_lockfile = true uses S3's native locking (available since Terraform 1.10+). 
// You can now delete the DynamoDB table if you want — it's no longer needed
/* terraform {
  backend "s3" {
    bucket         = "terraform-eks-state-yogesh"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-eks-lock"
    encrypt        = true
  }

}
*/