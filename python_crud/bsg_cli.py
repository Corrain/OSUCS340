from people_dao import PeopleDAO
import mysql.connector

def display_planets(dao):
 planets = dao.get_all_planets()
 print("\nAvailable Homeworlds:")
 for planet in planets:
 print(f"{planet['id']}: {planet['name']}")

def print_menu():
 print("\nBattlestar Galactica People Database")
 print("1. View all people")
 print("2. Add a person")
 print("3. Update a person")
 print("4. Delete a person")
 print("5. View all planets")
 print("0. Exit")

def main():
 db = mysql.connector.connect(
 host="localhost",
 user="root",
 password="",
 database="bsg_db"
 )

 dao = PeopleDAO(db)

 while True:
 print_menu()
 choice = input("Choose an option: ")

 if choice == "1":
 people = dao.get_all_people()
 for p in people:
 print(p)

 elif choice == "2":
 fname = input("First name: ")
 lname = input("Last name: ")
 display_planets(dao)
 homeworld = int(input("Enter homeworld ID from the list above: "))
 age = input("Age (or press Enter for NULL): ")
 age = int(age) if age else None
 rowcount = dao.add_person(fname, lname, homeworld, age)
 print(f"{rowcount} row(s) affected.")

 elif choice == "3":
 pid = int(input("Person ID to update: "))
 fname = input("First name: ")
 lname = input("Last name: ")
 display_planets(dao)
 homeworld = int(input("Enter homeworld ID from the list above: "))

 age = input("Age (or press Enter for NULL): ")
 age = int(age) if age else None
 rowcount = dao.update_person(pid, fname, lname, homeworld, age)
 print(f"{rowcount} row(s) affected.")

 elif choice == "4":
 pid = int(input("Person ID to delete: "))
 rowcount = dao.delete_person(pid)
 print(f"{rowcount} row(s) affected.")

 elif choice == "5":
 planets = dao.get_all_planets()
 for p in planets:
 print(p)

 elif choice == "0":
 break

 else:
 print("Invalid option.")

 db.close()

if __name__ == "__main__":
 main()