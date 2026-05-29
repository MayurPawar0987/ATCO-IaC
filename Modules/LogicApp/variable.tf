variable "name" {
  type        = string
  description = "Name of the Logic App Standard"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "sku_name" {
  type        = string
  default     = "WS1"
  description = "Workflow Standard SKU (WS1, WS2, WS3)"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name used by the Logic App for internal state"
}

variable "storage_account_access_key" {
  type        = string
  sensitive   = true
  description = "Access key for the Logic App storage account"
}

variable "vnet_integration_subnet_id" {
  type        = string
  description = "Subnet ID for outbound VNet integration. Must have Microsoft.Web/serverFarms delegation."
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application settings for the Logic App"
}

variable "tags" {
  type    = map(string)
  default = {}
}
