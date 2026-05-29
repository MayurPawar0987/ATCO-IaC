resource "azurerm_data_factory" "this" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resource_group_name
  public_network_enabled = false
  tags                   = var.tags

  identity {
    type = "SystemAssigned"
  }

  dynamic "github_configuration" {
    for_each = var.github_configuration != null ? [var.github_configuration] : []
    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }
}
