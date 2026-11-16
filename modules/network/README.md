# network module

Creates a virtual network and zero or more subnets in an existing resource group.

## Usage

```hcl
module "network" {
  source = "../../modules/network"

  name_prefix         = "myapp-dev"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  subnets = {
    app  = ["10.0.1.0/24"]
    data = ["10.0.2.0/24"]
  }
}
```

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `name_prefix` | `string` | yes | Prefix for resource names |
| `location` | `string` | yes | Azure region |
| `resource_group_name` | `string` | yes | Existing resource group |
| `address_space` | `list(string)` | yes | VNet CIDR blocks |
| `subnets` | `map(list(string))` | no | Subnet name => prefixes |
| `tags` | `map(string)` | no | Resource tags |

## Outputs

| Name | Description |
|------|-------------|
| `vnet_id` | VNet ID |
| `vnet_name` | VNet name |
| `subnet_ids` | Map of subnet name => ID |
