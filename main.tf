# Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan (Updated with reserved=true for Linux App Service)
resource "azurerm_app_service_plan" "example" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"  # Ensure you are deploying to Linux
  reserved            = true     # This is required for Linux-based apps

  sku {
    tier = "Basic"
    size = var.sku
  }
}

# Random ID to generate a unique suffix for web app
resource "random_id" "web_app_suffix" {
  byte_length = 4  # Adjust the length if needed
}

# Web App (App Service)
resource "azurerm_app_service" "example" {
  name                = "${var.web_app_name}-${random_id.web_app_suffix.hex}"  # Append unique suffix
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "16"  # Update to your preferred version
  }

  tags = {
    environment = "production"
  }
}

# Storage Account (Unique Name with Random String)
resource "azurerm_storage_account" "example" {
  name                     = "${var.storage_account_name}${substr(md5(random_id.example.hex), 0, 6)}" # Add a unique suffix
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
}

# Random ID to create a unique suffix for storage account
resource "random_id" "example" {
  byte_length = 8
}

# Output: URL of the deployed Web App
output "app_service_url" {
  description = "The URL of the deployed web app"
  value       = azurerm_app_service.example.default_site_hostname
}
