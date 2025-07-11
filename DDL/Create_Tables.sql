USE [InsigniaDW];
GO

-- 📌 LINEAGE TABLE
CREATE TABLE dbo.Dim_Lineage (
    Lineage_Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    Source_System VARCHAR(100),
    Load_StartDatetime DATETIME,
    Load_EndDatetime DATETIME,
    Rows_at_Source INT,
    Rows_at_Destination_Fact INT,
    Load_Status BIT
);

-- 📌 DATE DIMENSION
CREATE TABLE dbo.Dim_Date (
    DateKey INT PRIMARY KEY,
    Date DATE,
    Day_Number INT,
    Month_Name VARCHAR(20),
    Short_Month CHAR(3),
    Calendar_Month_Number INT,
    Calendar_Year INT,
    Fiscal_Month_Number INT,
    Fiscal_Year INT,
    Week_Number INT
);

-- 📌 PRODUCT DIMENSION (SCD1)
CREATE TABLE dbo.Dim_Product (
    Product_Key INT IDENTITY(1,1) PRIMARY KEY,
    Stock_Item_Id INT,
    Stock_Item_Name VARCHAR(255),
    Stock_ItemColor VARCHAR(50),
    Stock_Item_Size VARCHAR(50),
    Item_Size VARCHAR(50),
    Stock_ItemPrice DECIMAL(18,2),
    Lineage_Id BIGINT
);

-- 📌 CUSTOMER DIMENSION (SCD2)
CREATE TABLE dbo.Dim_Customer (
    Customer_Key INT IDENTITY(1,1) PRIMARY KEY,
    Customer_Id INT,
    CustomerName VARCHAR(255),
    CustomerCategory VARCHAR(100),
    CustomerContactName VARCHAR(255),
    CustomerPostalCode VARCHAR(20),
    CustomerContactNumber VARCHAR(20),
    Effective_Start_Date DATETIME,
    Effective_End_Date DATETIME,
    Is_Current BIT,
    Lineage_Id BIGINT
);

-- 📌 EMPLOYEE DIMENSION (SCD2)
CREATE TABLE dbo.Dim_Employee (
    Employee_Key INT IDENTITY(1,1) PRIMARY KEY,
    Employee_Id INT,
    EmployeeFirstName VARCHAR(100),
    EmployeeLastName VARCHAR(100),
    Is_Salesperson BIT,
    Effective_Start_Date DATETIME,
    Effective_End_Date DATETIME,
    Is_Current BIT,
    Lineage_Id BIGINT
);

-- 📌 GEOGRAPHY DIMENSION (SCD3)
CREATE TABLE dbo.Dim_Geography (
    Geography_Key INT IDENTITY(1,1) PRIMARY KEY,
    City_ID INT,
    City VARCHAR(100),
    State_Province VARCHAR(100),
    Country VARCHAR(100),
    Continent VARCHAR(100),
    Sales_Territory VARCHAR(100),
    Region VARCHAR(100),
    Subregion VARCHAR(100),
    Latest_Recorded_Population INT,
    Previous_Recorded_Population INT,
    Lineage_Id BIGINT
);

-- 📌 FACT TABLE
CREATE TABLE dbo.Fact_Sales (
    Sales_Key INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceId INT,
    Quantity INT,
    Unit_Price DECIMAL(18,2),
    Tax_Rate DECIMAL(5,2),
    Total_Excluding_Tax DECIMAL(18,2),
    Tax_Amount DECIMAL(18,2),
    Profit DECIMAL(18,2),
    Total_Including_Tax DECIMAL(18,2),
    Product_Key INT,
    Customer_Key INT,
    Employee_Key INT,
    Geography_Key INT,
    DateKey INT,
    Lineage_Id BIGINT
);

