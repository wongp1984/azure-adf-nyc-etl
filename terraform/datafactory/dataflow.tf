
resource "azurerm_data_factory_data_flow" "dataflow_nycpayroll2020" {
  name            = "dataflow_nycpayroll2020"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "nycpayroll2020CSV"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetnycpayroll2020csv.name
    }
  
  }

  sink {
    name = "nycpayroll2020SQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetpayroll2020sql.name
    }
    
  }

  depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasetnycpayroll2020csv,
                 azurerm_data_factory_custom_dataset.datasetpayroll2020sql
                 ]

  script_lines  = ["source(output(",
                    "          FiscalYear as string,",
                    "          PayrollNumber as string,",
                    "          AgencyID as string,",
                    "          AgencyName as string,",
                    "          EmployeeID as string,",
                    "          LastName as string,",
                    "          FirstName as string,",
                    "          AgencyStartDate as string,",
                    "          WorkLocationBorough as string,",
                    "          TitleCode as string,",
                    "          TitleDescription as string,",
                    "          LeaveStatusasofJune30 as string,",
                    "          BaseSalary as string,",
                    "          PayBasis as string,",
                    "          RegularHours as string,",
                    "          RegularGrossPaid as string,",
                    "          OTHours as string,",
                    "          TotalOTPaid as string,",
                    "          TotalOtherPay as string",
                    "     ),",
                    "     allowSchemaDrift: true,",
                    "     validateSchema: false,",
                    "     ignoreNoFilesFound: false) ~> nycpayroll2020CSV",
                    "nycpayroll2020CSV sink(allowSchemaDrift: true,",
                    "     validateSchema: false,",
                    "     input(",
                    "          FiscalYear as integer,",
                    "          PayrollNumber as integer,",
                    "          AgencyID as string,",
                    "          AgencyName as string,",
                    "          EmployeeID as string,",
                    "          LastName as string,",
                    "          FirstName as string,",
                    "          AgencyStartDate as date,",
                    "          WorkLocationBorough as string,",
                    "          TitleCode as string,",
                    "          TitleDescription as string,",
                    "          LeaveStatusasofJune30 as string,",
                    "          BaseSalary as double,",
                    "          PayBasis as string,",
                    "          RegularHours as double,",
                    "          RegularGrossPaid as double,",
                    "          OTHours as double,",
                    "          TotalOTPaid as double,",
                    "          TotalOtherPay as double",
                    "     ),",
                    "     deletable:false,",
                    "     insertable:true,",
                    "     updateable:false,",
                    "     upsertable:false,",
                    "     format: 'table',",
                    "     skipDuplicateMapInputs: true,",
                    "     skipDuplicateMapOutputs: true,",
                    "     errorHandlingOption: 'stopOnFirstError',",
                    "     mapColumn(",
                    "          FiscalYear,",
                    "          PayrollNumber,",
                    "          AgencyID,",
                    "          AgencyName,",
                    "          EmployeeID,",
                    "          LastName,",
                    "          FirstName,",
                    "          AgencyStartDate,",
                    "          WorkLocationBorough,",
                    "          TitleCode,",
                    "          TitleDescription,",
                    "          LeaveStatusasofJune30,",
                    "          BaseSalary,",
                    "          PayBasis,",
                    "          RegularHours,",
                    "          RegularGrossPaid,",
                    "          OTHours,",
                    "          TotalOTPaid,",
                    "          TotalOtherPay",
                    "     )) ~> nycpayroll2020SQLDB"
                ]

}



