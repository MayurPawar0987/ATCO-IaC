environment = "prod"
location    = "eastus"
project     = "atco"

tags = {
  Environment = "prod"
  Project     = "atco"
  ManagedBy   = "terraform"
}

resource_group_name = "rg-atco-prod"

vnet_address_space = ["10.40.0.0/16"]
subnets = {
  "snet-app"               = { address_prefixes = ["10.40.1.0/24"], delegation = null }
  "snet-data"              = { address_prefixes = ["10.40.2.0/24"], delegation = null }
  "snet-integration" = {
    address_prefixes = ["10.40.3.0/24"]
    delegation = {
      name         = "logicapp-delegation"
      service_name = "Microsoft.Web/serverFarms"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
  "AzureFirewallSubnet"    = { address_prefixes = ["10.40.4.0/26"], delegation = null }
  "snet-private-endpoints" = { address_prefixes = ["10.40.5.0/24"], delegation = null }
  "snet-agent"             = { address_prefixes = ["10.40.6.0/24"], delegation = null }
  "snet-databricks-public" = {
    address_prefixes = ["10.40.7.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
  "snet-databricks-private" = {
    address_prefixes = ["10.40.8.0/24"]
    delegation = {
      name         = "databricks-delegation"
      service_name = "Microsoft.Databricks/workspaces"
      actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

storage_account_name       = "statcoprod001"
key_vault_name             = "kv-atco-prod-001"
data_factory_name          = "adf-atco-prod"
databricks_workspace_name  = "dbw-atco-prod"
databricks_managed_rg_name = "rg-atco-prod-databricks-managed"
sql_server_name            = "sql-atco-prod"
sql_database_name          = "sqldb-atco-prod"
logic_app_name             = "logic-atco-prod"
vm_name                    = "vm-atco-prod-agent"
