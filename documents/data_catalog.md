
Data Dictionary for Gold Layer
Overview:
The gold layer is the business-level data representation structured to support analytical and reporting use cases.
It contains dimension tables and fact tables for specific business metrics.
==============================================================================================================================
1. gold.dim_customers.
   
Purpose: It is used to store customer detailes filled with demographic and geographical data.

Table:
|Column_name     |Data_type     |Description                                                                                 |
|----------------|--------------|--------------------------------------------------------------------------------------------|
|customer_key    |INT           |Surrogate key that uniquely identifies each customer record in the dimension table          |
|customer_id     |INT           |Unique  numerical identifier assigned to each customer                                      |
|customer_number |NVARCHAR(50)  |Alphanumeric identifier representing the customer, used for tacking and referencing         |
|first_name      |NVARCHAR(50)  |The customer's first name as stored in the system                                           |
|last_name       |NVARCHAR(50)  |The customer's last name or family name.                                                    |
|country         |NVARCHAR(50)  |The country of residence for the customer(e.g. 'USA').                                      |
|marital_status  |NVARCHAR(50)  |The marital status of the customer(e.g. 'Married', 'Single'                                 |
|gender          |NVARCHAR(50)  |The gender of the customer(e.g. 'Male', 'Female', 'n/a').                                   |
|birthdate       |DATE          |The customer's date of birth formatted as 'YYYY-MM-DD' (e.g 1980-12-25).                    |
|create_date     |DATE          |The date and time when the customer record was created in the system.                       |


