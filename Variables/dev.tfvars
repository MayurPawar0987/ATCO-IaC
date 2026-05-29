environment = "dev"
location    = "eastus"
project     = "atco"

tags = {
  Environment = "dev"
  Project     = "atco"
  ManagedBy   = "terraform"
}

resource_group_name = "rg-atco-dev"

vnet_address_space = ["10.30.0.0/16"]
subnets = {
  "snet-app"               = { address_prefixes = ["10.30.1.0/24"], delegation = null }
  "snet-data"              = { address_prefixes = ["10.30.2.0/24"], delegation = null }
  "snet-integration" = {
    address_prefixes = ["10.30.3.0/24"]
    delegation = {
      name         = "logicapp-delegation"
      service_name = "Microsoft.Web/serverFarms"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  "AzureFirewallSubnet"    = { address_prefixes = ["10.30.4.0/26"], delegation = null }
  "snet-private-endpoints" = { address_prefixes = ["10.30.5.0/24"], delegation = null }
  "snet-agent"             = { address_prefixes = ["10.30.6.0/24"], delegation = null }
  "snet-databricks-public" = {
    address_prefixes = ["10.30.7.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
  "snet-databricks-private" = {
    address_prefixes = ["10.30.8.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

storage_account_name            = "statcodev001"
logic_app_storage_account_name  = "statcodevlogic001"
sql_location                    = "westus2"
key_vault_name             = "kv-atco-dev-001"
data_factory_name          = "adf-atco-dev"
databricks_workspace_name  = "dbw-atco-dev"
databricks_managed_rg_name = "rg-atco-dev-databricks-managed"
sql_server_name            = "sql-atco-dev"
sql_database_name          = "sqldb-atco-dev"
logic_app_name             = "logic-atco-dev"
vm_name                    = "vm-atco-dev-agent"
