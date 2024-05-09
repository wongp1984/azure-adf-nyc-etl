resource "azurerm_resource_group" "adfappgrp" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_data_factory" "myadf" {
  name                = "adf898864221"
  location            = var.location
  resource_group_name = var.resource_group_name
  public_network_enabled = true

  depends_on = [ azurerm_resource_group.adfappgrp ]
}


# data "azurerm_client_config" "current" {
# }

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "linksvcstgacc" {
  name                  = "linksvcstgacc"
  data_factory_id       = azurerm_data_factory.myadf.id
  url                   = var.link_storage_acc
  storage_account_key   = var.storage_acc_access_key

  depends_on = [ azurerm_data_factory.myadf ]
}


resource "azurerm_data_factory_linked_service_azure_sql_database" "linksqldb" {
  name              = "linksqldb"
  data_factory_id   = azurerm_data_factory.myadf.id
  connection_string = "data source=${var.link_sql_server};initial catalog=${var.link_sql_db};user id=sqladmin;Password=${var.sql_db_admin_password};integrated security=False;encrypt=True;connection timeout=30"

  depends_on = [ azurerm_data_factory.myadf ]
}


resource "azurerm_data_factory_linked_service_synapse" "linksynapse" {
  name            = "linksynapse"
  data_factory_id = azurerm_data_factory.myadf.id

  connection_string = "Integrated Security=False;Data Source=${var.link_synapse_sql_server};Initial Catalog=${var.link_synapse_sql_db};User ID=sqladmin;Password=${var.sql_db_admin_password}"

  depends_on = [ azurerm_data_factory.myadf ]
}




resource "azurerm_data_factory_custom_dataset" "datasetnycpayroll2021csv" {
  name            = "datasetnycpayroll2021csv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                    "location": {
                                        "type": "AzureBlobFSLocation",
                                        "fileName": "nycpayroll_2021.csv",
                                        "folderPath": "dirpayrollfiles",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "nycpayroll_2021"

  schema_json = <<EOT
                          [  {"name": "FiscalYear",
                                "type": "String"
                                },
                                {
                                    "name": "PayrollNumber",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyCode",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyName",
                                    "type": "String"
                                },
                                {
                                    "name": "EmployeeID",
                                    "type": "String"
                                },
                                {
                                    "name": "LastName",
                                    "type": "String"
                                },
                                {
                                    "name": "FirstName",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyStartDate",
                                    "type": "String"
                                },
                                {
                                    "name": "WorkLocationBorough",
                                    "type": "String"
                                },
                                {
                                    "name": "TitleCode",
                                    "type": "String"
                                },
                                {
                                    "name": "TitleDescription",
                                    "type": "String"
                                },
                                {
                                    "name": "LeaveStatusasofJune30",
                                    "type": "String"
                                },
                                {
                                    "name": "BaseSalary",
                                    "type": "String"
                                },
                                {
                                    "name": "PayBasis",
                                    "type": "String"
                                },
                                {
                                    "name": "RegularHours",
                                    "type": "String"
                                },
                                {
                                    "name": "RegularGrossPaid",
                                    "type": "String"
                                },
                                {
                                    "name": "OTHours",
                                    "type": "String"
                                },
                                {
                                    "name": "TotalOTPaid",
                                    "type": "String"
                                },
                                {
                                    "name": "TotalOtherPay",
                                    "type": "String"
                                } ]
                    EOT

    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}




resource "azurerm_data_factory_custom_dataset" "datasetnycpayroll2020csv" {
  name            = "datasetnycpayroll2020csv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                    "location": {
                                        "type": "AzureBlobFSLocation",
                                        "fileName": "nycpayroll_2020.csv",
                                        "folderPath": "history",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "nycpayroll_2020"

  schema_json = <<EOT
                           [
                                {
                                    "name": "FiscalYear",
                                    "type": "String"
                                },
                                {
                                    "name": "PayrollNumber",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyID",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyName",
                                    "type": "String"
                                },
                                {
                                    "name": "EmployeeID",
                                    "type": "String"
                                },
                                {
                                    "name": "LastName",
                                    "type": "String"
                                },
                                {
                                    "name": "FirstName",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyStartDate",
                                    "type": "String"
                                },
                                {
                                    "name": "WorkLocationBorough",
                                    "type": "String"
                                },
                                {
                                    "name": "TitleCode",
                                    "type": "String"
                                },
                                {
                                    "name": "TitleDescription",
                                    "type": "String"
                                },
                                {
                                    "name": "LeaveStatusasofJune30",
                                    "type": "String"
                                },
                                {
                                    "name": "BaseSalary",
                                    "type": "String"
                                },
                                {
                                    "name": "PayBasis",
                                    "type": "String"
                                },
                                {
                                    "name": "RegularHours",
                                    "type": "String"
                                },
                                {
                                    "name": "RegularGrossPaid",
                                    "type": "String"
                                },
                                {
                                    "name": "OTHours",
                                    "type": "String"
                                },
                                {
                                    "name": "TotalOTPaid",
                                    "type": "String"
                                },
                                {
                                    "name": "TotalOtherPay",
                                    "type": "String"
                                }
                            ]
                    EOT

    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}




