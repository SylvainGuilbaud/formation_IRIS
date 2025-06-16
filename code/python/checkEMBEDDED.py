
import iris

def main(): 
    try:
        connection_string = "localhost:1972/SC"
        username = "_system"
        password = "SYS"

        connection = iris.connect(connection_string, username, password)
        print("Successfully connected to IRIS database")
        
        cursor = connection.cursor()

        print("Cursor created successfully")
        
        cursor.execute("SELECT count(*) FROM SC_Data.salesorder")  
        print("SQL command executed successfully")  
        result = cursor.fetchone()
        print("Number of records in salesorder table:", result[0])
        print("Connection successful")
        
        ## prompt for user input for a table name to query the number of records
        user_input = input("Enter a table name to query the number of records or type 'exit' to quit TABLE: ")
        while user_input.lower() != "exit":
            cursor.execute(f"SELECT count(*) FROM SC_Data.{user_input}")
            result = cursor.fetchone()
            print(f"Number of records in {user_input} table:", result[0])
            user_input = input("Enter a table name to query the number of records or type 'exit' to quit TABLE: ")        
        
        
    except Exception as ex:
        print(ex)
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

if __name__ == "__main__":
  main()