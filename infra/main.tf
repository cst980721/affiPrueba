provider "azurerm" {
  features {}

  subscription_id = "0000000-0000-00000-000000"
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
