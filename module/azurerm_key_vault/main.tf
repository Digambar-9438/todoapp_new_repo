

data "azurerm_client_config" "current" {
}
# output "account_id" {
#   value = data.azurerm_client_config.current.client_id
# }

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = ["Get", "Set", "List"]
    # [
    #   "Get",
    # ]

    storage_permissions = [
      "Get",
    ]
  }
}




resource "azurerm_key_vault_secret" "key_vault_username" {
  name         = "secret-sauce"
  value        = "devopsadmin"
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "key_vault_passwoard" {
  name         = "secret-sauce"
  value        = "devopsadmin"
  key_vault_id = azurerm_key_vault.kv.id
}