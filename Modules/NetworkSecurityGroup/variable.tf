variable "name" {
  type        = string
  description = "Name of the Network Security Group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default     = []
  description = "List of security rules to apply"
}

variable "subnet_ids" {
  type        = map(string)
  default     = {}
  description = "Map of static name => subnet ID. Static keys allow Terraform to resolve for_each at plan time."
}

variable "tags" {
  type        = map(string)
  default     = {}
}
