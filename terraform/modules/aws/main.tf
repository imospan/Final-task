terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.46.0"
    }
  }
}

# Configure AWS provider. 
provider "aws" {
  region = "us-east-1"
  #Use keys as environment variables or uncomment and enter your own.
  #access_key = YOUR-ACCESS-KEY
  #secret_key = YOUR-SECRET-KEY
}
