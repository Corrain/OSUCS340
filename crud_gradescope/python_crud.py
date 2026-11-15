""" CS340 Python CRUD Assignment Template File
-- Name: Carl Curran
-- Citation for the following code: (Explain degree of originality, e.g. "Code provided from CS340 @ OSU", and a summary of the prompts submitted to the AI tool. If original, just say "Original work, no AI tools were used.")

--Original work, no AI tools were used.

-- Your code goes below here
"""


import mysql.connector


class CertPersonQueries(object):
    """Python app that queries people/cert relationships in bsg_db."""

    def __init__(self, cursor, connection=None):
        self.cursor = cursor
        self.connection = connection

    def _commit(self):
        """Commit if a connection object was provided."""
        if self.connection is not None:
            self.connection.commit()

    def get_all_people_cert(self, mode="byc"):
        """
        Join people fname, lname with certs through bsg_cert_people.
        If mode is by person (byp): output columns are (*fname, lname, cert).
        If mode is by cert (byc): output columns are (cert*, fname, lname).
        Default is byc. *Orderby.
        """

        # check mode (byp or byc)
        if mode == "byp":
            mode_select = "byp" 
        else:
            mode_select = "byc"

        # write and execute JOIN query for byp
        if mode_select == "byp":
            sql = """
                SELECT bsg_people.fname, bsg_people.lname, bsg_cert.title AS 'cert title'
                FROM bsg_people
                JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
                ORDER BY bsg_people.fname;
            """

        # write and execute JOIN query for byc
        else:
            sql = """
                SELECT bsg_cert.title AS 'cert title', bsg_people.fname, bsg_people.lname
                FROM bsg_people
                JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
                ORDER BY bsg_cert.title;
            """

        # return results
        self.cursor.execute(sql)
        return self.cursor.fetchall()

    def cnt_cert_person(self, mode="byc"):
        """
        Count certifications grouped by person (byp) -output *fname, lname, count
        Or count people grouped by certificate (byc) -output *cert, count
        Default is byc. *Orderby.
        """
        # GROUP BY person
        if mode == 'byp':
            sql = """
                SELECT bsg_people.fname, bsg_people.lname, COUNT(bsg_cert.title) AS count
                FROM bsg_people
                LEFT JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                LEFT JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
                GROUP BY bsg_people.id
                ORDER BY bsg_people.fname;
            """
        # GROUP BY cert
        else:
            sql = """
                SELECT bsg_cert.title, COUNT(bsg_cert.title) AS count
                FROM bsg_people
                JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
                GROUP BY bsg_cert.title
                ORDER BY bsg_cert.title;
            """

        # execute and return results
        self.cursor.execute(sql)
        return self.cursor.fetchall()
        
    def add_cert_person(self, c=None, p=None):
        """Insert cert-person pair into bsg_cert_people."""

        # TODO: INSERT INTO bsg_cert_people (cid, pid)
        sql = """
            INSERT INTO bsg_cert_people (cid, pid)
            VALUES (%s, %s);
            """

        # handle mysql.connector.Error duplicate (errno 1062)
        try:
            self.cursor.execute(sql, (c, p))
            return self.cursor.rowcount
        except mysql.connector.Error as err:
            if err.errno == 1062:
                return err.msg
            raise

        # TODO: commit and return rowcount or duplicate error text

    def update_cert(self, c=None, p=None):
        """
        Update the cert assignment for a given person.
        """

        # UPDATE bsg_cert_people SET cid=%s WHERE ...
        sql = """
            UPDATE bsg_cert_people
            SET cid = %s WHERE pid = %s;
            """
        try:
            self.cursor.execute(sql, (c, p))

        # commit and return rowcount
            self._commit()
            return self.cursor.rowcount
        except mysql.connector.Error as err:
            if err.errno == 1062:
                return err.msg
            raise

    def delete_cert(self, c=None, p=None):
        """Delete one cert-person relationship."""
        # TODO: DELETE FROM bsg_cert_people WHERE cid=%s AND pid=%s
        sql = """
            DELETE FROM bsg_cert_people WHERE cid=%s AND pid=%s;
            """
        # TODO: commit and return rowcount
        self.cursor.execute(sql, (c, p))
        self._commit()
        return self.cursor.rowcount
        
