Class mysql.admin
{

/// Description
ClassMethod DDL() As %Status [ Language = python ]
{
    import mysql.connector
    from mysql.connector import errorcode

    config = {
    'user': 'formation',
    'password': 'formation',
    'host': '127.0.0.1',
    'database': 'formation',
    'raise_on_warnings': True
    }

    try:
    #; cnx = mysql.connector.connect(user='root',
    #;                                 database='mysql')
        cnx = mysql.connector.connect(**config)
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
    else:
        cnx.close()
}

}
