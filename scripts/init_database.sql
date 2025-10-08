/*
-------------------------------------------------
Creating Database 'DataWarehouse' and SCHEMAS
-------------------------------------------------
Script Purpose:
	The purpose of this script is to create a new database called 'DataWrehouse' after checking if it already exist
	If the databse exist, it is dropped and then recreated. The script also sets up three schemas within
	the databse which are: 'bronze', 'silver', 'gold'.

Warning:
	Running this script will drop the entire 'DataWrehouse' database if it exist. All the data in the databse
	will be permanently deleted so procede with caution and make sure you have proper backup beofre running
	the script.
	*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' databse if exist
IF EXISTs (SELECT 1 FROM sys.databases  WHERE  name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END
GO

--Creating the 'DataWarehouse' database

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- CREATING SCHEMAS
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
