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


# Create network interface
resource "azurerm_network_interface" "nic" {
  name                      = "nic-${var.name}vm1-001"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "niccfg-${var.name}vm1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.name}vm1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]

  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = lookup(var.storage_account_type, var.location, "Standard_LRS")
  }

  source_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

}