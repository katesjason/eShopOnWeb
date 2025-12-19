output "vm_id" {
  description = "Resource ID of the Windows virtual machine."
  value       = azurerm_windows_virtual_machine.this.id
}

output "private_ip_address" {
  description = "Private IP address of the VM."
  value       = azurerm_network_interface.this.ip_configuration[0].private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of the VM (if created)."
  value       = var.enable_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "network_interface_id" {
  description = "Resource ID of the network interface."
  value       = azurerm_network_interface.this.id
}
