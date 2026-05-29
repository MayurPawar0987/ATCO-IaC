variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "virtual_network_id" {
  type        = string
  description = "VNet ID to link private DNS zones to"
}

variable "private_dns_zones" {
  type        = map(any)
  default     = {}
  description = "Map of private DNS zone names to create (keys are zone names, values unused)"
}

variable "tags" {
  type    = map(string)
  default = {}
}
