output "id" {
  value = azurerm_network_security_group.this.id
}

output "name" {
  value = azurerm_network_security_group.this.name
}

output "subnet_association_ids" {
  value = { for k, v in azurerm_subnet_network_security_group_association.this : k => v.id }
}
