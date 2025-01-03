
import pandas as pd
from datetime import datetime, timedelta
import iris

def main():
  connection_string = "localhost:1972/IRISAPP"
  username = "_system"
  password = "SYS"

  connection = iris.connect(connection_string, username, password)
  # print(connection)
  irispy = iris.createIRIS(connection)
  # print(irispy)
  
  # Charger le fichier Excel
  directory = input('set directory [/tmp] :') or "/tmp"

  file_path = directory + '/export_chun_OU_dma_usersEXCEL.xlsx'
  df = pd.read_excel(file_path)

  # Filtrer les utilisateurs connectés dans les 6 derniers mois
  six_months_ago = datetime.now() - timedelta(days=180)
  df['LastLogonDate'] = pd.to_datetime(df['LastLogonDate'], format='%d/%m/%y %H:%M')
  filtered_users = df[df['LastLogonDate'] >= six_months_ago]

  # Créer des utilisateurs dans InterSystems IRIS
  for index, row in filtered_users.iterrows():
      username = row['CN']
      roles = row['intersystemsRoles']  # Assurez-vous que les rôles sont au format correct
      email = row['EmailAddress']
      
      # Appel à la méthode de création d'utilisateur
      try:
          status = irispy.classMethodString('admin.security','createUser',username,'connectBNA','password',email)
          if status:
            print(f"Utilisateur {username} créé avec succès : {status}")
          else:
            print(f"Erreur lors de la création de l'utilisateur {username}: {status}")
      except Exception as e:
          print(f"Erreur lors de la création de l'utilisateur {username}: {e}")

if __name__ == "__main__":
  main()