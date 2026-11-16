variable "name_prefix" {
  description = "Prefix applied to all resource names (e.g. \"myapp-dev\")."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
}

variable "resource_group_name" {
  description = "Name of an existing resource group to deploy into."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)

  validation {
    condition     = alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "Each entry in address_space must be a valid CIDR block."
  }
}

variable "subnets" {
  description = "Map of subnet name => list of address prefixes."
  type        = map(list(string))
  default     = {}
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}
