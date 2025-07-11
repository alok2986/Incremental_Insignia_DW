USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Reconciliation_Check AS
BEGIN
    DECLARE @SourceRows INT = (SELECT COUNT(*) FROM dbo.Insignia_staging_copy);
    DECLARE @FactRows INT = (SELECT COUNT(*) FROM dbo.Fact_Sales);

    INSERT INTO dbo.Dim_Lineage (
        Source_System, Load_StartDatetime, Load_EndDatetime,
        Rows_at_Source, Rows_at_Destination_Fact, Load_Status)
    VALUES (
        'Insignia_Staging',
        GETDATE(),
        GETDATE(),
        @SourceRows,
        @FactRows,
        1
    );
END
GO
