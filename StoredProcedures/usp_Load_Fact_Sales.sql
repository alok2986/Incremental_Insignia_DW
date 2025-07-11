USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Load_Fact_Sales AS
BEGIN
    INSERT INTO dbo.Fact_Sales (
        InvoiceId, Quantity, Unit_Price, Tax_Rate,
        Total_Excluding_Tax, Tax_Amount, Profit, Total_Including_Tax,
        Product_Key, Customer_Key, Employee_Key, Geography_Key, DateKey, Lineage_Id)
    SELECT
        s.InvoiceId,
        s.Quantity,
        s.Unit_Price,
        s.Tax_Rate,
        s.Total_Excluding_Tax,
        s.Tax_Amount,
        s.Profit,
        s.Total_Including_Tax,
        p.Product_Key,
        c.Customer_Key,
        e.Employee_Key,
        g.Geography_Key,
        CONVERT(INT, FORMAT(GETDATE(), 'yyyyMMdd')) AS DateKey,
        1 AS Lineage_Id
    FROM dbo.Insignia_staging_copy s
    JOIN dbo.Dim_Product p ON s.Stock_Item_Id = p.Stock_Item_Id
    JOIN dbo.Dim_Customer c ON s.Customer_Id = c.Customer_Id AND c.Is_Current = 1
    JOIN dbo.Dim_Employee e ON s.employee_Id = e.Employee_Id AND e.Is_Current = 1
    JOIN dbo.Dim_Geography g ON s.City_ID = g.City_ID;
END
GO
