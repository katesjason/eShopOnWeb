variable "location" {
  description = "Azure region for deployment."
  type        = string
  default     = "centralus"
}

variable "resource_group_name" {
  description = "Resource group name for eShopOnWeb infra."
  type        = string
  default     = "rg-eshoponweb-centralus"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = string
  default     = "10.20.0.0/16"
}

variable "app_subnet_prefix" {
  description = "Address prefix for the application subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "data_subnet_prefix" {
  description = "Address prefix for the data subnet."
  type        = string
  default     = "10.20.2.0/24"
}

variable "allow_rdp_from_cidr" {
  description = "CIDR range allowed to RDP to the application VM."
  type        = string
  default     = "1.2.3.4/32"
}

variable "admin_username" {
  description = "Local administrator username for all VMs."
  type        = string
  default     = "eshopadmin"
}

variable "admin_password" {
  description = "Local administrator password for all VMs."
  type        = string
  sensitive   = true
}

variable "appvm_size" {
  description = "SKU for the application VM."
  type        = string
  default     = "Standard_B2s"
}

variable "sqlvm_size" {
  description = "SKU for the SQL VM."
  type        = string
  default     = "Standard_B2s"
}

variable "os_disk_type" {
  description = "Storage type for VM OS disks."
  type        = string
  default     = "StandardSSD_LRS"
}

variable "sql_image_publisher" {
  description = "Marketplace image publisher for the SQL VM."
  type        = string
  default     = "MicrosoftSQLServer"
}

variable "sql_image_offer" {
  description = "Marketplace image offer for the SQL VM."
  type        = string
  default     = "sql2022-ws2022"
}

# To discover SQL image SKUs run: az vm image list-skus -l centralus -p MicrosoftSQLServer -f sql2022-ws2022 -o table
variable "sql_image_sku" {
  description = "Marketplace image SKU/plan for the SQL VM."
  type        = string
  default     = "sqldev"
}

variable "sql_image_version" {
  description = "Image version for the SQL VM."
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    Project     = "eShopOnWeb"
    Environment = "test"
  }
}
