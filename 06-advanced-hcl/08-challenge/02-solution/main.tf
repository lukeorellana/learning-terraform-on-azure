#create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-modchallenge"
  location = "westus2"
}

#Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-modchallenge-${azurerm_resource_group.rg.location}-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "snet-modchallenge-${azurerm_resource_group.rg.location}-001"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}


# Create network security group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-httpsallow-001"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "HTTP-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Module Server
module "server" {
  source = "./modules/terraform-azure-wsserver"
  
  nsg_id = azurerm_network_security_group.nsg.id
  subnet_id = azurerm_subnet.subnet.id
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  servername = "server1"
  vm_size = "Standard_B1s"
  admin_username = "terraadmin"
  admin_password = "P@ssw0rdP@ssw0rd"
  os = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}

output "ip" {
  description = "IP Address of server"
  value = module.server.pip
}