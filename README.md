# Incremental_Insignia_DW
## 🎯 Project: Insignia Data Warehouse & ETL

This repo contains the full SQL implementation for Insignia Corporation's modernized Data Warehouse solution, including:

- 📁 DDL Scripts for Dimensions, Facts, Date Dimension, and Lineage
- ⚙️ Stored Procedures for Staging, Incremental ETL, SCD Type 1, 2, 3 Handling
- ✅ Reconciliation module to track ETL performance

### 📌 Tables Implemented
- **Dim_Product** (SCD1)
- **Dim_Customer** (SCD2)
- **Dim_Employee** (SCD2)
- **Dim_Geography** (SCD3)
- **Dim_Date** (Static, 2000–2023 fiscal logic)
- **Fact_Sales** (Sales fact)
- **Dim_Lineage** (ETL audit)

### ⚡ How to Run
1️⃣ Use `DDL/` scripts to create tables in SQL Server.  
2️⃣ Run `StoredProcedures/` scripts to create ETL flows.  
3️⃣ Execute `usp_Create_StagingCopy` to set up staging.  
4️⃣ Load Date dimension using `usp_Load_Date_Dim`.  
5️⃣ Load each dimension: Customer, Employee, Product, Geography.  
6️⃣ Load Fact using `usp_Load_Fact_Sales`.  
7️⃣ Run `usp_Reconciliation_Check` to audit your load.

### ✅ Notes
- Staging uses `Insignia_staging_copy` as working table.
- SCD2 uses LEFT JOIN + UPDATE (No MERGE).
- Geography population implements SCD3 logic.
- Lineage table logs ETL stats.

📂 **Structure**
```
/DDL
  ├── Create_Tables.sql
/StoredProcedures
  ├── usp_Create_StagingCopy.sql
  ├── usp_Load_Date_Dim.sql
  ├── usp_Load_Dim_Customer.sql
  ├── usp_Load_Dim_Employee.sql
  ├── usp_Load_Dim_Geography.sql
  ├── usp_Load_Fact_Sales.sql
  ├── usp_Reconciliation_Check.sql
