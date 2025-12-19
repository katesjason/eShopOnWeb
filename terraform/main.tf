locals {
  common_tags = var.tags
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-eshoponweb"
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "app" {
  name                 = "snet-app"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.app_subnet_prefix]
}

resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.data_subnet_prefix]
}

resource "azurerm_network_security_group" "app" {
  name                = "nsg-app"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRDP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.allow_rdp_from_cidr
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "data" {
  name                = "nsg-data"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags

  security_rule {
    name                       = "AllowSQLFromApp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = var.app_subnet_prefix
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowRDPFromApp"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = var.app_subnet_prefix
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

resource "azurerm_subnet_network_security_group_association" "data" {
  subnet_id                 = azurerm_subnet.data.id
  network_security_group_id = azurerm_network_security_group.data.id
}

resource "azurerm_marketplace_agreement" "sql" {
  publisher = var.sql_image_publisher
  offer     = var.sql_image_offer
  plan      = var.sql_image_sku
}

module "appvm" {
  source = "./modules/windows_vm"

  vm_name                     = "appvm"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  subnet_id                   = azurerm_subnet.app.id
  vm_size                     = var.appvm_size
  admin_username              = var.admin_username
  admin_password              = var.admin_password
  os_disk_type                = var.os_disk_type
  enable_public_ip            = true
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  tags                        = local.common_tags
}

module "sqlvm" {
  source = "./modules/windows_vm"

  vm_name             = "sqlvm"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.data.id
  vm_size             = var.sqlvm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  os_disk_type        = var.os_disk_type
  enable_public_ip    = false
  image_publisher     = var.sql_image_publisher
  image_offer         = var.sql_image_offer
  image_sku           = var.sql_image_sku
  image_version       = var.sql_image_version
  plan_publisher      = var.sql_image_publisher
  plan_product        = var.sql_image_offer
  plan_name           = var.sql_image_sku
  tags                = local.common_tags

  depends_on = [
    azurerm_marketplace_agreement.sql
  ]
}
