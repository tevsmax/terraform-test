variable "project" {
  description = "Short project name used in resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod, ...)."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "eastus"
}

variable "address_space" {
  description = "VNet address space."
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "address_space must contain at least one CIDR block."
  }

  validation {
    condition     = alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "Each entry in address_space must be a valid CIDR block."
  }
}

variable "subnets" {
  description = "Map of subnet name => address prefixes."
  type        = map(list(string))
  default     = {}
}

variable "extra_tags" {
  description = "Additional tags merged onto the default tags."
  type        = map(string)
  default     = {}
}
