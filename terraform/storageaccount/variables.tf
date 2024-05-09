variable "storage_account_name" {
    type = string
    description = "Storage account name to create"
}

variable "location" {
    type = string
    description = "Location of the storage account to create"
}

variable "resource_group_name" {
    type = string
    description = "Resource group name under which the storage account is created"
}


output "storage_account_name_primary_access_key" {
  value = azurerm_storage_account.appstorageaccount.primary_access_key 
}


output "storage_account_name_primary_dfs_url" {
  value = azurerm_storage_account.appstorageaccount.primary_dfs_endpoint 
}
 