output "resource_group_name" {
  description = "Name of the environment resource group."
  value       = azurerm_resource_group.main.name
}

output "vnet_id" {
  description = "ID of the environment virtual network."
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet name => subnet ID."
  value       = module.network.subnet_ids
}