resource "azurerm_data_factory_custom_dataset" "datasetagencymastercsv" {
  name            = "datasetagencymastercsv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                    "location": {
                                        "type": "AzureBlobFSLocation",
                                        "fileName": "AgencyMaster.csv",
                                        "folderPath": "dirpayrollfiles",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "AgencyMaster"

  schema_json = <<EOT
                         [
                            {
                                "name": "AgencyID",
                                "type": "String"
                            },
                            {
                                "name": "AgencyName",
                                "type": "String"
                            }
                        ]
                    EOT

   
    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}




resource "azurerm_data_factory_custom_dataset" "datasetempmastercsv" {
  name            = "datasetempmastercsv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                   "location": {
                                        "type": "AzureBlobFSLocation",
                                        "fileName": "EmpMaster.csv",
                                        "folderPath": "dirpayrollfiles",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "EmpMaster"

  schema_json = <<EOT
                         [
                            {
                                "name": "EmployeeID",
                                "type": "String"
                            },
                            {
                                "name": "LastName",
                                "type": "String"
                            },
                            {
                                "name": "FirstName",
                                "type": "String"
                            }
                        ]
                    EOT

   
    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}



resource "azurerm_data_factory_custom_dataset" "datasettitlemastercsv" {
  name            = "datasettitlemastercsv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                   "location": {
                                        "type": "AzureBlobFSLocation",
                                        "fileName": "TitleMaster.csv",
                                        "folderPath": "dirpayrollfiles",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "EmpMaster"

  schema_json = <<EOT
                          [
                                {
                                    "name": "TitleCode",
                                    "type": "String"
                                },
                                {
                                    "name": "TitleDescription",
                                    "type": "String"
                                }
                            ]
                    EOT

    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}



resource "azurerm_data_factory_custom_dataset" "datasetstagingcsv" {
  name            = "datasetstagingcsv"
  data_factory_id = azurerm_data_factory.myadf.id
  type            = "DelimitedText"

  linked_service {
    name = azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc.name
  }

    # This json is obtained from the ADF portal dataset json view
  type_properties_json = <<JSON
                                {
                                    "location": {
                                        "type": "AzureBlobFSLocation",
                                        "folderPath": "dirstaging",
                                        "fileSystem": "adlsnycpayroll-ak"
                                    },
                                    "columnDelimiter": ",",
                                    "escapeChar": "\\",
                                    "firstRowAsHeader": true,
                                    "quoteChar": "\""
                                }
                            JSON

  description = "EmpMaster"

  schema_json = <<EOT
                          [
                               {
                                    "name": "FiscalYear",
                                    "type": "String"
                                },
                                {
                                    "name": "AgencyName",
                                    "type": "String"
                                },
                                {
                                    "name": "TotalPaid",
                                    "type": "String"
                                }
                            ]
                    EOT

    depends_on = [ azurerm_data_factory_linked_service_data_lake_storage_gen2.linksvcstgacc ]
}



resource "azurerm_data_factory_custom_dataset" "datasetagencymdsql" {
  name              = "datasetagencymdsql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_AGENCY_MD"
                                }
                            JSON

  schema_json = <<EOT
                         [
                                {
                                    "name": "AgencyID",
                                    "type": "varchar"
                                },
                                {
                                    "name": "AgencyName",
                                    "type": "varchar"
                                }
                            ]
                    EOT

     depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]

}



resource "azurerm_data_factory_custom_dataset" "datasetpayroll2020sql" {
  name              = "datasetpayroll2020sql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_Data_2020"
                                }
                            JSON

  schema_json = <<EOT
                        [
                            {
                                "name": "FiscalYear",
                                "type": "int",
                                "precision": 10
                            },
                            {
                                "name": "PayrollNumber",
                                "type": "int",
                                "precision": 10
                            },
                            {
                                "name": "AgencyID",
                                "type": "varchar"
                            },
                            {
                                "name": "AgencyName",
                                "type": "varchar"
                            },
                            {
                                "name": "EmployeeID",
                                "type": "varchar"
                            },
                            {
                                "name": "LastName",
                                "type": "varchar"
                            },
                            {
                                "name": "FirstName",
                                "type": "varchar"
                            },
                            {
                                "name": "AgencyStartDate",
                                "type": "date"
                            },
                            {
                                "name": "WorkLocationBorough",
                                "type": "varchar"
                            },
                            {
                                "name": "TitleCode",
                                "type": "varchar"
                            },
                            {
                                "name": "TitleDescription",
                                "type": "varchar"
                            },
                            {
                                "name": "LeaveStatusasofJune30",
                                "type": "varchar"
                            },
                            {
                                "name": "BaseSalary",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "PayBasis",
                                "type": "varchar"
                            },
                            {
                                "name": "RegularHours",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "RegularGrossPaid",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "OTHours",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "TotalOTPaid",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "TotalOtherPay",
                                "type": "float",
                                "precision": 15
                            }
                        ]
                    EOT
    depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]
}





