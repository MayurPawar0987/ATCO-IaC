variable "name" {
  type        = string
  description = "Name of the private endpoint"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the private endpoint will be deployed"
}

variable "private_connection_resource_id" {
  type        = string
  description = "Resource ID of the target service"
}

variable "subresource_names" {
  type        = list(string)
  description = "Subresource names (e.g. [\"blob\"], [\"vault\"], [\"sqlServer\"])"
}

variable "private_dns_zone_ids" {
  type        = list(string)
  default     = []
  description = "Private DNS zone IDs to associate with this endpoint"
}

variable "tags" {
  type    = map(string)
  default = {}
}
