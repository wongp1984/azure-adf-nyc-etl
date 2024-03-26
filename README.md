# Data Integration Pipelines for NYC Payroll Data Analytics
This project implements an ETL pipeline in Azure Data Factory to extract, transform and load the NYC finance dataset used in the [UDacity Data Engineering with Microsoft Azure](https://www.udacity.com/enrollment/nd0277/2.0.19) nanodegree project. The analytics outcome will accomplish the following objectives:
  1. Analyze how the City's financial resources are allocated and how much of the City's budget is being devoted to overtime.
  2. Make the data available to the interested public to show how the City’s budget is being spent on salary and overtime pay for all municipal employees.

### 1. Source Datasets
The source datasets are [CSV files](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/data-nyc-payroll.zip) which form a STAR schema database for the overtime transactions of NYC staff. The following figure illustrate the dataset relationship.

![StarSchema](https://github.com/wongp1984/azure-adf-nyc-etl/blob/main/images/nyc-payroll-db-schema.jpeg) 
(photo source: https://www.udacity.com/enrollment/nd0277/2.0.19)

### 2. Pipeline Design
The CSV files will be uploaded to containers in Datalake Gen2, and Azure Data Factory will create dataset views on them. Then ADF dataflows and pipelines are built to aggregate the payment data. The a that will be exported to a target directory in DataLake Gen2 storage over which Synapse Analytics external table is built. At a high level the pipeline will look like below

