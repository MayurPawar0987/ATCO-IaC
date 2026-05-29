variable "name" {
  type        = string
  description = "Globally unique storage account name (3-24 chars, lowercase alphanumeric)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage account tier (Standard or Premium)"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Replication type (LRS, GRS, ZRS, etc.)"
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Account kind"
}

variable "versioning_enabled" {
  type    = bool
  default = true
}

variable "delete_retention_days" {
  type    = number
  default = 7
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
