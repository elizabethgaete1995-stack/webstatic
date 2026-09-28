# Suscripción distinta a la del APIM
static_web_app_subscription_id = "Contact-Center-Prod"

# Si la VNet está en la misma suscripción que la Static Web App,
# usa aquí el mismo Subscription ID.
network_subscription_id = "Contact-Center-Prod"

# Static Web App
static_web_app_resource_group_name = "rg-contactcenter-prod-eastus-01"
static_web_app_name                = "stapp-contactcenter-prod-eastus-01"
location                           = "eastus"

sku_tier = "Standard"
sku_size = "Standard"

# VNet/Subnet existentes para el Private Endpoint
network_resource_group_name  = "rg-network-contactcenter-prod-eastus-01"
vnet_name                    = "vnet-contactcenter-prod-eastus-01"
private_endpoint_subnet_name = "snet-prod-eastus-003"

# Private Endpoint
private_endpoint_name           = "pe-stapp-contactcenter-prod-eus-01-nic"
private_service_connection_name = "psc-stapp-contactcenter-prod-eus-01"

# Private DNS
# La zona se calcula automáticamente como:
# privatelink.azurestaticapps.net
# o privatelink.<partitionId>.azurestaticapps.net
create_private_dns_zone              = true
private_dns_zone_resource_group_name = "rg-contactcenter-prod-eastus-01"

# Si la zona ya está vinculada a la VNet, cambia a false.
create_private_dns_vnet_link = true
private_dns_vnet_link_name   = "link-stapp-contactcenter-prod-eastus-01"

private_dns_zone_group_name = "default"

tags = {
  BusinessUnit = "Management"
  Workgroup     = "Sistemas"
  CostCenter    = "IT"
  Environment   = "PROD"
}
