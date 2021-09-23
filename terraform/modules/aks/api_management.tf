resource "azurerm_api_management" "this" {
  name                = "${var.prefix}-apim"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  publisher_name      = "zztop"
  publisher_email     = "zaryab.ahmad@gmail.com"
  sku_name            = "Developer_1"
}



// resource "azurerm_api_management_api" "this" {
//   name                = "${var.prefix}-product-api"
//   api_management_name = azurerm_api_management.this.name
//   resource_group_name = azurerm_api_management.this.resource_group_name
//   revision            = "2"
// }


resource "azurerm_api_management_product" "this" {
  product_id            = "${var.prefix}-product"
  api_management_name   = azurerm_api_management.this.name
  resource_group_name   = var.resource_group.name
  display_name          = "${var.prefix}-product"
  subscription_required = true
  approval_required     = true
  published             = true
  subscriptions_limit   = 1
}

// resource "azurerm_api_management_product_api" "this" {
//   api_name            = azurerm_api_management_api.this.name
//   product_id          = azurerm_api_management_product.this.product_id
//   api_management_name = azurerm_api_management.this.name
//   resource_group_name = azurerm_api_management.this.resource_group_name
// }

resource "azurerm_api_management_gateway" "this" {
  name              = "${var.prefix}-gateway"
  api_management_id = azurerm_api_management.this.id
  description       = "Example API Management gateway"

  location_data {
    name     =  var.resource_group.location
  }
}