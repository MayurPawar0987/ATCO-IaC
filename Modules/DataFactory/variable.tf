variable "name" {
  type        = string
  description = "Name of the Azure Data Factory"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "github_configuration" {
  type = object({
    account_name    = string
    branch_name     = string
    git_url         = string
    repository_name = string
    root_folder     = string
  })
  default     = null
  description = "Optional GitHub integration configuration"
}
