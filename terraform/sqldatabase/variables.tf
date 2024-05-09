variable "resource_group_name" {
    type = string
    description = "Resource group name under which the SQL server is created"
}

variable "sql_server_name" {
    type = string
    description = "Name of SQL Server"
}

variable "sql_database_name" {
    type = string
    description = "Name of SQL Database"
}

variable "location" {
    type = string
    description = "Location of the SQL server to create"
}

variable "sqladmin_user_name" {
    type = string
    description = "Database login name of the SQL database"
}

variable "sqladmin_user_password" {
    type = string
    description = "Database login password of the SQL database"
}

variable "create_table_sql_path" {
    type = string
    description = "Path to the SQL script to create tables"
  
}

variable "client_ip_address" {
    type = string
    description = "IP address of current client to add to the firewall rules for access"
}