resource "azurerm_data_factory_data_flow" "dataflow_nycpayroll2021" {
  name            = "dataflow_nycpayroll2021"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "nycpayroll2021CSV"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetnycpayroll2021csv.name
    }
  
  }

  sink {
    name = "nycpayroll2021SQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetpayroll2021sql.name
    }
    
  }

  depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasetnycpayroll2021csv,
                 azurerm_data_factory_custom_dataset.datasetpayroll2021sql
                 ]

  script_lines  = [
                    "source(output(",
                                "          FiscalYear as string,",
                                "          PayrollNumber as string,",
                                "          AgencyCode as string,",
                                "          AgencyName as string,",
                                "          EmployeeID as string,",
                                "          LastName as string,",
                                "          FirstName as string,",
                                "          AgencyStartDate as string,",
                                "          WorkLocationBorough as string,",
                                "          TitleCode as string,",
                                "          TitleDescription as string,",
                                "          LeaveStatusasofJune30 as string,",
                                "          BaseSalary as string,",
                                "          PayBasis as string,",
                                "          RegularHours as string,",
                                "          RegularGrossPaid as string,",
                                "          OTHours as string,",
                                "          TotalOTPaid as string,",
                                "          TotalOtherPay as string",
                                "     ),",
                                "     allowSchemaDrift: true,",
                                "     validateSchema: false,",
                                "     ignoreNoFilesFound: false) ~> nycpayroll2021CSV",
                                "nycpayroll2021CSV sink(allowSchemaDrift: true,",
                                "     validateSchema: false,",
                                "     input(",
                                "          FiscalYear as integer,",
                                "          PayrollNumber as integer,",
                                "          AgencyCode as string,",
                                "          AgencyName as string,",
                                "          EmployeeID as string,",
                                "          LastName as string,",
                                "          FirstName as string,",
                                "          AgencyStartDate as date,",
                                "          WorkLocationBorough as string,",
                                "          TitleCode as string,",
                                "          TitleDescription as string,",
                                "          LeaveStatusasofJune30 as string,",
                                "          BaseSalary as double,",
                                "          PayBasis as string,",
                                "          RegularHours as double,",
                                "          RegularGrossPaid as double,",
                                "          OTHours as double,",
                                "          TotalOTPaid as double,",
                                "          TotalOtherPay as double",
                                "     ),",
                                "     deletable:false,",
                                "     insertable:true,",
                                "     updateable:false,",
                                "     upsertable:false,",
                                "     format: 'table',",
                                "     skipDuplicateMapInputs: true,",
                                "     skipDuplicateMapOutputs: true,",
                                "     errorHandlingOption: 'stopOnFirstError',",
                                "     mapColumn(",
                                "          FiscalYear,",
                                "          PayrollNumber,",
                                "          AgencyCode,",
                                "          AgencyName,",
                                "          EmployeeID,",
                                "          LastName,",
                                "          FirstName,",
                                "          AgencyStartDate,",
                                "          WorkLocationBorough,",
                                "          TitleCode,",
                                "          TitleDescription,",
                                "          LeaveStatusasofJune30,",
                                "          BaseSalary,",
                                "          PayBasis,",
                                "          RegularHours,",
                                "          RegularGrossPaid,",
                                "          OTHours,",
                                "          TotalOTPaid,",
                                "          TotalOtherPay",
                                "     )) ~> nycpayroll2021SQLDB"
                ]

}



resource "azurerm_data_factory_data_flow" "dataflow_NYC_Payroll_EMP_MD" {
  name            = "dataflow_NYC_Payroll_EMP_MD"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "EmpMasterCSV"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetempmastercsv.name
    }
  
  }

  sink {
    name = "NYCPayrollEMPMDSQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetempmdsql.name
    }
    
  }

  depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasetempmastercsv,
                 azurerm_data_factory_custom_dataset.datasetempmdsql
                 ]

  script_lines  = [
                     "source(output(",
                        "          EmployeeID as string,",
                        "          LastName as string,",
                        "          FirstName as string",
                        "     ),",
                        "     allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     ignoreNoFilesFound: false) ~> EmpMasterCSV",
                        "EmpMasterCSV sink(allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     input(",
                        "          EmployeeID as string,",
                        "          LastName as string,",
                        "          FirstName as string",
                        "     ),",
                        "     deletable:false,",
                        "     insertable:true,",
                        "     updateable:false,",
                        "     upsertable:false,",
                        "     format: 'table',",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true,",
                        "     errorHandlingOption: 'stopOnFirstError',",
                        "     mapColumn(",
                        "          EmployeeID,",
                        "          LastName,",
                        "          FirstName",
                        "     )) ~> NYCPayrollEMPMDSQLDB"
                ]

}


