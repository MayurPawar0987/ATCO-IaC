variable "name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "OS type (Linux or Windows)"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "VM size / SKU"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the VM NIC"
}

variable "admin_username" {
  type        = string
  default     = "azureuser"
  description = "Admin username"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Admin password for the VM"
}

variable "os_disk_type" {
  type        = string
  default     = "Premium_LRS"
  description = "OS disk storage type"
}

variable "image_publisher" {
  type        = string
  default     = "Canonical"
  description = "Image publisher"
}

variable "image_offer" {
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
  description = "Image offer"
}

variable "image_sku" {
  type        = string
  default     = "22_04-lts-gen2"
  description = "Image SKU"
}

variable "tags" {
  type    = map(string)
  default = {}
}
