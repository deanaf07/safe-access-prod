terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.9.0"
    }
  }



   backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstatey44q1"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  # Configuration options
  features {}
}