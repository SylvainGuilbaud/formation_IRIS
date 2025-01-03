import iris
import pandas as pd
from datetime import datetime, timedelta

def main():
  connection_string = "localhost:1972/%SYS"
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
  six_months_ago = datetime.now() - timedelta(days=18000)
  df['LastLogonDate'] = pd.to_datetime(df['LastLogonDate'], format='%d/%m/%y %H:%M')
  filtered_users = df[df['LastLogonDate'] >= six_months_ago]

  # Créer des utilisateurs dans InterSystems IRIS
  for index, row in filtered_users.iterrows():
      username = row['CN']
      roles = row['intersystemsRoles']  # Assurez-vous que les rôles sont au format correct
      email = row['EmailAddress']
      
      # Appel à la méthode de création d'utilisateur
      try:
          if irispy.classMethodBoolean('Security.Users','Exists',username):
            status = irispy.classMethodString('Security.Users','Delete',username)
            print(f"Utilisateur {username} supprimé avec succès : {status}")
          else:
            print(f"{username} n'existe pas")
      except Exception as e:
          print(f"Erreur lors de la suppression de l'utilisateur {username}: {e}")

if __name__ == "__main__":
  main()