resource "azurerm_data_factory_custom_dataset" "datasetpayroll2021sql" {
  name              = "datasetpayroll2021sql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_Data_2021"
                                }
                            JSON

  schema_json = <<EOT
                         [
                            {
                                "name": "FiscalYear",
                                "type": "int",
                                "precision": 10
                            },
                            {
                                "name": "PayrollNumber",
                                "type": "int",
                                "precision": 10
                            },
                            {
                                "name": "AgencyCode",
                                "type": "varchar"
                            },
                            {
                                "name": "AgencyName",
                                "type": "varchar"
                            },
                            {
                                "name": "EmployeeID",
                                "type": "varchar"
                            },
                            {
                                "name": "LastName",
                                "type": "varchar"
                            },
                            {
                                "name": "FirstName",
                                "type": "varchar"
                            },
                            {
                                "name": "AgencyStartDate",
                                "type": "date"
                            },
                            {
                                "name": "WorkLocationBorough",
                                "type": "varchar"
                            },
                            {
                                "name": "TitleCode",
                                "type": "varchar"
                            },
                            {
                                "name": "TitleDescription",
                                "type": "varchar"
                            },
                            {
                                "name": "LeaveStatusasofJune30",
                                "type": "varchar"
                            },
                            {
                                "name": "BaseSalary",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "PayBasis",
                                "type": "varchar"
                            },
                            {
                                "name": "RegularHours",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "RegularGrossPaid",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "OTHours",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "TotalOTPaid",
                                "type": "float",
                                "precision": 15
                            },
                            {
                                "name": "TotalOtherPay",
                                "type": "float",
                                "precision": 15
                            }
                        ]
                    EOT
    depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]
}





resource "azurerm_data_factory_custom_dataset" "datasetempmdsql" {
  name              = "datasetempmdsql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_EMP_MD"
                                }
                            JSON

  schema_json = <<EOT
                         [
                            {
                                "name": "EmployeeID",
                                "type": "varchar"
                            },
                            {
                                "name": "LastName",
                                "type": "varchar"
                            },
                            {
                                "name": "FirstName",
                                "type": "varchar"
                            }
                        ]
                    EOT
    depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]
}



resource "azurerm_data_factory_custom_dataset" "datasetpayrollsummarysql" {
  name              = "datasetpayrollsummarysql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_Summary"
                                }
                            JSON

  schema_json = <<EOT
                        [
                            {
                                "name": "FiscalYear",
                                "type": "int",
                                "precision": 10
                            },
                            {
                                "name": "AgencyName",
                                "type": "varchar"
                            },
                            {
                                "name": "TotalPaid",
                                "type": "float",
                                "precision": 15
                            }
                        ]
                    EOT

    depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]
}





resource "azurerm_data_factory_custom_dataset" "datasettitlemdsql" {
  name              = "datasettitlemdsql"
  data_factory_id   = azurerm_data_factory.myadf.id

  linked_service {
    name = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.name
  }

  type = "AzureSqlTable"
 
  type_properties_json = <<JSON
                                {
                                   "schema": "dbo",
                                   "table": "NYC_Payroll_TITLE_MD"
                                }
                            JSON

  schema_json = <<EOT
                        [
                            {
                                "name": "TitleCode",
                                "type": "varchar"
                            },
                            {
                                "name": "TitleDescription",
                                "type": "varchar"
                            }
                        ]
                    EOT
    depends_on = [ azurerm_data_factory_linked_service_azure_sql_database.linksqldb ]
}



# resource "azurerm_data_factory_dataset_azure_sql_table" "datasetagencymdsql" {
#   name              = "datasetagencymdsql"
#   data_factory_id   = azurerm_data_factory.myadf.id
#   linked_service_id = azurerm_data_factory_linked_service_azure_sql_database.linksqldb.id
#   schema = "dbo"
#   table = "NYC_Payroll_AGENCY_MD"

#   schema_column  {
#                 name = "AgencyID"
#                 type = "String"
#   }

#   schema_column {
#                 name = "AgencyName"
#                 type = "String"
#   }

# }







