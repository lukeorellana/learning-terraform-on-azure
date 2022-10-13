
#Create resource group
resource "azurerm_resource_group" "rg" {
    name     = "rg-myapp"
    location = "westus"
}

resource "random_integer" "rnd" {
  min = 1
  max = 50000
}

#Create Storage Account
module "storage_account1" {
  source    = "./modules/storage-account"

  storage_account_name    = "statfdemosa${random_integer.rnd.result}"
  resource_group_name    = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}


#Create Storage Account
module "storage_account2" {
  source    = "./modules/storage-account"

  storage_account_name    = "statfdemo2sa${random_integer.rnd.result}"
  resource_group_name   = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
}