variable "project" {
  type = string
}

variable "bu" {
  type        = string
  description = "Business unit abbreviation (rm, utl, asc, sbx, cs, ery)"
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "sql_location" {
  type        = string
  description = "Azure region for SQL Server"
}

variable "tags" {
  type = map(string)
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

variable "logic_app_sku" {
  type        = string
  default     = "WS1"
  description = "Logic App Standard SKU: WS1 for dev, WS2 for uat/prod"
}

variable "sql_admin_username" {
  type      = string
  sensitive = true
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}
