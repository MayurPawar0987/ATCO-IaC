output "id" {
  value = azurerm_mssql_server.this.id
}

output "name" {
  value = azurerm_mssql_server.this.name
}

output "fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "database_id" {
  value = azurerm_mssql_database.this.id
}

output "principal_id" {
  value = azurerm_mssql_server.this.identity[0].principal_id
}
