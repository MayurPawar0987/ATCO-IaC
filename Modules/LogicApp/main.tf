resource "azurerm_service_plan" "this" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_logic_app_standard" "this" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.this.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  virtual_network_subnet_id  = var.vnet_integration_subnet_id
  https_only                 = true
  tags                       = var.tags

  site_config {}

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.app_settings
}
