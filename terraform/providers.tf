terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
  key = "vms.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
  }
}

provider "azurerm" {
  features {}
}
