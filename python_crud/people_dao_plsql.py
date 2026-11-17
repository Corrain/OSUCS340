class PeopleDAO:
    """
    Data Access Object (DAO) for the bsg_people table.
    """

    def __init__(self, db_connection):
        self.db = db_connection

    def get_all_people(self):
        cursor = self.db.cursor(dictionary=True)
        sql = """
        SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age
        FROM bsg_people
        INNER JOIN bsg_planets ON bsg_people.homeworld = bsg_planets.id
        """
        cursor.execute(sql)
        results = cursor.fetchall()
        cursor.close()
        return results

    def add_person(self, fname, lname, homeworld_id, age):
        cursor = self.db.cursor()
        sql = "CALL sp_CreatePerson(%s, %s, %s, %s, @new_id)"
        cursor.execute(sql, (fname, lname, homeworld_id, age))
        # The procedure may leave one or more pending result sets on the cursor.
        # Drain them before issuing the next statement or the connector will raise an error.
        while cursor.nextset():
            pass

        # The OUT parameter @new_id was set inside the procedure.
        # We must retrieve it via a separate SELECT because OUT params are not
        # returned as a result set; they are stored as session-level
        cursor.execute("SELECT @new_id")
        new_id = cursor.fetchone()[0]

        self.db.commit()
        cursor.close()
        return 1 if new_id else 0

    def update_person(self, person_id, fname, lname, homeworld_id, age):
        cursor = self.db.cursor()
        sql = "CALL sp_UpdatePerson(%s, %s, %s, %s, %s)"
        cursor.execute(sql, (person_id, fname, lname, homeworld_id, age))
        # rowcount reflects the number of rows affected by the UPDATE inside the procedure.
        rowcount = cursor.rowcount

        self.db.commit()
        cursor.close()
        return rowcount

    def delete_person(self, person_id):
        cursor = self.db.cursor()
        sql = "CALL sp_DeletePerson(%s)"
        cursor.execute(sql, (person_id,))
        # rowcount reflects the rows deleted by the final DELETE inside the procedure.
        # The procedure raises a SQLSTATE error if no matching id exists.
        rowcount = cursor.rowcount

        self.db.commit()
        cursor.close()
        return rowcount

    def get_all_planets(self):
        cursor = self.db.cursor(dictionary=True)
        sql = "SELECT id, name FROM bsg_planets order by id;"
        cursor.execute(sql)
        results = cursor.fetchall()
        cursor.close()
        return results

    def reset_database(self):
        cursor = self.db.cursor()
        sql = "CALL sp_ResetBSGDatabase()"
        cursor.execute(sql)

        while cursor.nextset():
            pass
        # The reset procedure issues DDL (DROP/CREATE) and DML (INSERT) statements.
        # Commit ensures all DML changes persisted.
        self.db.commit()
        cursor.close()
        # Return 1 to signal success; the reset either completes fully or raises an exception.
        return 1


    