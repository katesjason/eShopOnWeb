variable "vm_name" {
  description = "Name of the virtual machine and related resources."
  type        = string
}

variable "location" {
  description = "Azure region for the VM."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to create the VM."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the VM network interface."
  type        = string
}

variable "vm_size" {
  description = "Size of the VM instance."
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the VM."
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the VM."
  type        = string
  sensitive   = true
}

variable "os_disk_type" {
  description = "Storage type for the OS disk."
  type        = string
}

variable "image_publisher" {
  description = "Image publisher for the VM."
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "Image offer for the VM."
  type        = string
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "Image SKU for the VM."
  type        = string
  default     = "2022-datacenter"
}

variable "image_version" {
  description = "Image version for the VM."
  type        = string
  default     = "latest"
}

variable "enable_public_ip" {
  description = "Whether to provision a public IP for the VM."
  type        = bool
  default     = false
}

variable "public_ip_allocation_method" {
  description = "Public IP allocation method."
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "SKU for the public IP resource."
  type        = string
  default     = "Standard"
}

variable "computer_name" {
  description = "Optional computer name for the VM; defaults to vm_name when null."
  type        = string
  default     = null
}

variable "plan_publisher" {
  description = "Optional plan publisher for marketplace images."
  type        = string
  default     = null
}

variable "plan_product" {
  description = "Optional plan product/offer for marketplace images."
  type        = string
  default     = null
}

variable "plan_name" {
  description = "Optional plan name/SKU for marketplace images."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to associate with module resources."
  type        = map(string)
  default     = {}
}
