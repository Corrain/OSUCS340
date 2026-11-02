""" CS340 Python CRUD Assignment Template File
-- Name: Carl Curran
-- Citation for the following code: (Explain degree of originality, e.g. "Code provided from CS340 @ OSU", and a summary of the prompts submitted to the AI tool. If original, just say "Original work, no AI tools were used.")

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

        
        # TODO: check mode (byp or byc)
        if mode == "byp":
            mode_select = "byp" 
        else:
            mode_select = "byc"

        # TODO: write and execute JOIN query for byp

        if mode_select == "byp":
            query = """
                SELECT bsg_people.fname, bsg_people.lname, bsg_cert.title
                FROM bsg_people
                JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                JOIN bsg_certs ON bsg_cert_people.cid = bsg_certs.id
                GROUPBY bsg_people.fname
                ORDER BY bsg_people.fname;
            """
        # TODO: write and execute JOIN query for byc
        else:
            query = """
                SELECT bsg_certs.cert, bsg_people.fname, bsg_people.lname
                FROM bsg_people
                JOIN bsg_cert_people ON bsg_people.id = bsg_cert_people.pid
                JOIN bsg_certs ON bsg_cert_people.cid = bsg_certs.id
                GROUPBY bsg_certs.title
                ORDER BY bsg_certs.cert;
            """
        # TODO: return results

        pass

    def cnt_cert_person(self, mode="byc"):
        """
        Count certifications grouped by person (byp) -output *fname, lname, count
        Or count people grouped by certificate (byc) -output *cert, count
        Default is byc. *Orderby.
        """
        # TODO: if mode == "byp", GROUP BY person
        # TODO: else, GROUP BY cert
        # TODO: execute and return results
        
    def add_cert_person(self, c=None, p=None):
        """Insert cert-person pair into bsg_cert_people."""
        # TODO: INSERT INTO bsg_cert_people (cid, pid)
        # TODO: handle mysql.connector.Error duplicate (errno 1062)
        # TODO: commit and return rowcount or duplicate error text
        pass

    def update_cert(self, c=None, p=None):
        """
        Update the cert assignment for a given person.
        """
        # TODO: UPDATE bsg_cert_people SET cid=%s WHERE ...
        # TODO: commit and return rowcount
        pass

    def delete_cert(self, c=None, p=None):
        """Delete one cert-person relationship."""
        # TODO: DELETE FROM bsg_cert_people WHERE cid=%s AND pid=%s
        # TODO: commit and return rowcount
        pass
