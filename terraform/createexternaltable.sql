-- sqlcmd -S synapsewp8964198.sql.azuresynapse.net -U sqladmin -P Azure@12345 -d dedicatedsqlpool -i createexternaltable.sql -I

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE,
             FIRST_ROW  = 2
			))
GO


IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'myfilesys_teststcacc9988_dfs_core_windows_net') 
    DROP EXTERNAL DATA SOURCE [myfilesys_teststcacc9988_dfs_core_windows_net] 

-- For running by sqlcmd or SQL management studio, abfss driver does not work.
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'myfilesys_teststcacc9988_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [myfilesys_teststcacc9988_dfs_core_windows_net] 
	WITH (
		-- LOCATION = 'abfss://myfilesys@teststcacc9988.dfs.core.windows.net', 
         --LOCATION = 'http://teststorage8964222.blob.core.windows.net/testcontainer/',
        LOCATION = 'wasbs://adlsnycpayroll-ak@defaultstacc66771.blob.core.windows.net/dirstaging/',
        -- LOCATION = 'wasbs://testcontainer@teststorage8964222.blob.core.windows.net/exampledir/',
        --LOCATION = 'wasbs://adlsnycpayroll-ak2@teststorage8964222.blob.core.windows.net/',
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE dbo.NYC_Payroll_Summary (
    [FiscalYear] [int] NULL,
    [AgencyName] [varchar](50) NULL,
    [TotalPaid] [float] NULL

	)
	WITH (
	LOCATION = '/',
	DATA_SOURCE = [myfilesys_teststcacc9988_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
-- GO


-- SELECT TOP 100 * FROM dbo.NYC_Payroll_Summary
-- GO