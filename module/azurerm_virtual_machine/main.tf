# Creates a Network Security Group (NSG) with rules to control inbound and outbound traffic.
# The NSG can be associated with subnets or network interfaces to enforce security policies.
# This resource allows you to define custom security rules, such as allowing or denying specific ports, protocols, or IP ranges.
# Use this NSG to connect and secure your Azure resources according to your network requirements.

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}




resource "azurerm_network_interface" "nic" {
  name                =var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnetdata.id
    private_ip_address_allocation = "Dynamic"
     public_ip_address_id          = data.azurerm_public_ip.public_id_data.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.linux_virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "devopsadmin"
  admin_password ="admin@123456"
  disable_password_authentication=false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
   
   #### go to azur market fetch all the data 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }


    # Cloud-Init for Installing Nginx
  custom_data = base64encode(<<-EOT
                #cloud-config
                packages:
                  - nginx
                runcmd:
                  - systemctl start nginx
                  - systemctl enable nginx
                EOT
  )
}