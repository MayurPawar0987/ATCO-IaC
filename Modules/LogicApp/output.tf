output "id" {
  value = azurerm_logic_app_standard.this.id
}

output "name" {
  value = azurerm_logic_app_standard.this.name
}

output "principal_id" {
  value = azurerm_logic_app_standard.this.identity[0].principal_id
}

output "default_hostname" {
  value = azurerm_logic_app_standard.this.default_hostname
}
