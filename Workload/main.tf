locals {
  prefix       = "${var.project}-${var.bu}-${var.environment}"
  short_prefix = "${var.project}${var.bu}${var.environment}"
}

module "resource_group" {
  source   = "../Modules/ResourceGroup"
  name     = "rg-${local.prefix}"
  location = var.location
  tags     = var.tags
}

module "virtual_network" {
  source              = "../Modules/VirtualNetwork"
  name                = "vnet-${local.prefix}"
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = var.tags
}

module "nsg_databricks" {
  source              = "../Modules/NetworkSecurityGroup"
  name                = "nsg-${local.prefix}-databricks"
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_ids = {
    "snet-databricks-public"  = module.virtual_network.subnet_ids["snet-databricks-public"]
    "snet-databricks-private" = module.virtual_network.subnet_ids["snet-databricks-private"]
  }
  tags = var.tags
}

module "storage_account" {
  source                   = "../Modules/StorageAccount"
  name                     = "s${local.short_prefix}001"
  location                 = var.location
  resource_group_name      = module.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

module "storage_account_logic_app" {
  source                   = "../Modules/StorageAccount"
  name                     = "s${local.short_prefix}la001"
  location                 = var.location
  resource_group_name      = module.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_default_action   = "Allow"
  tags                     = var.tags
}

module "key_vault" {
  source              = "../Modules/KeyVault"
  name                = "kv-${local.prefix}-001"
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "data_factory" {
  source              = "../Modules/DataFactory"
  name                = "adf-${local.prefix}"
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "databricks" {
  source                            = "../Modules/Databricks"
  name                              = "dbw-${local.prefix}"
  location                          = var.location
  resource_group_name               = module.resource_group.name
  managed_resource_group_name       = "rg-${local.prefix}-dbr"
  virtual_network_id                = module.virtual_network.id
  private_subnet_name               = "snet-databricks-private"
  public_subnet_name                = "snet-databricks-public"
  private_subnet_nsg_association_id = module.nsg_databricks.subnet_association_ids["snet-databricks-private"]
  public_subnet_nsg_association_id  = module.nsg_databricks.subnet_association_ids["snet-databricks-public"]
  tags                              = var.tags
}

module "sql_server" {
  source              = "../Modules/SQLServer"
  name                = "sql-${local.prefix}"
  location            = var.sql_location
  resource_group_name = module.resource_group.name
  admin_username      = var.sql_admin_username
  admin_password      = var.sql_admin_password
  database_name       = "sqldb-${local.prefix}"
  tags                = var.tags
}

module "logic_app" {
  source                     = "../Modules/LogicApp"
  name                       = "logic-${local.prefix}"
  location                   = var.location
  resource_group_name        = module.resource_group.name
  storage_account_name       = module.storage_account_logic_app.name
  storage_account_access_key = module.storage_account_logic_app.primary_access_key
  vnet_integration_subnet_id = module.virtual_network.subnet_ids["snet-integration"]
  sku_name                   = var.logic_app_sku
  tags                       = var.tags
}

module "private_dns" {
  source              = "../Modules/DNS"
  resource_group_name = module.resource_group.name
  virtual_network_id  = module.virtual_network.id
  private_dns_zones = {
    "privatelink.blob.core.windows.net" = {}
    "privatelink.vaultcore.azure.net"   = {}
    "privatelink.datafactory.azure.net" = {}
    "privatelink.azuredatabricks.net"   = {}
    "privatelink.database.windows.net"  = {}
    "privatelink.azurewebsites.net"     = {}
  }
  tags = var.tags
}

module "pe_storage" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-storage"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.storage_account.id
  subresource_names              = ["blob"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.blob.core.windows.net"]]
  tags                           = var.tags
}

module "pe_key_vault" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-kv"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.key_vault.id
  subresource_names              = ["vault"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.vaultcore.azure.net"]]
  tags                           = var.tags
}

module "pe_data_factory" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-adf"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.data_factory.id
  subresource_names              = ["dataFactory"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.datafactory.azure.net"]]
  tags                           = var.tags
}

module "pe_databricks" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-dbw"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.databricks.id
  subresource_names              = ["databricks_ui_api"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.azuredatabricks.net"]]
  tags                           = var.tags
}

module "pe_sql" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-sql"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.sql_server.id
  subresource_names              = ["sqlServer"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.database.windows.net"]]
  tags                           = var.tags
}

module "pe_logic_app" {
  source                         = "../Modules/PrivateEndpoint"
  name                           = "pe-${local.prefix}-logic"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.logic_app.id
  subresource_names              = ["sites"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.azurewebsites.net"]]
  tags                           = var.tags
}