resource "azurerm_data_factory_data_flow" "dataflow_NYC_Payroll_TITLE_MD" {
  name            = "dataflow_NYC_Payroll_TITLE_MD"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "TitleMasterCSV"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasettitlemastercsv.name
    }
  
  }

  sink {
    name = "NYCPayrollTITLEMDSQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasettitlemdsql.name
    }
    
  }

    depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasettitlemastercsv,
                 azurerm_data_factory_custom_dataset.datasettitlemdsql
                 ]

  script_lines  = [
                     "source(output(",
                        "          TitleCode as string,",
                        "          TitleDescription as string",
                        "     ),",
                        "     allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     ignoreNoFilesFound: false) ~> TitleMasterCSV",
                        "TitleMasterCSV sink(allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     deletable:false,",
                        "     insertable:true,",
                        "     updateable:false,",
                        "     upsertable:false,",
                        "     format: 'table',",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true,",
                        "     errorHandlingOption: 'stopOnFirstError',",
                        "     mapColumn(",
                        "          TitleCode,",
                        "          TitleDescription",
                        "     )) ~> NYCPayrollTITLEMDSQLDB"
                ]

}



resource "azurerm_data_factory_data_flow" "dataflow_Payroll_AGENCY_MD" {
  name            = "dataflow_Payroll_AGENCY_MD"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "AgencyMasterCSV"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetagencymastercsv.name
    }
  
  }

  sink {
    name = "NYCPayrollAGENCYMDSQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetagencymdsql.name
    }
    
  }

    depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasetagencymastercsv,
                 azurerm_data_factory_custom_dataset.datasetagencymdsql
                 ]

  script_lines  = [
                       "source(output(",
                        "          AgencyID as string,",
                        "          AgencyName as string",
                        "     ),",
                        "     allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     ignoreNoFilesFound: false) ~> AgencyMasterCSV",
                        "AgencyMasterCSV sink(allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     input(",
                        "          AgencyID as string,",
                        "          AgencyName as string",
                        "     ),",
                        "     deletable:false,",
                        "     insertable:true,",
                        "     updateable:false,",
                        "     upsertable:false,",
                        "     format: 'table',",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true,",
                        "     errorHandlingOption: 'stopOnFirstError',",
                        "     mapColumn(",
                        "          AgencyID,",
                        "          AgencyName",
                        "     )) ~> NYCPayrollAGENCYMDSQLDB"
                ]

}


