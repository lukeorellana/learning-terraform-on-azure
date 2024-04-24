# Resource Group
resource "azurerm_resource_group" "main" {
  count = 3
  name     = "rg-MyResourceGroup-${count.index}"
  location = "West US 2"
}