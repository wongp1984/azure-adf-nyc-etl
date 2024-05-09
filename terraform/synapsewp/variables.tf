variable "resource_group_name" {
    type = string
    description = "Resource group name under which the Synapse workspace is created"
}


variable "sql_database_name" {
    type = string
    description = "Name of SQL Database"
}

variable "location" {
    type = string
    description = "Location of the Synapse workspace to create"
}

variable "sqladmin_user_name" {
    type = string
    description = "Database login name of the SQL database"
}

variable "sqladmin_user_password" {
    type = string
    description = "Database login password of the SQL database"
}

variable "userid_as_synapse_admin" {
    type = string
    description = "Object ID of the user account to assign the synapse workspace role"
}

variable "create_staging_external_table_sql_path" {
    type = string
    description = "Path to the SQL script to create external table for staging table"
}


output "synapsewp_identity" {
  value = azurerm_synapse_workspace.synapsewp.identity
}


output "synapsewp_aadadmin" {
  value = azurerm_synapse_workspace.synapsewp.aad_admin  
}

output "synapsewp_synapse_wp_name" {
  value = azurerm_synapse_workspace.synapsewp.name
}

output "synapsewp_sql_db_pool_name" {
  value = azurerm_synapse_sql_pool.dedicatedsqlpool.name
}

