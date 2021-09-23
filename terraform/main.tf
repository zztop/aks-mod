terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.73.0"
    }
  }
  // backend "azurerm" {
  //   resource_group_name ="root_rg"
  //   storage_account_name ="tfstatedef"
  //   container_name ="statecontainer"
  //   key = "terraform.tfstate"
  // }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}




module "aks_cluster"{
  source = "./modules/aks"
  resource_group = data.azurerm_resource_group.root_rg
  prefix = "default"
}

module "helm"{
  source = "./modules/helm"
  host = module.aks_cluster.kube_config.host
  client_certificate = "${base64decode(module.aks_cluster.kube_config.client_certificate)}"
  client_key = "${base64decode(module.aks_cluster.kube_config.client_key)}"
  cluster_ca_certificate = "${base64decode(module.aks_cluster.kube_config.cluster_ca_certificate)}"
  namespace = module.aks_cluster.namespace
  module_abspath = "${abspath(path.module)}/modules/helm/SampleWebApi/dotnet3-webapi-chart" 
}

output "world_module_says" {
    value = module.aks_cluster.namespace
}
