------------------------------------
-- Create view for calendar table creation on gold schema from parquet file situated on silver or tranformation  layer
------------------------------------
create view gold.calendar
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv..core.windows.net/silver/Calendar/', FORMAT='PARQUET')
 AS new_query
--------------------------
--CREATE CUSTOMERS
--------------------------

create view gold.customers
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Customers/', FORMAT='PARQUET')
 AS new_query


-------------------------
--CREATE PRODUCT CATEGORY
-------------------------
create view gold.product_category
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Product_Categories/', FORMAT='PARQUET')
 AS new_query



-------------------------
--CREATE PRODUCT SUB CATEGORY TABLE VIEW
-------------------------

create view gold.product_sub_category
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Product_Subcategories/', FORMAT='PARQUET')
 AS new_query








-------------------------
--CREATE PRODUCT VIEW
-------------------------

create view gold.products
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Products/', FORMAT='PARQUET')
 AS new_query




-------------------------
--CREATE SALES TABLE VIEW
-------------------------
create view gold.sales
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Sales/', FORMAT='PARQUET')
 AS new_query

 






-------------------------
--CREATE RETURNS VIEW
------------------------

create view gold.returns
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Returns/', FORMAT='PARQUET')
 AS new_query



-------------------------
--CREATE TERRITORY VIEW
------------------------



create view gold.territories
as  
SELECT
* FROM OPENROWSET(BULK 'https://awstoragedatalaekeviv.blob.core.windows.net/silver/Territories/', FORMAT='PARQUET')
 AS new_query
