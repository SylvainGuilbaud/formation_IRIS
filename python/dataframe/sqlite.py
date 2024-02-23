import sqlite3
import pandas as pd

conn = sqlite3.connect('test_database') 
c = conn.cursor()

c.execute('''
          DROP TABLE products
          ''')
c.execute('''
          CREATE TABLE IF NOT EXISTS products
          ([product_id] INTEGER PRIMARY KEY, [product_name] TEXT, [price] INTEGER)
          ''')
          
c.execute('''
          INSERT INTO products (product_id, product_name, price)
                VALUES
                (1,'Computer',800),
                (2,'Printer',200),
                (3,'Tablet',300),
                (4,'Desk',450),
                (5,'Chair',150)
          ''')                     

conn.commit()
c.execute('select * from products')
# result=c.fetchall()
# print(result)


# conn = sqlite3.connect('test_database') 
          
# sql_query = pd.read_sql_query ('''
#                                SELECT
#                                *
#                                FROM products
#                                ''', conn)

df = pd.DataFrame(c.fetchall(), columns = ['product_id', 'product_name', 'price'])
print (df)
max_price = df['price'].max()
print (max_price)