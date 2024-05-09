# Data Integration Pipelines for NYC Payroll Data Analytics
This project implements an ETL pipeline in Azure Data Factory to extract, transform and load the NYC finance dataset used in the [UDacity Data Engineering with Microsoft Azure](https://www.udacity.com/enrollment/nd0277/2.0.19) nanodegree project. The analytics outcome will accomplish the following objectives:
  1. Analyze how the City's financial resources are allocated and how much of the City's budget is being devoted to overtime.
  2. Make the data available to the interested public to show how the City’s budget is being spent on salary and overtime pay for all municipal employees.

### Source Datasets
The source datasets are [CSV files](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/data-nyc-payroll.zip) which form a STAR schema database for the overtime transactions of NYC staff. The following figure illustrate the dataset relationship.

![StarSchema](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/images/nyc-payroll-db-schema.jpeg) 
(photo source: https://www.udacity.com/enrollment/nd0277/2.0.19)

### Pipeline Design
The CSV files will be uploaded to containers in Datalake Gen2 storage account, and Azure Data Factory will create dataset views on them. Then ADF dataflows and pipeline are built to aggregate the payment data. The pipeline will first load the CSV files in the Data Lake Gen2 containers to the Azure SQL database staging tables. From the Azure SQL database tables, the last summary dataflow activity, as shown in below diagram, will select the required columns and perform aggregation. The aggregated results are then saved back to the Azure SQL database summary table.

![pipeline](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/images/pipeline_adf.png)


In the summary dataflow, the two transaction tables in 2020 and 2021 are unioned. Only transactions with fiscal year greater than 2020 are included by using the filter action. The derived column action is to compute the total payment by miscellaneous payment columns in the transaction table to derive the total payment amount per staff per fiscal year. This aggregated data is then sunk to a AZure SQL database table and another staging folder in the Datalake Gen2 storage account.  
![aggregate_summary](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/images/dataflow_aggregate_tables.png)


An external table in Azure Synapse Serverless SQL pool is created to query the aggregated data stored in the staging folder in the Datalake Gen2 storage account. It's implementation can be referred in this [repo](https://github.com/wongp1984/azure-synapse-nyc-etl).

### IaC
The whole implementation of this pipeline can be reconstructed using these terraform [scripts](https://github.com/wongp1984/azure-adf-nyc-etl/tree/main/terraform). 