
resource "azurerm_resource_group" "storageappgrp" {
  name     = var.resource_group_name
  location = var.location  
}

resource "azurerm_storage_account" "appstorageaccount" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"

  public_network_access_enabled = true
  shared_access_key_enabled = true
  default_to_oauth_authentication = true 
  is_hns_enabled = true

  depends_on = [ 
    azurerm_resource_group.storageappgrp
  ]

}

resource "azurerm_storage_container" "appcontainer" {

  name                  = "adlsnycpayroll-ak"
  storage_account_name  = azurerm_storage_account.appstorageaccount.name
  container_access_type = "container"
  depends_on = [ 
    azurerm_resource_group.storageappgrp, azurerm_storage_account.appstorageaccount
  ]
}

resource "azurerm_storage_blob" "payrollblob" {
  for_each = fileset(path.root, "data-nyc-payroll/dirpayrollfiles/*")

  name                   = trim(each.key, "data-nyc-payroll")
  storage_account_name   = azurerm_storage_account.appstorageaccount.name
  storage_container_name = azurerm_storage_container.appcontainer.name
  type                   = "Block"
  source                 = each.key
  depends_on = [ 
    azurerm_resource_group.storageappgrp, azurerm_storage_account.appstorageaccount, azurerm_storage_container.appcontainer
  ]
}


resource "azurerm_storage_blob" "historypayrollblob" {
  for_each = fileset(path.root, "data-nyc-payroll/history/*")

  name                   = trim(each.key, "data-nyc-payroll")
  storage_account_name   = azurerm_storage_account.appstorageaccount.name
  storage_container_name = azurerm_storage_container.appcontainer.name
  type                   = "Block"
  source                 = each.key
  depends_on = [ 
    azurerm_resource_group.storageappgrp, azurerm_storage_account.appstorageaccount, azurerm_storage_container.appcontainer
  ]
}


resource "azurerm_storage_blob" "stagingblob" {
  for_each = fileset(path.root, "data-nyc-payroll/dirstaging/*")

  name                   = trim(each.key, "data-nyc-payroll")
  storage_account_name   = azurerm_storage_account.appstorageaccount.name
  storage_container_name = azurerm_storage_container.appcontainer.name
  type                   = "Block"
  source                 = each.key
  depends_on = [ 
    azurerm_resource_group.storageappgrp, azurerm_storage_account.appstorageaccount, azurerm_storage_container.appcontainer
  ]
}


# resource "azurerm_storage_blob" "appblob1" {

#   name                   = "/example/test.txt"
  
#   storage_account_name   = azurerm_storage_account.appstorageaccount.name
#   storage_container_name = azurerm_storage_container.appcontainer.name
#   type                   = "Block"
#   source                 = "test.txt"
#   depends_on = [ 
#     azurerm_resource_group.storageappgrp, azurerm_storage_account.appstorageaccount, azurerm_storage_container.appcontainer
#   ]
# }


# resource "azurerm_storage_data_lake_gen2_filesystem" "appfilesystem" {
#   name               = "appfilesystem"
#   storage_account_id = azurerm_storage_account.appstorageaccount.id
# }

# resource "azurerm_storage_data_lake_gen2_path" "apppath" {
#   path               = "example"
#   filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.appfilesystem.name
#   storage_account_id = azurerm_storage_account.appstorageaccount.id
#   resource           = "directory"
# }






# resource "azurerm_storage_container" "tfcontainerss-" {

#   # Create multiple containers 
#   count = 2 

#   name                  = "tfcontainerss-${count.index}"
#   storage_account_name  = azurerm_storage_account.tfstorageacc8964123.name
#   container_access_type = "blob"
#   depends_on = [ 
#     azurerm_storage_account.tfstorageacc8964123
#   ]
# }