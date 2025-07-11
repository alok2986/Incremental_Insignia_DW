USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Load_Dim_Geography AS
BEGIN
    -- Insert new cities
    INSERT INTO dbo.Dim_Geography (
        City_ID, City, State_Province, Country, Continent,
        Sales_Territory, Region, Subregion,
        Latest_Recorded_Population, Previous_Recorded_Population, Lineage_Id)
    SELECT s.City_ID, s.City, s.State_Province, s.Country, s.Continent,
           s.Sales_Territory, s.Region, s.Subregion,
           s.Latest_Recorded_Population, NULL, 1
    FROM dbo.Insignia_staging_copy s
    LEFT JOIN dbo.Dim_Geography d ON s.City_ID = d.City_ID
    WHERE d.City_ID IS NULL;

    -- Update population change (SCD3)
    UPDATE d
    SET d.Previous_Recorded_Population = d.Latest_Recorded_Population,
        d.Latest_Recorded_Population = s.Latest_Recorded_Population
    FROM dbo.Dim_Geography d
    JOIN dbo.Insignia_staging_copy s ON s.City_ID = d.City_ID
    WHERE ISNULL(d.Latest_Recorded_Population, 0) <> ISNULL(s.Latest_Recorded_Population, 0);
END
GO
