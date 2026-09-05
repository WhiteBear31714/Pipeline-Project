/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

/*"สร้างใหม่ หรือ แก้ไข ของเดิมที่มีอยู่แล้ว"*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    /*ใช้เก็บ "เวลาเริ่มต้น" และ "เวลาสิ้นสุด":*/
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME ;
    BEGIN TRY/*กำหนดให้ทำในส่วนนี้ก่อน หากมีการผิดพลาดจากข้อมูล จะโยนไปให้"BEGIN CATCH" */
        SET @batch_start_time = GETDATE();
        PRINT '======================================';
        PRINT 'Loading Bronze Layer';
        PRINT '======================================';

        PRINT '--------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '--------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.crm_cust_info';
        /*TRUNCATE TABLE TRUNCATE TABLE มีไว้เพื่อ "ลบข้อมูลทั้งหมดในตารางทิ้ง" ก่อนจะนำข้อมูลใหม่เข้ามา (Full Load) เพื่อป้องกันปัญหา Duplicates  */
        TRUNCATE TABLE bronze.crm_cust_info; 

        PRINT '>>> :Inserting Data Into: bronze.crm_cust_info';
        /*BULK INSERT ดึงข้อมูลมาทั้งชุดแบบยกมาเลย ทำให้โหลดไวขึ้น*/
        BULK INSERT bronze.crm_cust_info 
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );/*01*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.crm_cust_info';
        PRINT '>>> Trncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info
        PRINT '>>> :Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );/*02*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details
        PRINT '>>> :Inserting Data Into: crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );/*03*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

  
        PRINT '--------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '--------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12
        PRINT '>>> Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );/*04*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101
        PRINT '>>> Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );/*05*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

        SET @start_time = GETDATE();
        PRINT '>>> Trncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2
        PRINT '>>> Trncating Table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Lenovo\Desktop\vscode\Pipeline Project\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );/*06*/
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '----------------------------'

        SET @batch_end_time = GETDATE();
        PRINT '========================================='
        PRINT 'Loading Bronze Layer is Completed';
        PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' secounds';
        PRINT '========================================='
    END TRY

    BEGIN CATCH /*บล็อกนี้จะทำงานเมื่อเกิด Error ในส่วน BEGIN TRY มีไว้เพื่อ "จับข้อผิดพลาด"*/
        PRINT '======================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message' + ERROR_MESSAGE(); /*ดึง ข้อความอธิบายความผิดพลาด*/
        PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR); /*ดึง รหัสหมายเลข Error*/
        PRINT 'Error State' + CAST (ERROR_STATE() AS NVARCHAR); /*ดึง สถานะภายในของ Error (เช่น State 1) มาแปลงเป็นข้อความ (CAST) เพื่อช่วยวิเคราะห์จุดเกิดปัญหา  */
        PRINT '======================================';
    END CATCH
END
