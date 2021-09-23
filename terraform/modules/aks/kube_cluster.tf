resource "azurerm_kubernetes_cluster" "this" {
    name = "${var.prefix}-k8s"
    location = var.resource_group.location
    resource_group_name = var.resource_group.name
    dns_prefix = "${var.prefix}-k8s"
    default_node_pool {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_DS2_v2"
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Environment = "dev"
    }
    network_profile {
        network_plugin = "azure"
        load_balancer_sku = "standard"
    }
    role_based_access_control{
        enabled = true
    }


    addon_profile {
        aci_connector_linux {
        enabled = false
        }

        azure_policy {
        enabled = false
        }

        http_application_routing {
        enabled = false
        }

        // kube_dashboard {
        // enabled = true
        // }

        oms_agent {
        enabled = false
        }
    }
}

data "azurerm_kubernetes_cluster" "this" {
  name                = azurerm_kubernetes_cluster.this.name
  resource_group_name = var.resource_group.name
}



provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.this.kube_config.0.host
  client_certificate     = "${base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_namespace" "this" {
  metadata {
      labels = {
          mylabel = "${var.prefix}-lbl"
      }
    annotations = {
      name = "${var.prefix}"
    }
    name = "${var.prefix}-ns"
  }
}

output "kube_config" {
    // sensitive = true
    value = data.azurerm_kubernetes_cluster.this.kube_config.0
}

output "kube_config_raw" {
    value = data.azurerm_kubernetes_cluster.this.kube_config_raw

    sensitive = true
}

output "namespace"{
    value =  kubernetes_namespace.this.metadata[0].name
}
