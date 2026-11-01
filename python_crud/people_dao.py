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
 sql = """
 INSERT INTO bsg_people (fname, lname, homeworld, age)
 VALUES (%s, %s, %s, %s)
 """
 cursor.execute(sql, (fname, lname, homeworld_id, age))
 self.db.commit()
 rowcount = cursor.rowcount
 cursor.close()
 return rowcount

 def update_person(self, person_id, fname, lname, homeworld_id, age):
 cursor = self.db.cursor()
 sql = """
 UPDATE bsg_people
 SET fname=%s, lname=%s, homeworld=%s, age=%s
 WHERE id=%s
 """
 cursor.execute(sql, (fname, lname, homeworld_id, age, person_id))
 self.db.commit()
 rowcount = cursor.rowcount
 cursor.close()
 return rowcount

 def delete_person(self, person_id):
 cursor = self.db.cursor()
 sql = "DELETE FROM bsg_people WHERE id=%s"
 cursor.execute(sql, (person_id,))
 self.db.commit()
 rowcount = cursor.rowcount
 cursor.close()
 return rowcount

 def get_all_planets(self):
 cursor = self.db.cursor(dictionary=True)
 sql = "SELECT id, name FROM bsg_planets order by id;"
 cursor.execute(sql)
 results = cursor.fetchall()
 cursor.close()
 return results