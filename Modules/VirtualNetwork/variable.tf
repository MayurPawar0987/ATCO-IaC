variable "name" {
  type        = string
  description = "Name of the virtual network"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "Custom DNS servers for the VNet"
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
  default     = {}
  description = "Map of subnets to create within the VNet"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
