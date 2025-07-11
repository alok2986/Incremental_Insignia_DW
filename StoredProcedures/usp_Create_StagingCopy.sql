USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Create_StagingCopy AS
BEGIN
    IF OBJECT_ID('dbo.Insignia_staging_copy') IS NOT NULL
        TRUNCATE TABLE dbo.Insignia_staging_copy;
    ELSE
        SELECT * INTO dbo.Insignia_staging_copy FROM dbo.Insignia_staging WHERE 1 = 0;
END
GO
