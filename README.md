# BI Interview Assessment

Fictional SQL assessment for a BI Developer / BI Analyst interview.

## Business

Atlas Fuel Services Ltd is a fictional fuel-card and fleet services provider.

The dataset is fake but commercially realistic. It contains customer, transaction, product, network, account manager, case and target data.

## Candidate task

Open the SQL scripts and answer the questions in:

`assessment/SQL Questions.md`

## Database

Schema: `interview`

Main view:

`interview.vwCommercialSales`

## Local / Codespaces setup

The repo includes a Dev Container configuration for SQL Server.

Default SQL login:

- Server: localhost
- User: sa
- Password: YourStrong!Passw0rd
- Database: InterviewDB

Run:

1. `database/01_CreateTables.sql`
2. `database/02_LoadData.sql`