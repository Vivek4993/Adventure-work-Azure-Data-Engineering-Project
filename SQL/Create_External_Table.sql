-------------------------------
-- 1. Create a scoped credential
-------------------------------
CREATE DATABASE SCOPED CREDENTIAL CRED_VIV
WITH
    IDENTITY = 'MANAGED IDENTITY';

-------------------------------
-- 2. Create external data sources (using dfs endpoint)
-------------------------------
CREATE EXTERNAL DATA SOURCE SOURCE_SILVER
WITH (
    LOCATION = 'https://awstoragedatalaekeviv.blob.core.windows.net/silver',
    CREDENTIAL = CRED_VIV
);

CREATE EXTERNAL DATA SOURCE SOURCE_GOLD
WITH (
    LOCATION = 'https://awstoragedatalaekeviv.blob.core.windows.net/gold',
    CREDENTIAL = CRED_VIV
);

-------------------------------
-- 3. Create external file format
-------------------------------
CREATE EXTERNAL FILE FORMAT FORMAT_PARQUET
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);



-------------------------------
-- 5. Create external table using CETAS
-------------------------------
CREATE EXTERNAL TABLE gold.ext_sales
WITH (
    LOCATION = 'ext_sales',                      -- folder under gold container
    DATA_SOURCE = SOURCE_GOLD,
    FILE_FORMAT = FORMAT_PARQUET
)
AS
SELECT * FROM gold.sales;

 

-- 1. Drop the external table (must come first)
IF OBJECT_ID('gold.extsales', 'U') IS NOT NULL
    DROP EXTERNAL TABLE gold.extsales;

-- 2. Drop the external file format
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'FORMAT_PARQUET')
    DROP EXTERNAL FILE FORMAT FORMAT_PARQUET;

-- 3. Drop the external data sources
IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'SOURCE_GOLD')
    DROP EXTERNAL DATA SOURCE SOURCE_GOLD;

IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'SOURCE_SILVER')
    DROP EXTERNAL DATA SOURCE SOURCE_SILVER;

-- 4. Drop the scoped credential
IF EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'CRED_VIV')
    DROP DATABASE SCOPED CREDENTIAL CRED_VIV;


