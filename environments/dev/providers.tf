# Authentication comes from the environment (az login, or ARM_* env vars).
# Set ARM_SUBSCRIPTION_ID rather than hard-coding the subscription here.
provider "azurerm" {
  features {}
}
