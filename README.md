# Atlas Fuel Services BI Assessment

A fictional SQL and Power BI assessment for a Business Intelligence Developer / Business Intelligence Analyst role.

## Business Scenario

Atlas Fuel Services Ltd is a fictional fuel-card and fleet services provider.

The dataset is fictional but commercially realistic and contains customer, transaction, product, network, account manager, customer service case and target data.

## Assessment

Using SQL, explore the database to identify commercially valuable insights.

Export the outputs of your SQL queries and use them to build a concise Power BI report.

Full instructions can be found in:

`assessment/SQL Questions.md`

## SQL Connection

Use the following connection details:

| Setting | Value |
|---|---|
| Server | `localhost,1433` |
| Authentication | `SQL Login` |
| Username | `TFS001` |
| Password | `TFS!Password1!` |
| Database | `InterviewDB` |
| Trust Server Certificate | `Yes` |

## Database

**Database:** `InterviewDB`

**Schema:** `interview`

The dataset contains:

- `interview.Customers`
- `interview.Transactions`
- `interview.Products`
- `interview.Networks`
- `interview.AccountManagers`
- `interview.Cases`
- `interview.Targets`

## Verify the Environment

After connecting, run:

```sql
SELECT COUNT(*) AS TransactionRows
FROM interview.Transactions;