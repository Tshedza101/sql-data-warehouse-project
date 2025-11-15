
Data Dictionary for Gold Layer
Overview:
The gold layer is the business-level data representation structured to support analytical and reporting use cases.
It contains dimension tables and fact tables for specific business metrics.
==============================================================================================================================
1. gold.dim_customers.
   
- Purpose: It is used to store customer detailes filled with demographic and geographical data.

- Columns:

|Column_name     |Data_type     |Description                                                                                 |
|----------------|--------------|--------------------------------------------------------------------------------------------|
|customer_key    |INT           |Surrogate key that uniquely identifies each customer record in the dimension table          |
|customer_id     |INT           |Unique  numerical identifier assigned to each customer                                      |
|customer_number |NVARCHAR(50)  |Alphanumeric identifier representing the customer, used for tacking and referencing         |
|first_name      |NVARCHAR(50)  |The customer's first name as stored in the system                                           |
|last_name       |NVARCHAR(50)  |The customer's last name or family name.                                                    |
|country         |NVARCHAR(50)  |The country of residence for the customer (e.g. 'USA').                                     |
|marital_status  |NVARCHAR(50)  |The marital status of the customer (e.g. 'Married', 'Single'                                |
|gender          |NVARCHAR(50)  |The gender of the customer (e.g. 'Male', 'Female', 'n/a').                                  |
|birthdate       |DATE          |The customer's date of birth formatted as 'YYYY-MM-DD' (e.g 1980-12-25).                    |
|create_date     |DATE          |The date and time when the customer record was created in the system.                       |

2. gold.dim_products.

- Purpose: Provides information about the products and their attributes.

- Columns:
  
|Column_name     |Data_type     |Description                                                                                 |
|----------------|--------------|--------------------------------------------------------------------------------------------|
|product_key     |INT           |Surrogate key that uniquely identifies each product record in the product dimension table.  |
|product_key     |INT           |uniquw numerical identifier assigned to the product for tracking and referencing.           |
|product_number  |NVARCHAR      |A structured alphanumeric identifier code representing the product, often used for categorization or inventory|
|product_name    |NVARCHAR(50)  |Descriptive name for the product including key details such as type, color, and size.       |
|category_id     |NVARCHAR(50)  |A unique identifier for the product's category, linking it to its high-level classification |
|category        |NVARCHAR(50)  |The broader classification of the product (e.g. Bikes, componets) to group related items.   |
|subcategory     |NVARCHAR(50)  |A more detailed classification of the product within the category, such as product type.    |
|maintenance     |NVARCHAR(50)  |Shows whether the product requires to be maintained or not (e.g. 'Yes', or 'No')            |
|cost            |INT           |The price of the product measured in monetery units.                                        |
|product_line    |NVARCHAR(50)  |The specific product line or series to which the product belongs (e.g. 'Road', 'Mountained')|
|start_date      |DATE          |The date when the product became available for sale or in stock                             |

3. gold.fact_sales

- Purpose: Stores transactional sales data for analytical purposes.

- Columns:

|Column_name     |Data_type     |Description                                                                                 |
|----------------|--------------|--------------------------------------------------------------------------------------------|
|order_number    |NVARCHAR(50)  |A unique alphanumeric identifier for each sales order (e.g. 'SO54496').                     |
|product_key     |INT           |Surrogate key linking the order to the product dimension table.                             |
|customer_key    |INT           |Surrogate key linking the order to the product dimension table.                             |
|order_date      |DATE          |The date that the order was placed.                                                         |
|shipping_date   |DATE          |The date that the order was shipped to the customer.                                        |
|due_date        |DATE          |The date when the order payment was due.                                                    |
|sales_amount    |INT           |The total monetary value of the sale for the line item, in whole currency unit(e.g. 30).    |
|quantity        |INT           |The number of units of the product ordered for the line item (e.g. 1).                      |
|price           |INT           |The price per unit of the product for the line item, in whole currency units (e.g. 25).     |
  
