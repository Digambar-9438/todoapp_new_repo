
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       =   var.adress_space         ##["10.0.0.0/16"]
## dns_servers         = ["10.0.0.4", "10.0.0.5"]

 

  tags = {
    environment = "Production"
  }
}