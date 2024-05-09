module "datafactory_wp_module" {
  source="./datafactory"
  location = local.location
  resource_group_name = "${terraform.workspace}-adf-grp"
  link_storage_acc = module.storage_account_module.storage_account_name_primary_dfs_url
  storage_acc_access_key = module.storage_account_module.storage_account_name_primary_access_key

  link_sql_server = "${terraform.workspace}sqlsvr66778.database.windows.net"
  link_sql_db = "appdb"
  sql_db_admin_password = var.sqladmin_secret

  link_synapse_sql_db = module.synapse_wp_module.synapsewp_sql_db_pool_name
  link_synapse_sql_server = "${module.synapse_wp_module.synapsewp_synapse_wp_name}.sql.azuresynapse.net"

  depends_on = [ module.storage_account_module, module.synapse_wp_module]

}

module "synapse_wp_module" {
  source="./synapsewp"
  location = local.location
  resource_group_name = "${terraform.workspace}-synpwp-grp"
  sql_database_name = "synapdb"
  sqladmin_user_name = "sqladmin"
  sqladmin_user_password = var.sqladmin_secret
  userid_as_synapse_admin = var.azure_admin_id
  create_staging_external_table_sql_path = "createexternaltable.sql"

  depends_on = [ module.storage_account_module ]
}

output "synapse_wp_module_identity" {
  value = module.synapse_wp_module.synapsewp_identity[0].principal_id
}


module "storage_account_module"{
  source="./storageaccount"
  location = local.location
  resource_group_name = "${terraform.workspace}-stgacc-grp"
  storage_account_name = "${terraform.workspace}stacc66771"
}

output "storage_account_access_key" {
  value = module.storage_account_module.storage_account_name_primary_access_key
  sensitive = true
}

output "storage_account_df_url" {
  value = module.storage_account_module.storage_account_name_primary_dfs_url
}


data "external" "myipaddr" {
  program = ["curl", "-s", "https://api.ipify.org?format=json"]
}


module "sql_database_module"{

  source = "./sqldatabase"
  resource_group_name = "${terraform.workspace}-sqldb-grp8"
  sql_server_name = "${terraform.workspace}sqlsvr66778"
  sql_database_name = "appdb"
  location = local.location
  sqladmin_user_name = "sqladmin"
  sqladmin_user_password = var.sqladmin_secret
  create_table_sql_path = "createtables.sql"
  client_ip_address = data.external.myipaddr.result.ip
}



