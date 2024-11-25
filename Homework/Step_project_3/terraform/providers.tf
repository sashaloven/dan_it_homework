# Define provider

provider "aws" {
  region = "eu-central-1"
}

# Choose S3 bucket from AWS

terraform {
  backend "s3" {
    bucket         = "lovyniuk-step-3"
    key            = "infrastructure.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

