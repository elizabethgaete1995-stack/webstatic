# Azure Static Web Apps + Private Endpoint

Este Terraform crea:
- Azure Static Web Apps Standard
- Private Endpoint
- Private DNS Zone (opcional)
- Private DNS Zone Group
- Virtual Network Link (opcional)

La VNet y subnet se consideran existentes.

## Suscripciones

Se usan dos providers:
- azurerm.app: Static Web App
- azurerm.network: red, Private Endpoint y Private DNS

Si aplicación y red están en la misma suscripción, usa el mismo Subscription ID.

## Importante

Private Endpoint para Azure Static Web Apps requiere plan Standard.

El subresource usado es:
staticSites

La Private DNS Zone se calcula desde el default_host_name para soportar tanto:
- privatelink.azurestaticapps.net
- privatelink.<partitionId>.azurestaticapps.net

Si la Private DNS Zone corporativa ya existe:
create_private_dns_zone = false

Si ya está vinculada a la VNet:
create_private_dns_vnet_link = false

## Ejecución

terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
