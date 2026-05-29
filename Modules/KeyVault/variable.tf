variable "name" {
  type        = string
  description = "Globally unique Key Vault name (3-24 chars)"
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
  default     = "standard"
  description = "SKU name (standard or premium)"
}

variable "soft_delete_retention_days" {
  type        = number
  default     = 90
  description = "Retention days for soft-deleted objects (7-90)"
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Enable purge protection"
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "Use RBAC instead of access policies"
}

variable "network_default_action" {
  type        = string
  default     = "Deny"
  description = "Default network action (Allow or Deny)"
}

variable "allowed_ip_rules" {
  type    = list(string)
  default = []
}

variable "allowed_subnet_ids" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
