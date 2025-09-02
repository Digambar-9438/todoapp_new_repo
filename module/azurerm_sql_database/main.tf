
data "azurerm_mssql_server" "sqlserverid" {
  name                = var.sqlserver_name
  resource_group_name = var.resource_group_name
}
resource "azurerm_mssql_database" "sqldb" {
  name         = var.sqldatabase_name
  server_id    = data.azurerm_mssql_server.sqlserverid.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  # lifecycle {
  #   prevent_destroy = true
  # }
}