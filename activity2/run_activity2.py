import mysql.connector
from activity2 import Activity2Queries

# Connect to the database (update credentials!)
conn = mysql.connector.connect(
	host='localhost',
	user='root',
	password='',
	database='cs340_curracar'
)
cursor = conn.cursor()

# Create the class instance
queries = Activity2Queries(cursor)

# Call make_diag_table
print('Calling make_diag_table()...')
queries.make_diag_table()
print('Table created.')

# Call insert_diagnostic
print('Calling insert_diagnostic()...')
rowcount = queries.insert_diagnostic()
conn.commit()
print(f'Rows inserted: {rowcount}')

# Call select_diagnostic and print the result
print('Calling select_diagnostic()...')
result = queries.select_diagnostic()
print('Select result:')
print(result)

# Clean up
cursor.close()
conn.close()