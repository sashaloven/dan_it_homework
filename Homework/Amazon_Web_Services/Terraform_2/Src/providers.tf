provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-danit-devops5"
    key            = "task_2_lovyniuk/nginx.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}
