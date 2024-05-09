variable "resource_group_name" {
    type = string
    description = "Resource group name under which the datafactory is created"
}

variable "location" {
    type = string
    description = "Location of the data factory to create"
}

variable "link_storage_acc" {
    type = string
    description = "URL of the storage account to establish a linked service"
}

variable "storage_acc_access_key" {
    type= string
    description = "The access key of the storage account to create linked service"
}


variable "link_sql_server" {
    type= string
    description = "The FQDN to the SQL server for link service"
}

variable "link_sql_db" {
    type= string
    description = "The name of the SQL db for link service"
}


variable "link_synapse_sql_server" {
    type= string
    description = "The FQDN to the Synapse"
}

variable "link_synapse_sql_db" {
    type= string
    description = "The name of the SQL db for Synapse SQL pool"
}


variable "sql_db_admin_password" {
    type= string
    description = "The db admin password for authentication in link service"
}

output "datafactory_id" {
  value = azurerm_data_factory.myadf.id 
}


output "linked_service_storage_acc_name" {
  value = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
}


