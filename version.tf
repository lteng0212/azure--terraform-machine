# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraformadmin"
    storage_account_name = "lterraformstorage"
    container_name       = "terraform-state"
  }

  required_version = ">= 1.1.0"
}