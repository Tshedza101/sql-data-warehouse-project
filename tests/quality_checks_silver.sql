/*
============================================================================
Quality Checks
============================================================================
Script Purpose:
	This script perform various quality checks for data consistency, accuracy
	and standardization across the 'silver' schema. 

	It includes checks for:
		- Null or duplicate primary keys.
		- Unwanted spaces in string fields.
		- Data standardization and consistency.
		- Invalid date ranges and orders.
		- Data consistency between related fields.

	Usage Notes:
		- Run these checks after data loading silver layer.
		- Investigate and resolve any discrepencies found during checks.
============================================================================
	*/

-- ============================================================================
-- Checking CRM Tables
-- ============================================================================

-- ============================================================================
-- Checking 'silver.crm_cust_info'
-- ============================================================================
	
-- Check for nulls or duplicates in primary key
-- Expectation: No result
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwated spaces/remove whitespaces
-- Expectation: No Results
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Data Standardization & Consistency
SELECT DISTINCT(cst_marital_status)
FROM silver.crm_cust_info;

-- ============================================================================
-- Checking for 'silver.crm_prd_info'
-- ============================================================================

-- Check for Nulls or Duplicates in primary key
-- Expectation: No Result

SELECT prd_id, COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwated spaces/remove whitespaces
-- Expectation: No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Check for NULLS & Negative numbers
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

-- Check for invalid date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ============================================================================
-- Checking for 'silver.crm_sales_details'
-- ============================================================================

-- check for invalid dates (check for all dates columns)
-- for quality checks: replace broze with silver (FROM bronze.crm_sales_details)
SELECT 
NULLIF(sls_order_dt,0) sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101;

-- ceck for invalid date orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt 
OR sls_order_dt > sls_due_date;

-- check for data consistency: between sales, quantiry and price
-- >> sales = quantity * price
-- values must not be nulls, negative or zero

SELECT DISTINCT 
sls_sales AS old_sls_sales,
sls_quantity, 
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
END AS sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

-- ============================================================================
-- Checking ERP Tables
-- ============================================================================

-- ============================================================================
-- Checking for 'silver.erp__cust_az12'
-- ============================================================================

-- identifying OUT-OF-RANGE DATES
SELECT DISTINCT bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		 ELSE 'n/a'
END gen
FROM silver.erp_cust_az12;

-- ============================================================================
-- Checking for 'silver.erp_loc_a101'
-- ============================================================================

-- Data Standardization & Consistency
SELECT DISTINCT cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE TRIM(cntry)
END cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ============================================================================
-- Checking for 'silver.erp_cust_az12'
-- ============================================================================

-- check for unwanted spaces
SELECT * 
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance);

-- Data standardization & consistency(checke all columns)
SELECT DISTINCT cat
FROM silver.erp_px_cat_g1v2;
