
data "azurerm_public_ip" "public_id_data" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnetdata" {
  name                 = var.subnet_name 
  virtual_network_name =var.virtual_network_name
  resource_group_name  = var.resource_group_name
}