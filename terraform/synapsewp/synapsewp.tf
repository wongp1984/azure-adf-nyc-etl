resource "azurerm_resource_group" "synappgrp" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "synapstorageacc" {
  name                     = "synapstorageacc889921"
  resource_group_name      = azurerm_resource_group.synappgrp.name
  location                 = azurerm_resource_group.synappgrp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "examplefs" {
  name               = "examplefs"
  storage_account_id = azurerm_storage_account.synapstorageacc.id
}

resource "azurerm_synapse_workspace" "synapsewp" {
  name                                 = "synapsewp8964198"
  resource_group_name                  = azurerm_resource_group.synappgrp.name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.examplefs.id
  sql_administrator_login              = var.sqladmin_user_name
  sql_administrator_login_password     = var.sqladmin_user_password

  managed_virtual_network_enabled = false
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  depends_on = [ azurerm_resource_group.synappgrp, azurerm_storage_account.synapstorageacc, azurerm_storage_data_lake_gen2_filesystem.examplefs ]
}


resource "azurerm_synapse_firewall_rule" "allowall" {
  name                 = "AllowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapsewp.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"

  depends_on = [ azurerm_synapse_workspace.synapsewp ]
}


resource "azurerm_synapse_firewall_rule" "allowallazurefeatures" {
  name                 = "AllowAllWindowsAzureIps"
  synapse_workspace_id = azurerm_synapse_workspace.synapsewp.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"

  depends_on = [ azurerm_synapse_workspace.synapsewp ]
}


resource "azurerm_synapse_role_assignment" "synapsewproleassign" {
  synapse_workspace_id = azurerm_synapse_workspace.synapsewp.id
  role_name            = "Synapse Administrator"
  principal_id         = var.userid_as_synapse_admin
  # principal_id         = data.azurerm_client_config.current.object_id

  depends_on = [azurerm_synapse_workspace.synapsewp, azurerm_synapse_firewall_rule.allowall, azurerm_synapse_firewall_rule.allowallazurefeatures]
}


resource "azurerm_synapse_sql_pool" "dedicatedsqlpool" {
  name                 = "dedicatedsqlpool"
  synapse_workspace_id = azurerm_synapse_workspace.synapsewp.id
  sku_name             = "DW100c"
  create_mode          = "Default"
  storage_account_type = "LRS"
  geo_backup_policy_enabled = false

  depends_on = [azurerm_synapse_workspace.synapsewp, azurerm_synapse_role_assignment.synapsewproleassign]
}

# This creates external table in the dedicated sql pool. Need to use the -I option in sqlcmd to support QUOTED_IDENTIFIER option
resource "null_resource" "external_table_setup2" {
  provisioner "local-exec" {
      command = "sqlcmd -S ${azurerm_synapse_workspace.synapsewp.name}.sql.azuresynapse.net -U ${var.sqladmin_user_name} -P ${var.sqladmin_user_password} -d ${azurerm_synapse_sql_pool.dedicatedsqlpool.name} -i ${var.create_staging_external_table_sql_path} -I"
  }
  depends_on=[
    azurerm_synapse_workspace.synapsewp,  azurerm_synapse_sql_pool.dedicatedsqlpool
  ]
}
