terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.94.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "aks_sp_client_id" {
  description = "Client ID of the Azure service principal for AKS"
}

variable "aks_sp_client_secret" {
  description = "Client Secret of the Azure service principal for AKS"
}

# Create a resource group
resource "azurerm_resource_group" "demo_rg" {
  name     = "demo-rg"
  location = "West Europe"
}

# Create container registry
resource "azurerm_container_registry" "demo_acr" {
  name                = "demoacr41235"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "demo_aks" {
  name                = "demo-aks"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  dns_prefix          = "demo-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  tags = {
    environment = "demo"
  }

  service_principal {
    client_id     = var.aks_sp_client_id
    client_secret = var.aks_sp_client_secret
  }
}

