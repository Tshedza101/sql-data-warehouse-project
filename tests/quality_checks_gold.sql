/*
=====================================================================
 QUALITY CHECKS
=====================================================================
Script Purpose:
	The task of this script is to perform quality checks to validate
	the integrity, consistency and accuracy of the gold layer.

	These checks ensures:
		- Uniqueness of Surrogate keys in dimension tables
		- Referential integrity between fact and dimension tables
		- Validation of the relationships in the data model for
		  analytical purposes.

	Usage Notes:
		- Run these checks after loading 'silver layer'.
		- Investigate and resolve any discrepancies encountered during checks
*/

-- ==================================================================
-- Checking 'gold.dim_customers'
-- ==================================================================

-- Check the uniquness of the customer_key in 'gold.dim_customers
-- Expectation: No results

SELECT customer_key, COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) >1;

-- ==================================================================
-- Checking 'gold.dim_products'
-- ==================================================================

-- Check the uniquness of the product_key in 'gold.dim_products
-- Expectation: No results

SELECT product_key, COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) >1;


-- ==================================================================
-- Checking 'gold.fact_sales'
-- ==================================================================

-- Check data model connectivity between fact and dimension tables.

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL;
