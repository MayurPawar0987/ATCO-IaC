environment = "uat"
location    = "eastus"
project     = "atco"

tags = {
  Environment = "uat"
  Project     = "atco"
  ManagedBy   = "terraform"
}

resource_group_name = "rg-atco-uat"

vnet_address_space = ["10.35.0.0/16"]
subnets = {
  "snet-app"               = { address_prefixes = ["10.35.1.0/24"], delegation = null }
  "snet-data"              = { address_prefixes = ["10.35.2.0/24"], delegation = null }
  "snet-integration" = {
    address_prefixes = ["10.35.3.0/24"]
    delegation = {
      name         = "logicapp-delegation"
      service_name = "Microsoft.Web/serverFarms"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  "AzureFirewallSubnet"    = { address_prefixes = ["10.35.4.0/26"], delegation = null }
  "snet-private-endpoints" = { address_prefixes = ["10.35.5.0/24"], delegation = null }
  "snet-agent"             = { address_prefixes = ["10.35.6.0/24"], delegation = null }
  "snet-databricks-public" = {
    address_prefixes = ["10.35.7.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
  "snet-databricks-private" = {
    address_prefixes = ["10.35.8.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

storage_account_name       = "statcouat001"
key_vault_name             = "kv-atco-uat-001"
data_factory_name          = "adf-atco-uat"
databricks_workspace_name  = "dbw-atco-uat"
databricks_managed_rg_name = "rg-atco-uat-databricks-managed"
sql_server_name            = "sql-atco-uat"
sql_database_name          = "sqldb-atco-uat"
logic_app_name             = "logic-atco-uat"
vm_name                    = "vm-atco-uat-agent"
