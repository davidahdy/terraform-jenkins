terraform {
  backend "s3" {
    bucket       = "hello-app-s3-jenkins"
    key          = "eks/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
   # use_lockfile = true
  }
}

