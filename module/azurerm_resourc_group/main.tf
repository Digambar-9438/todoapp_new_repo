

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}



## as per cr new rg created on ci
resource "azurerm_resource_group" "rg" {
  name     = "nayak-rg"
  location = "centeralindia"
}