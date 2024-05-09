resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location  
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sqladmin_user_name
  administrator_login_password = var.sqladmin_user_password
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_mssql_database" "appdb" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2  
  sku_name       = "S0" 

  lifecycle {
    ignore_changes = [
      license_type
    ]
  }

  depends_on = [
    azurerm_mssql_server.sqlserver
      ]
}


# This rule allows current client IP address to connect to the database
resource "azurerm_mssql_firewall_rule" "allowclient" {
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = var.client_ip_address
  end_ip_address   = var.client_ip_address
  depends_on = [
    azurerm_mssql_server.sqlserver
  ]
}


# This creates tables in the database
resource "null_resource" "database_setup" {
  provisioner "local-exec" {
      command = "sqlcmd -S ${azurerm_mssql_server.sqlserver.fully_qualified_domain_name} -U ${azurerm_mssql_server.sqlserver.administrator_login} -P ${azurerm_mssql_server.sqlserver.administrator_login_password} -d ${azurerm_mssql_database.appdb.name} -i ${var.create_table_sql_path}"
  }
  depends_on=[
    azurerm_mssql_database.appdb,  azurerm_mssql_firewall_rule.allowclient
  ]
}


# This rule allows all azure services to connect to the database
resource "azurerm_mssql_firewall_rule" "allowallazure" {
  name             = "AllowAllAzure"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
  depends_on = [
    azurerm_mssql_server.sqlserver, azurerm_mssql_firewall_rule.allowclient, null_resource.database_setup
  ]
}