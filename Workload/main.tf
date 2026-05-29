module "resource_group" {
  source = "../Modules/ResourceGroup"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "virtual_network" {
  source = "../Modules/VirtualNetwork"

  name                = "vnet-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = var.tags
}

module "nsg_databricks" {
  source = "../Modules/NetworkSecurityGroup"

  name                = "nsg-${var.project}-${var.environment}-databricks"
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_ids = {
    "snet-databricks-public"  = module.virtual_network.subnet_ids["snet-databricks-public"]
    "snet-databricks-private" = module.virtual_network.subnet_ids["snet-databricks-private"]
  }
  tags = var.tags
}

module "storage_account" {
  source = "../Modules/StorageAccount"

  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = module.resource_group.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

module "key_vault" {
  source = "../Modules/KeyVault"

  name                = var.key_vault_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "data_factory" {
  source = "../Modules/DataFactory"

  name                = var.data_factory_name
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

module "databricks" {
  source = "../Modules/Databricks"

  name                              = var.databricks_workspace_name
  location                          = var.location
  resource_group_name               = module.resource_group.name
  managed_resource_group_name       = var.databricks_managed_rg_name
  virtual_network_id                = module.virtual_network.id
  private_subnet_name               = "snet-databricks-private"
  public_subnet_name                = "snet-databricks-public"
  private_subnet_nsg_association_id = module.nsg_databricks.subnet_association_ids["snet-databricks-private"]
  public_subnet_nsg_association_id  = module.nsg_databricks.subnet_association_ids["snet-databricks-public"]
  tags                              = var.tags
}

module "sql_server" {
  source = "../Modules/SQLServer"

  name                = var.sql_server_name
  location            = var.location
  resource_group_name = module.resource_group.name
  admin_username      = var.sql_admin_username
  admin_password      = var.sql_admin_password
  database_name       = var.sql_database_name
  tags                = var.tags
}

module "logic_app" {
  source = "../Modules/LogicApp"

  name                       = var.logic_app_name
  location                   = var.location
  resource_group_name        = module.resource_group.name
  storage_account_name       = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key
  vnet_integration_subnet_id = module.virtual_network.subnet_ids["snet-integration"]
  tags                       = var.tags
}

module "virtual_machine" {
  source = "../Modules/VirtualMachine"

  name                = var.vm_name
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_id           = module.virtual_network.subnet_ids["snet-agent"]
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  tags                = var.tags
}

module "private_dns" {
  source = "../Modules/DNS"

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
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.storage_account_name}-blob"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.storage_account.id
  subresource_names              = ["blob"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.blob.core.windows.net"]]
  tags                           = var.tags
}

module "pe_key_vault" {
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.key_vault_name}-vault"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.key_vault.id
  subresource_names              = ["vault"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.vaultcore.azure.net"]]
  tags                           = var.tags
}

module "pe_data_factory" {
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.data_factory_name}-df"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.data_factory.id
  subresource_names              = ["dataFactory"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.datafactory.azure.net"]]
  tags                           = var.tags
}

module "pe_databricks" {
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.databricks_workspace_name}-ui"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.databricks.id
  subresource_names              = ["databricks_ui_api"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.azuredatabricks.net"]]
  tags                           = var.tags
}

module "pe_sql" {
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.sql_server_name}-sql"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.sql_server.id
  subresource_names              = ["sqlServer"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.database.windows.net"]]
  tags                           = var.tags
}

module "pe_logic_app" {
  source = "../Modules/PrivateEndpoint"

  name                           = "pe-${var.logic_app_name}-sites"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  subnet_id                      = module.virtual_network.subnet_ids["snet-private-endpoints"]
  private_connection_resource_id = module.logic_app.id
  subresource_names              = ["sites"]
  private_dns_zone_ids           = [module.private_dns.private_dns_zone_ids["privatelink.azurewebsites.net"]]
  tags                           = var.tags
}
