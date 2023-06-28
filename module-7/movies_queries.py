"""
Benjamin Andrew
27 June 2023
Module 7 Assignment
"""

import mysql.connector
from mysql.connector import errorcode


config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "localhost",
    "database": "movies",
    "raise_on_warnings": True
    }


try:
    db = mysql.connector.connect(**config)
    
    print("\n Database user {} connected to MySQL on host {} with database {}".format(config["user"], config["host"], config["database"]))

    input("\n\n Press any key to continue...")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("  The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")

    else:
        print(err)

#initialize the cursor
cursor = db.cursor()

#Collect data for first Query
cursor.execute("SELECT studio_id, studio_name FROM studio")
studios = cursor.fetchall()

#Collect data for second Query
cursor.execute("SELECT genre_id, genre_name FROM genre")
genres = cursor.fetchall()

#Collect data for Third Query
cursor.execute("SELECT film_name, film_runtime FROM film")
runtimes = cursor.fetchall()

#Collect data for Fourth Query
cursor.execute("SELECT film_name, film_director FROM film ORDER BY film_director ASC")
directors = cursor.fetchall()

#Print data for first Query
print("-- DISPLAYING Studio RECORDS --")
for studio in studios:
    print("Studio ID: {}\nStudio Name: {}\n".format(studio[0], studio[1]))

#Print data for second Query
print("-- DISPLAYING Genre RECORDS --")
for genre in genres:
    print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))
    
#Print data for third Query
print("-- DISPLAYING Short Film RECORDS --")
for film in runtimes:
    if film[1] < 120:
        print("Film Name: {}\nRuntime: {}\n".format(film[0], film[1]))

#Print data for fourth Query
print("-- DISPLAYING Director RECORDS in Order --")
for film in directors:
    print("Film Name: {}\nDirector: {}\n".format(film[0], film[1]))
    
    