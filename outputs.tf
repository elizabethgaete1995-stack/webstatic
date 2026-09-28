output "static_web_app_id" {
  value = azurerm_static_web_app.this.id
}

output "default_host_name" {
  value = azurerm_static_web_app.this.default_host_name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.swa.id
}

output "private_endpoint_custom_dns_configs" {
  value = azurerm_private_endpoint.swa.custom_dns_configs
}

output "private_dns_zone_name" {
  value = local.private_dns_zone_name
}

output "private_dns_zone_id" {
  value = local.private_dns_zone_id
}
