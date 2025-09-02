
data "azurerm_public_ip" "public_id_data" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnetdata" {
  name                 = var.subnet_name 
  virtual_network_name =var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# This data block retrieves information from the specified resource.
# Use this data source to reference existing resources and their attributes
# within your Terraform configuration, enabling dynamic and reusable infrastructure.
# Replace the arguments with appropriate values for your environment.