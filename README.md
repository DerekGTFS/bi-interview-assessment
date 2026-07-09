# BI Interview Assessment

A fictional SQL and Power BI assessment for a Business Intelligence Developer / Business Intelligence Analyst role.

---

## Business Scenario

Atlas Fuel Services Ltd is a fictional fuel-card and fleet services provider.

The dataset is fictional but commercially realistic and contains customer, transaction, product, network, account manager, customer service case and target data.

---

## Assessment

Using SQL, explore the database to identify commercially valuable insights.

Export the outputs of your SQL queries and use them to build a concise Power BI report.

Full instructions can be found in:

`assessment/SQL Questions.md`

---

## Database

**Database:** `InterviewDB`

**Schema:** `interview`

The primary transactional table is:

`interview.Transactions`

The dataset also contains Customers, Products, Networks, Account Managers, Customer Service Cases and Sales Targets.

---

## Local / Codespaces Setup

The repository includes a Dev Container configuration that automatically provisions SQL Server.

Default SQL Login

- **Server:** localhost
- **User:** sa
- **Password:** YourStrong!Passw0rd
- **Database:** InterviewDB

Once connected, execute:

1. `database/01_CreateTables.sql`
2. `database/02_LoadData.sql`