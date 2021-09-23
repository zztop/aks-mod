// resource "azurerm_network_security_group" "default_network_sg" {
//   name                = "default_network_sg"
//   location            = azurerm_resource_group.root_rg.location
//   resource_group_name = azurerm_resource_group.root_rg.name

//    tags = {
//     environment = "dev"
//   }
// }


// resource "azurerm_virtual_network" "default_vn" {
//   name                = "virtualNetwork1"
//   location            = azurerm_resource_group.root_rg.location
//   resource_group_name = azurerm_resource_group.root_rg.name
//   address_space       = ["10.0.0.0/24"]


//   subnet {
//     name           = "default_subnet"
//     address_prefix = "10.0.0.0/25"
//     security_group = azurerm_network_security_group.default_network_sg.id
//   }

//   // subnet {
//   //   name           = "subnet2"
//   //   address_prefix = "10.0.2.0/24"
//   // }

//   // subnet {
//   //   name           = "subnet3"
//   //   address_prefix = "10.0.3.0/24"
//   //   security_group = azurerm_network_security_group.example.id
//   // }

//   tags = {
//     environment = "dev"
//   }
// }

// data "azurerm_subnet" "default_subnet" {
//   name                 = "default_subnet"
//   virtual_network_name = azurerm_virtual_network.default_vn.name
//   resource_group_name  = "root_rg"
// }

// resource "azurerm_subnet" "subnet_a" {
//   name                 = "subnet_a"
//   resource_group_name  = azurerm_resource_group.root_rg.name
//   virtual_network_name = azurerm_virtual_network.default_vn.name
//   address_prefixes     = ["10.0.0.128/25"]


// }

// resource "azurerm_subnet_network_security_group_association" "default_nsg_default" {
//   subnet_id                 = data.azurerm_subnet.default_subnet.id
//   network_security_group_id = azurerm_network_security_group.default_network_sg.id
// }

// resource "azurerm_subnet_network_security_group_association" "default_nsg_subnet_a" {
//   subnet_id                 = azurerm_subnet.subnet_a.id
//   network_security_group_id = azurerm_network_security_group.default_network_sg.id
// }