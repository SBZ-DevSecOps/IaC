terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket               = "balboa-devs3"
    region               = "eu-west-3"
    key                  = "k8S-terraform.tfstate"
    workspace_key_prefix = "App/Terraform/state"
    encrypt              = true
    access_key           = "KLDZJHBUYDGSN8BDU59PRE"
    secret_key           = "987MHF/vjt+0bX6EtCwgVBfmP3u9f7RR3OZ7u74r"
  }
  required_version = "~> 1.4.0"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = local.curr_env.env
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = local.curr_env.env
  }
}
