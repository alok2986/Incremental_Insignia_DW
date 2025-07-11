USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Load_Dim_Employee AS
BEGIN
    -- Insert new employees
    INSERT INTO dbo.Dim_Employee (Employee_Id, EmployeeFirstName, EmployeeLastName, Is_Salesperson,
                                  Effective_Start_Date, Effective_End_Date, Is_Current, Lineage_Id)
    SELECT s.employee_Id, s.EmployeeFirstName, s.EmployeeLastName, s.Is_Salesperson,
           GETDATE(), NULL, 1, 1
    FROM dbo.Insignia_staging_copy s
    LEFT JOIN dbo.Dim_Employee d ON s.employee_Id = d.Employee_Id AND d.Is_Current = 1
    WHERE d.Employee_Id IS NULL;

    -- Close old records if changed
    UPDATE d
    SET d.Effective_End_Date = GETDATE(), d.Is_Current = 0
    FROM dbo.Dim_Employee d
    JOIN dbo.Insignia_staging_copy s ON s.employee_Id = d.Employee_Id
    WHERE d.Is_Current = 1
      AND (ISNULL(s.EmployeeFirstName,'') <> ISNULL(d.EmployeeFirstName,'')
           OR ISNULL(s.EmployeeLastName,'') <> ISNULL(d.EmployeeLastName,'')
           OR ISNULL(s.Is_Salesperson,0) <> ISNULL(d.Is_Salesperson,0));

    -- Insert new version if changed
    INSERT INTO dbo.Dim_Employee (Employee_Id, EmployeeFirstName, EmployeeLastName, Is_Salesperson,
                                  Effective_Start_Date, Effective_End_Date, Is_Current, Lineage_Id)
    SELECT s.employee_Id, s.EmployeeFirstName, s.EmployeeLastName, s.Is_Salesperson,
           GETDATE(), NULL, 1, 1
    FROM dbo.Insignia_staging_copy s
    JOIN dbo.Dim_Employee d ON s.employee_Id = d.Employee_Id
    WHERE d.Is_Current = 0;
END
GO
