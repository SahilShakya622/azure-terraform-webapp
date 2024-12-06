variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "web-app-rg"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "web-app-service-plan"
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default     = "webapp-example"
}

variable "sku" {
  description = "The SKU for the App Service Plan"
  type        = string
  default     = "B1"
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account"
  type        = string
  default     = "webappstorageacct"
}
