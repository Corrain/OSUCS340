""" CS340 Activity 2 Template File

-- Citation for the following code: (Explain degree of originality, e.g. "Code provided from CS340 @ OSU", 
-- and a summary of the prompts submitted to the AI tool. If original, just say "Original work, no AI tools were used.")

Used claude to ensure my VS code installation was operating correctly on the linux machine i am using
-- Your code goes below here
"""

import mysql.connector

class Activity2Queries(object):
    """Python app that uses SQL queries to create a diagnostic table,
    populate it with your username, then select the results."""

    def __init__(self, cursor):
        self.cursor = cursor

    def myONID(self):
        # TODO: replace with your actual ONID, e.g., "currym"
        return "curracar"

    def make_diag_table(self):
        drop_query = "DROP TABLE IF EXISTS diagnostic;"
        create_query = (
            "CREATE TABLE diagnostic("
            "id INT PRIMARY KEY AUTO_INCREMENT,"
            " text VARCHAR(255) NOT NULL);"
        )
        self.cursor.execute(drop_query)
        self.cursor.execute(create_query)
        # no explicit return required

    def insert_diagnostic(self):
        msg = f"MySQL and Python is working for {self.myONID()}!"
        insert_query = (
            "INSERT INTO diagnostic (text) VALUES (%s);"
        )

        try:
            self.cursor.execute(insert_query, (msg,))
            return getattr(self.cursor, 'rowcount', None)
        except TypeError:

            self.cursor.execute(f"INSERT INTO diagnostic (text) VALUES ('{msg}');")
            return getattr(self.cursor, 'rowcount', None)

    def select_diagnostic(self):
        self.cursor.execute("SELECT * FROM diagnostic;")
        rows = self.cursor.fetchall()
        return "MySQL Results: " + str(rows)