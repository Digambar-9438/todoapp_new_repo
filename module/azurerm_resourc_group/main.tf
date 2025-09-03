

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


#as per cr new rg createed
resource "azurerm_resource_group" "rg" {
  name     = "rg-vivek425"
  location = "west europe"
}