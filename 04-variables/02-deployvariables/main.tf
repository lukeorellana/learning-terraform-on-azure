#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name}"
  location = var.location
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name}-${azurerm_resource_group.rg.location}-001"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-${var.name}-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet_address_space
}