

resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name 
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "admin1234"
  administrator_login_password = "admin@123456"


  # azuread_administrator {
  #   login_username = "AzureAD Admin"
  #   object_id      = "00000000-0000-0000-0000-000000000000"
  # }

  tags = {
    environment = "production"
  }
}