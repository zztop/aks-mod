resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}rootregistry"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = "Basic"
  admin_enabled       = true

}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}