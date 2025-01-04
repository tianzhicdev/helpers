#!/bin/bash

# Set variables
DB_NAME="db"
DATA_DIR="/Volumes/databank/postgres_data"
LOGFILE="/tmp/postgres_setup.log"

# Function to run SQL commands
run_sql() {
    psql -d $DB_NAME -c "$1"
}

# Initialize PostgreSQL data directory
initdb -D $DATA_DIR > $LOGFILE 2>&1

# Start PostgreSQL server
pg_ctl -D $DATA_DIR -l $LOGFILE start

# Wait for the server to start
sleep 5

# Create the database
createdb $DB_NAME

# Create a table
run_sql "CREATE TABLE test_table (id SERIAL PRIMARY KEY, name VARCHAR(50));"

# Insert a record
run_sql "INSERT INTO test_table (name) VALUES ('Test Record');"

# Retrieve the record
run_sql "SELECT * FROM test_table;"

# Stop the PostgreSQL server
pg_ctl -D $DATA_DIR stop

echo "PostgreSQL setup and test completed. Check $LOGFILE for details."

