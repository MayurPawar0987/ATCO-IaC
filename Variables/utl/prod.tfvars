project     = "atco"
bu          = "utl"
environment = "prod"
location    = "canadacentral"
sql_location = "canadacentral"

tags = {
  Environment  = "prod"
  BusinessUnit = "utl"
  Project      = "atco"
  ManagedBy    = "terraform"
}

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

logic_app_sku = "WS2"
