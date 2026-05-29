variable "environment" {}

variable "location" {
  type = string
}

variable "project" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "resource_group_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    delegation = optional(object({
      name         = string
      service_name = string
      actions      = list(string)
    }))
  }))
}

variable "storage_account_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "data_factory_name" {
  type = string
}

variable "databricks_workspace_name" {
  type = string
}

variable "databricks_managed_rg_name" {
  type = string
}

variable "sql_location" {
  type        = string
  description = "Azure region for SQL Server (use a region where SQL is available in your subscription)"
}

variable "sql_server_name" {
  type = string
}

variable "sql_database_name" {
  type = string
}

variable "logic_app_storage_account_name" {
  type        = string
  description = "Storage account name used exclusively by Logic App Standard (network open to allow platform provisioning)"
}

variable "logic_app_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_admin_username" {
  type      = string
  sensitive = true
}

variable "vm_admin_password" {
  type      = string
  sensitive = true
}

variable "sql_admin_username" {
  type      = string
  sensitive = true
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}
