
variable "resource_group_name"{}
variable "key_vault_name"{}
variable "key_vault_scret_name" {}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}



resource "azurerm_key_vault_secret" "key_vault_username" {
  name         = var.key_vault_scret_name 
  value        = "devopsadmin"
  key_vault_id = data.azurerm_key_vault.kv.id
}

# resource "azurerm_key_vault_secret" "key_vault_passwoard" {
#   name         = var.key_vault_scret_name 
#   value        = "devopsadmin"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }