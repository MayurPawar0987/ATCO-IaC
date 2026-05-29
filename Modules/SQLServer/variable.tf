variable "name" {
  type        = string
  description = "Name of the SQL Server (globally unique)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "sql_version" {
  type        = string
  default     = "12.0"
  description = "SQL Server version"
}

variable "admin_username" {
  type        = string
  description = "SQL Server administrator login name"
}

variable "admin_password" {
  type        = string
  sensitive   = true
  description = "SQL Server administrator password"
}

variable "database_name" {
  type        = string
  description = "Name of the SQL database"
}

variable "database_sku" {
  type        = string
  default     = "S1"
  description = "SKU for the SQL database (e.g. Basic, S1, P1, GP_Gen5_2)"
}

variable "max_size_gb" {
  type        = number
  default     = 32
  description = "Maximum database size in GB"
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "Database collation"
}

variable "tags" {
  type    = map(string)
  default = {}
}
