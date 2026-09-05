/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

/*ล้างโครงสร้างตารางเดิมทิ้ง แล้วสร้างตารางว่างๆ ที่มี Schema ชัดเจนขึ้นมาใหม่ เพื่อรอรับข้อมูลดิบชุดใหม่ที่จะ Load เข้าไป โดยไม่ติด Error */
IF OBJECT_ID ('bronze.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

/* CREATE TABLE "Customer Relationship Management การจัดการความสัมพัรธ์กับลูกค้า" */
CREATE TABLE bronze.crm_cust_info(
	cst_id				INT,
	cst_key				NVARCHAR(50),
	cst_firstname		NVARCHAR(50),
	cst_lastname		NVARCHAR(50),
	cst_marital_status	NVARCHAR(50),
	cst_gndr			NVARCHAR(50),
	cst_create_date		NVARCHAR(50)
);

IF OBJECT_ID ('bronze.crm_prd_info' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id			INT,
	prd_key			NVARCHAR(50),
	prd_nm			NVARCHAR(50),
	prd_cost		INT,
	prd_line		NVARCHAR(50),
	prd_start_dt	NVARCHAR(50),
	prd_end_dt		NVARCHAR(50)
);

IF OBJECT_ID ('bronze.crm_sales_details' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num		NVARCHAR(50),
	sls_prd_key		NVARCHAR(50),
	sls_cust_id		INT,
	sls_order_dt	INT,
	sls_ship_dt		INT,
	sls_sue_dt		INT,
	sls_sales		INT,
	sls_quantity	INT,
	sls_price		INT
);
/*=======================================================*/

IF OBJECT_ID ('bronze.erp_cust_az12' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

/* CREATE TABLE "Enterprise Resource Planning การบริหารจัดการทรัพยากรภายในองค์กร" */
CREATE TABLE bronze.erp_cust_az12(
	cid		NVARCHAR(50),
	bdate	NVARCHAR(50),
	gen		NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid		NVARCHAR(50),
	cntry	NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id			NVARCHAR(50),
	cat			NVARCHAR(50),
	subcat		NVARCHAR(50),
	maintenance NVARCHAR(50)
);
