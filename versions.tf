terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      source = "hashicorp/random"
    }
    rke = {
      source = "rancher/rke"
      version = "1.0.1"
    }
  }
  required_version = ">= 0.13"
}
