#!/usr/bin/env bash
set -e

echo "Starting SQL Server container..."

docker rm -f bi-interview-sql 2>/dev/null || true

docker run \
  -e ACCEPT_EULA=Y \
  -e MSSQL_SA_PASSWORD='TFS!Password1!' \
  -e MSSQL_PID=Developer \
  -p 1433:1433 \
  --name bi-interview-sql \
  -d mcr.microsoft.com/mssql/server:2022-latest

echo "Waiting for SQL Server..."
sleep 45

echo "Copying data and scripts..."
docker cp data/. bi-interview-sql:/var/opt/mssql/data/
docker cp database/. bi-interview-sql:/var/opt/mssql/data/

echo "Creating and loading database..."
docker exec bi-interview-sql /opt/mssql-tools18/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P 'TFS!Password1!' \
  -C \
  -i /var/opt/mssql/data/01_CreateTables.sql

docker exec bi-interview-sql /opt/mssql-tools18/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P 'TFS!Password1!' \
  -C \
  -i /var/opt/mssql/data/02_LoadData.sql

echo "Creating read-only interview user..."
docker exec bi-interview-sql /opt/mssql-tools18/bin/sqlcmd \
  -S localhost \
  -U sa \
  -P 'TFS!Password1!' \
  -C \
  -Q "
USE master;
IF NOT EXISTS (SELECT 1 FROM sys.sql_logins WHERE name = 'TFS001')
BEGIN
    CREATE LOGIN TFS001 WITH PASSWORD = 'TFS!Password1!';
END;

USE InterviewDB;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'TFS001')
BEGIN
    CREATE USER TFS001 FOR LOGIN TFS001;
END;

ALTER ROLE db_datareader ADD MEMBER TFS001;
"

echo "Database ready. Candidate login: TFS001 / TFS!Password1!"
