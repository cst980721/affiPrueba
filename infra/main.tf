provider "azurerm" {
  features {}

  subscription_id = "2bbf1606-4da9-4ebc-9773-12e35090d33b"
  tenant_id       = "ed45dde7-c1d0-4546-a6d0-d29758f3bd7b"
  client_id       = "c7ea3e7e-e400-4833-8a46-82954f4c4764"
  client_secret   = "7WK8Q~lseNeIpOh9rYLB3vNOQGBf6n_IYH129aVk"
}

resource "azurerm_resource_group" "rg" {
  name     = "AffiGrupoDeRecursos"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "mistorageaccount123"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "mi-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "index_html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = "index.html"
}
