data "azurerm_resource_group" "app" {
  provider = azurerm.app
  name     = var.static_web_app_resource_group_name
}

data "azurerm_resource_group" "network" {
  provider = azurerm.network
  name     = var.network_resource_group_name
}

data "azurerm_virtual_network" "pe" {
  provider            = azurerm.network
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
}

data "azurerm_subnet" "pe" {
  provider             = azurerm.network
  name                 = var.private_endpoint_subnet_name
  virtual_network_name = data.azurerm_virtual_network.pe.name
  resource_group_name  = data.azurerm_resource_group.network.name
}

resource "azurerm_static_web_app" "this" {
  provider = azurerm.app

  name                = var.static_web_app_name
  resource_group_name = data.azurerm_resource_group.app.name
  location            = var.location

  sku_tier = var.sku_tier
  sku_size = var.sku_size

  tags = var.tags
}

locals {
  hostname_parts = split(".", azurerm_static_web_app.this.default_host_name)
  dns_suffix = join(
    ".",
    slice(local.hostname_parts, 1, length(local.hostname_parts))
  )
  private_dns_zone_name = "privatelink.${local.dns_suffix}"
}

resource "azurerm_private_dns_zone" "swa" {
  provider = azurerm.network
  count    = var.create_private_dns_zone ? 1 : 0

  name                = local.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
  tags                = var.tags
}

data "azurerm_private_dns_zone" "swa" {
  provider = azurerm.network
  count    = var.create_private_dns_zone ? 0 : 1

  name                = local.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
}

locals {
  private_dns_zone_id = var.create_private_dns_zone ? azurerm_private_dns_zone.swa[0].id : data.azurerm_private_dns_zone.swa[0].id
}

resource "azurerm_private_dns_zone_virtual_network_link" "swa" {
  provider = azurerm.network
  count    = var.create_private_dns_vnet_link ? 1 : 0

  name                  = var.private_dns_vnet_link_name
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = local.private_dns_zone_name
  virtual_network_id    = data.azurerm_virtual_network.pe.id
  registration_enabled  = false
  tags                  = var.tags

  depends_on = [azurerm_private_dns_zone.swa]
}

resource "azurerm_private_endpoint" "swa" {
  provider = azurerm.network

  name                = var.private_endpoint_name
  location            = data.azurerm_virtual_network.pe.location
  resource_group_name = data.azurerm_resource_group.network.name
  subnet_id           = data.azurerm_subnet.pe.id

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_static_web_app.this.id
    subresource_names              = ["staticSites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = var.private_dns_zone_group_name
    private_dns_zone_ids = [local.private_dns_zone_id]
  }

  tags = var.tags

  depends_on = [
    azurerm_static_web_app.this,
    azurerm_private_dns_zone_virtual_network_link.swa
  ]
}
