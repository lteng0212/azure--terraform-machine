data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_subnet" "internal" {
  name                 = var.private_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

//1.可以批量创建；
//2.无需制定网卡
//3.磁盘参数不能完全设置、不能绑辅助IP
//4.as与vm的name想绑定 
module "ubuntuservers" {
  source                           = "Azure/compute/azurerm"
  resource_group_name              = data.azurerm_resource_group.rg.name
  vm_hostname                      = "${var.prefix}-vm"
  location                         = data.azurerm_resource_group.rg.location
  vm_size                          = var.vm_size
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true
  admin_username                   = "ansible"
  admin_password                   = var.adminpassword
  vnet_subnet_id                   = data.azurerm_subnet.internal.id
  //disk
  storage_account_type = "Standard_LRS"
  storage_os_disk_size_gb = 30
  data_disk_size_gb = 30
  data_sa_type = "Standard_LRS"
  nb_data_disk = 2
  //nb
  nb_instances = 2 
  //image
  vm_os_version = "latest"
  vm_os_sku = "16.04-LTS"
  vm_os_publisher = "Canonical"
  vm_os_offer  = "UbuntuServer"
  //ssh
  enable_ssh_key = false
}