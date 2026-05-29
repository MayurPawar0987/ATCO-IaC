variable "name" {
  type        = string
  description = "Name of the Databricks workspace"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "sku" {
  type        = string
  default     = "premium"
  description = "SKU of the Databricks workspace (trial, standard, premium)"
}

variable "managed_resource_group_name" {
  type        = string
  description = "Name for the managed resource group created by Databricks"
}

variable "no_public_ip" {
  type        = bool
  default     = true
  description = "Disable public IP for cluster nodes"
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID for VNet injection"
}

variable "private_subnet_name" {
  type        = string
  description = "Private subnet name for Databricks"
}

variable "public_subnet_name" {
  type        = string
  description = "Public subnet name for Databricks"
}

variable "private_subnet_nsg_association_id" {
  type        = string
  description = "NSG association ID for the private subnet"
}

variable "public_subnet_nsg_association_id" {
  type        = string
  description = "NSG association ID for the public subnet"
}

variable "tags" {
  type    = map(string)
  default = {}
}
