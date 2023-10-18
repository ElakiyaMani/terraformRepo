terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.4.0"
    }
  
    github = {
      source = "integrations/github"
      version = "~> 5.0"
    }
  }
}


provider "azurerm" {
  client_id       = "05418cb7-90c3-47fe-b645-37e46662f663"
  client_secret   = "_2P8Q~aIGYZgBy9R71_mZKoAw7kqCc.o2aqZkdes"
  tenant_id       = "636edab3-9629-4324-9146-413af28f0456"
  subscription_id = "7ac3d5c6-173f-4292-b20b-01d6fc88e859"
  features {}
}
provider "github" {
   token="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"
}

variable "prefix" {

}

# Create a resource group
resource "azurerm_resource_group" "azure_terraform_resource_group" {
  name     = "${var.prefix}-rsgrp"
  location = "East US"
}


resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azure_terraform_resource_group.location
  resource_group_name = azurerm_resource_group.azure_terraform_resource_group.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.azure_terraform_resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}



