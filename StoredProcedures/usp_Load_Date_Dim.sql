USE [InsigniaDW];
GO

CREATE PROCEDURE usp_Load_Date_Dim AS
BEGIN
    DECLARE @Date DATE = '2000-01-01';
    WHILE @Date <= '2023-12-31'
    BEGIN
        INSERT INTO dbo.Dim_Date (
            DateKey, Date, Day_Number, Month_Name, Short_Month,
            Calendar_Month_Number, Calendar_Year, Fiscal_Month_Number,
            Fiscal_Year, Week_Number
        )
        SELECT
            CONVERT(INT, FORMAT(@Date, 'yyyyMMdd')),
            @Date,
            DAY(@Date),
            DATENAME(MONTH, @Date),
            LEFT(DATENAME(MONTH, @Date), 3),
            MONTH(@Date),
            YEAR(@Date),
            CASE WHEN MONTH(@Date) >= 7 THEN MONTH(@Date) - 6 ELSE MONTH(@Date) + 6 END,
            CASE WHEN MONTH(@Date) >= 7 THEN YEAR(@Date) ELSE YEAR(@Date) - 1 END,
            DATEPART(WEEK, @Date);

        SET @Date = DATEADD(DAY, 1, @Date);
    END
END
GO
