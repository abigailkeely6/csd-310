import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "root",
    "password": "Lilly.0928",
    "host": "127.0.0.1",
    "database": "pysports",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    print("\n Database user {} connected to MySQL on host {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")
    else:
        print(err)

cursor = db.cursor()

print("-- DISPLAYING TEAM RECORDS --")
cursor.execute("SELECT team_id, team_name, mascot FROM team;")
teams = cursor.fetchall()
for team in teams:
    print("\n Team ID: {}\n Team Name: {}\n Mascot: {}\n".format(team[0], team[1], team[2]))
    print()
    print()

print("-- DISPLAYING PLAYER RECORDS --")
cursor.execute("SELECT player_id, first_name, last_name, team_id FROM player")
players = cursor.fetchall()
for player in players:
    print("\n Player ID: {}\n First Name: {}\n Team ID: {}\n".format(player[0], player[1], player[2], player[3]))
    print()
    print()

input("\n\nPress any key to continue...")
db.close
