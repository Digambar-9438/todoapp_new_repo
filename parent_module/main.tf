module "md_resource_group" {
  source              = "../module/azurerm_resourc_group" # fixed spelling of module folder
  resource_group_name = "rg-vivekb123"
  location            = "west us"
}

module "md_stroage_account" {
  depends_on           = [module.md_resource_group]
  source               = "../module/azurerm_stroage_account"
  storage_account_name = "vivekstroageaccount143"
  resource_group_name  = "rg-vivekb123"
  location             = "west us"
}

module "md_virtual_network" {
  depends_on           = [module.md_resource_group]
  source               = "../module/azurerm_virtual_network"
  virtual_network_name = "vivekbaliyanvnet001"
  resource_group_name  = "rg-vivekb123"
  location             = "west us"
  adress_space         = ["10.0.0.0/16"]

}

module "fronted_subnet" {
  depends_on           = [module.md_virtual_network]
  source               = "../module/azurerm_subnet"
  subnet_name          = "vivekfrontedsubnt"
  virtual_network_name = "vivekbaliyanvnet001"
  resource_group_name  = "rg-vivekb123"
  address_prefixes     = ["10.0.1.0/24"]
}

module "backend_subnet" {
  depends_on           = [module.md_virtual_network]
  source               = "../module/azurerm_subnet"
  subnet_name          = "vivekbackendsubnt"
  virtual_network_name = "vivekbaliyanvnet001"
  resource_group_name  = "rg-vivekb123"
  address_prefixes     = ["10.0.2.0/24"]
}


module "md_fronted_public_ip" {
  depends_on          = [module.md_resource_group]
  source              = "../module/azurerm_publick_ip"
  public_ip_name      = "vvpublicipfronted01"
  resource_group_name = "rg-vivekb123"
  location            = "west us"
}

module "md_backend_public_ip" {
  depends_on          = [module.md_resource_group]
  source              = "../module/azurerm_publick_ip"
  public_ip_name      = "vvpublicipbackend02"
  resource_group_name = "rg-vivekb123"
  location            = "west us"
}


module "fronted_vm1" {
  depends_on                 = [module.fronted_subnet, module.md_resource_group, module.md_fronted_public_ip, module.md_virtual_network]
  source                     = "../module/azurerm_virtual_machine"
  linux_virtual_machine_name = "fontedvm003"
  nic_name                   = "frontednicvk"
  resource_group_name        = "rg-vivekb123"
  location                   = "west us"
  public_ip_name             = "vvpublicipfronted01"
  subnet_name                = "vivekfrontedsubnt"
  virtual_network_name       = "vivekbaliyanvnet001"

}



module "backend_vm2" {
  depends_on                 = [module.backend_subnet, module.md_resource_group, module.md_backend_public_ip, module.md_virtual_network]
  source                     = "../module/azurerm_virtual_machine"
  linux_virtual_machine_name = "backenddvm003"
  nic_name                   = "backendnicvk"
  resource_group_name        = "rg-vivekb123"
  location                   = "west us"
  public_ip_name             = "vvpublicipbackend02"
  subnet_name                = "vivekbackendsubnt"
  virtual_network_name       = "vivekbaliyanvnet001"
}


module "md_sql_server" {
  depends_on          = [module.md_resource_group]
  source              = "../module/azurerm_sql_server"
  sqlserver_name      = "vivkesqlserver002"
  resource_group_name = "rg-vivekb123"
  location            = "west us"
}

module "md_mssql_database" {
  depends_on          = [module.md_sql_server, module.md_resource_group]
  source              = "../module/azurerm_sql_database"
  sqldatabase_name    = "devopsvivekdb"
  resource_group_name = "rg-vivekb123"
  sqlserver_name      = "vivkesqlserver002"
}


module "md_azur_key_vault" {
  depends_on=[module.md_resource_group]
  source= "../module/azurerm_key_vault"
  key_vault_name="mycompanyname-az"
   resource_group_name = "rg-vivekb123"
  location            = "west us"
}


module "md_keyvault_scret"{
  depends_on = [ module.md_resource_group,module.md_azur_key_vault ]
  source="../module/azurerm_key_vault_scret"
  resource_group_name="rg-vivekb123"
    key_vault_name="mycompanyname-az"
    key_vault_scret_name ="vm-username"
}

module "md_keyvault_scret_name"{
  depends_on = [ module.md_resource_group,module.md_azur_key_vault ]
  source="../module/azurerm_key_vault_scret"
  resource_group_name="rg-vivekb123"
    key_vault_name="mycompanyname-az"
    key_vault_scret_name ="Path@123456me"
}