USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Load_Dim_Customer AS
BEGIN
    INSERT INTO dbo.Dim_Customer (Customer_Id, CustomerName, CustomerCategory,
                                  CustomerContactName, CustomerPostalCode, CustomerContactNumber,
                                  Effective_Start_Date, Effective_End_Date, Is_Current, Lineage_Id)
    SELECT s.Customer_Id, s.CustomerName, s.CustomerCategory,
           s.CustomerContactName, s.CustomerPostalCode, s.CustomerContactNumber,
           GETDATE(), NULL, 1, 1
    FROM dbo.Insignia_staging_copy s
    LEFT JOIN dbo.Dim_Customer d ON s.Customer_Id = d.Customer_Id AND d.Is_Current = 1
    WHERE d.Customer_Id IS NULL;

    UPDATE d
    SET d.Effective_End_Date = GETDATE(), d.Is_Current = 0
    FROM dbo.Dim_Customer d
    JOIN dbo.Insignia_staging_copy s ON s.Customer_Id = d.Customer_Id
    WHERE d.Is_Current = 1
      AND (ISNULL(s.CustomerName,'') <> ISNULL(d.CustomerName,'')
           OR ISNULL(s.CustomerCategory,'') <> ISNULL(d.CustomerCategory,'')
           OR ISNULL(s.CustomerContactName,'') <> ISNULL(d.CustomerContactName,'')
           OR ISNULL(s.CustomerPostalCode,'') <> ISNULL(d.CustomerPostalCode,'')
           OR ISNULL(s.CustomerContactNumber,'') <> ISNULL(d.CustomerContactNumber,''));

    INSERT INTO dbo.Dim_Customer (Customer_Id, CustomerName, CustomerCategory,
                                  CustomerContactName, CustomerPostalCode, CustomerContactNumber,
                                  Effective_Start_Date, Effective_End_Date, Is_Current, Lineage_Id)
    SELECT s.Customer_Id, s.CustomerName, s.CustomerCategory,
           s.CustomerContactName, s.CustomerPostalCode, s.CustomerContactNumber,
           GETDATE(), NULL, 1, 1
    FROM dbo.Insignia_staging_copy s
    JOIN dbo.Dim_Customer d ON s.Customer_Id = d.Customer_Id
    WHERE d.Is_Current = 0;
END
GO
