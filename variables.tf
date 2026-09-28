variable "static_web_app_subscription_id" { type = string }
variable "network_subscription_id"        { type = string }

variable "static_web_app_resource_group_name" { type = string }
variable "static_web_app_name"                { type = string }
variable "location"                           { type = string }

variable "sku_tier" {
  type    = string
  default = "Standard"
  validation {
    condition     = var.sku_tier == "Standard"
    error_message = "Private Endpoint requiere Static Web Apps Standard."
  }
}

variable "sku_size" {
  type    = string
  default = "Standard"
}

variable "network_resource_group_name"  { type = string }
variable "vnet_name"                    { type = string }
variable "private_endpoint_subnet_name" { type = string }

variable "private_endpoint_name" { type = string }
variable "private_service_connection_name" {
  type    = string
  default = "psc-static-web-app"
}

variable "create_private_dns_zone" {
  type    = bool
  default = true
}

variable "private_dns_zone_resource_group_name" { type = string }

variable "create_private_dns_vnet_link" {
  type    = bool
  default = true
}

variable "private_dns_vnet_link_name" {
  type    = string
  default = "link-static-web-app"
}

variable "private_dns_zone_group_name" {
  type    = string
  default = "default"
}

variable "tags" {
  type    = map(string)
  default = {}
}
