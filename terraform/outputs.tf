output "resource_group_name" {
  description = "Name of the resource group hosting the deployment."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "Resource ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "appvm_public_ip" {
  description = "Public IP assigned to the application VM."
  value       = module.appvm.public_ip_address
}

output "appvm_private_ip" {
  description = "Private IP of the application VM."
  value       = module.appvm.private_ip_address
}

output "sqlvm_private_ip" {
  description = "Private IP of the SQL VM."
  value       = module.sqlvm.private_ip_address
}