resource "azurerm_data_factory_data_flow" "dataflow_summary" {
  name            = "dataflow_summary"
  data_factory_id = azurerm_data_factory.myadf.id

  source {
    name = "nycpayroll2020SQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetpayroll2020sql.name
    }
  
  }

  source {
    name = "nycpayroll2021SQLDB"

    dataset {
        name = azurerm_data_factory_custom_dataset.datasetpayroll2021sql.name
    }
    
  }

  sink {
    name = "sinkSummarySQLDB"

     dataset {
        name = azurerm_data_factory_custom_dataset.datasetpayrollsummarysql.name
    }
  }

  sink {
    name = "sinkStaging"

     dataset {
        name = azurerm_data_factory_custom_dataset.datasetstagingcsv.name
    }
  }

  depends_on = [ azurerm_data_factory.myadf, 
                 azurerm_data_factory_custom_dataset.datasetpayroll2020sql,
                 azurerm_data_factory_custom_dataset.datasetpayroll2021sql,
                 azurerm_data_factory_custom_dataset.datasetpayrollsummarysql,
                 azurerm_data_factory_custom_dataset.datasetstagingcsv,
                 ]

  transformation {
    name = "union1"
  }
  transformation {
    name = "selectpayroll2020"
  }
  transformation {
    name = "selectpayroll2021"
  }
  transformation {
    name = "filterFiscalYear"
  }
  transformation {
    name = "derivedColumnTotalPaid"
  }
  transformation {
    name = "aggregate1"
  }
 
  script_lines  = [
                       "parameters{",
                        "     dataflow_param_fiscalyear as integer (2020)",
                        "}",
                        "source(output(",
                        "          FiscalYear as integer,",
                        "          PayrollNumber as integer,",
                        "          AgencyID as string,",
                        "          AgencyName as string,",
                        "          EmployeeID as string,",
                        "          LastName as string,",
                        "          FirstName as string,",
                        "          AgencyStartDate as date,",
                        "          WorkLocationBorough as string,",
                        "          TitleCode as string,",
                        "          TitleDescription as string,",
                        "          LeaveStatusasofJune30 as string,",
                        "          BaseSalary as double,",
                        "          PayBasis as string,",
                        "          RegularHours as double,",
                        "          RegularGrossPaid as double,",
                        "          OTHours as double,",
                        "          TotalOTPaid as double,",
                        "          TotalOtherPay as double",
                        "     ),",
                        "     allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     isolationLevel: 'READ_UNCOMMITTED',",
                        "     format: 'table') ~> nycpayroll2020SQLDB",
                        "source(output(",
                        "          FiscalYear as integer,",
                        "          PayrollNumber as integer,",
                        "          AgencyCode as string,",
                        "          AgencyName as string,",
                        "          EmployeeID as string,",
                        "          LastName as string,",
                        "          FirstName as string,",
                        "          AgencyStartDate as date,",
                        "          WorkLocationBorough as string,",
                        "          TitleCode as string,",
                        "          TitleDescription as string,",
                        "          LeaveStatusasofJune30 as string,",
                        "          BaseSalary as double,",
                        "          PayBasis as string,",
                        "          RegularHours as double,",
                        "          RegularGrossPaid as double,",
                        "          OTHours as double,",
                        "          TotalOTPaid as double,",
                        "          TotalOtherPay as double",
                        "     ),",
                        "     allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     isolationLevel: 'READ_UNCOMMITTED',",
                        "     format: 'table') ~> nycpayroll2021SQLDB",
                        "selectpayroll2020, selectpayroll2021 union(byName: true)~> union1",
                        "nycpayroll2020SQLDB select(mapColumn(",
                        "          FiscalYear,",
                        "          PayrollNumber,",
                        "          AgencyID,",
                        "          AgencyName,",
                        "          EmployeeID,",
                        "          LastName,",
                        "          FirstName,",
                        "          AgencyStartDate,",
                        "          WorkLocationBorough,",
                        "          TitleCode,",
                        "          TitleDescription,",
                        "          LeaveStatusasofJune30,",
                        "          BaseSalary,",
                        "          PayBasis,",
                        "          RegularHours,",
                        "          RegularGrossPaid,",
                        "          OTHours,",
                        "          TotalOTPaid,",
                        "          TotalOtherPay",
                        "     ),",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true) ~> selectpayroll2020",
                        "nycpayroll2021SQLDB select(mapColumn(",
                        "          FiscalYear,",
                        "          PayrollNumber,",
                        "          AgencyID = AgencyCode,",
                        "          AgencyName,",
                        "          EmployeeID,",
                        "          LastName,",
                        "          FirstName,",
                        "          AgencyStartDate,",
                        "          WorkLocationBorough,",
                        "          TitleCode,",
                        "          TitleDescription,",
                        "          LeaveStatusasofJune30,",
                        "          BaseSalary,",
                        "          PayBasis,",
                        "          RegularHours,",
                        "          RegularGrossPaid,",
                        "          OTHours,",
                        "          TotalOTPaid,",
                        "          TotalOtherPay",
                        "     ),",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true) ~> selectpayroll2021",
                        "union1 filter(toInteger(FiscalYear)>=$dataflow_param_fiscalyear) ~> filterFiscalYear",
                        "filterFiscalYear derive(TotalPaid = RegularGrossPaid+TotalOTPaid+TotalOtherPay) ~> derivedColumnTotalPaid",
                        "derivedColumnTotalPaid aggregate(groupBy(AgencyName,",
                        "          FiscalYear),",
                        "     TotalPaidByAgencyAndYear = sum(TotalPaid)) ~> aggregate1",
                        "aggregate1 sink(allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     input(",
                        "          FiscalYear as integer,",
                        "          AgencyName as string,",
                        "          TotalPaid as double",
                        "     ),",
                        "     deletable:false,",
                        "     insertable:true,",
                        "     updateable:false,",
                        "     upsertable:false,",
                        "     truncate:true,",
                        "     format: 'table',",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true,",
                        "     errorHandlingOption: 'stopOnFirstError',",
                        "     mapColumn(",
                        "          FiscalYear,",
                        "          AgencyName,",
                        "          TotalPaid = TotalPaidByAgencyAndYear",
                        "     )) ~> sinkSummarySQLDB",
                        "aggregate1 sink(allowSchemaDrift: true,",
                        "     validateSchema: false,",
                        "     truncate: true,",
                        "     umask: 0022,",
                        "     preCommands: [],",
                        "     postCommands: [],",
                        "     skipDuplicateMapInputs: true,",
                        "     skipDuplicateMapOutputs: true,",
                        "     mapColumn(",
                        "          AgencyName,",
                        "          FiscalYear,",
                        "          TotalPaidByAgencyAndYear",
                        "     )) ~> sinkStaging"
                ]

}