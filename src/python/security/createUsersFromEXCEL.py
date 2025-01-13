import iris
import sys
import pandas as pd
from datetime import datetime, timedelta
 
def main():
  connection_string = "localhost:1972/USER"
  username = "_SYSTEM"
  # password = "admin"
  password = "SYS"
  
  # Ouvrir un fichier en mode écriture
  log_file = open('createUsers.log', 'w')
 
  # Charger le fichier Excel
  directory = input('set directory [/tmp] :') or "/tmp"
 
  # Rediriger la sortie standard vers le fichier
  sys.stdout = log_file
 
  # Obtenir la date et l'heure actuelles
  maintenant = datetime.now()
 
  # Formater la date et l'heure
  format_francais = maintenant.strftime("%d/%m/%Y %H:%M:%S")
 
  print(f"Debut du traitement 'createUsers' - {format_francais}")
 
  connection = iris.connect(connection_string, username, password)
  # print(connection)
  irispy = iris.createIRIS(connection)
  # print(irispy)
 
  file_path = directory + '/export_chun_OU_dma_usersEXCEL.xlsx'
  df = pd.read_excel(file_path)
 
  print(f"Nombre d'utilisateur provenant du fichier d'entrée : {len(df)}")
 
  # Filtrer les utilisateurs connectés dans les 6 derniers mois
  six_months_ago = datetime.now() - timedelta(days=180)
  df['LastLogonDate'] = pd.to_datetime(df['LastLogonDate'], format='%d/%m/%y %H:%M')
  filtered_users = df[df['LastLogonDate'] >= six_months_ago]
 
  print(f"Nombre d'utilisateur à créer après le filtre des 6 mois : {len(df)}")
 
  # Créer des utilisateurs dans InterSystems IRIS
  for index, row in filtered_users.iterrows():
      username = row['CN']
      roles = row['intersystemsRoles']  # Assurez-vous que les rôles sont au format correct
      email = row['EmailAddress']
      fullName = row['sn']
      # nameSpace = "DMA2"
      expirationDate = datetime.now() + timedelta(days=365)
      expirationDate = expirationDate.strftime("%Y-%m-%d")
      print(f"{username}:{fullName}:{expirationDate}:{email}")
      
      # Appel à la méthode de création d'utilisateur
      try:
          status = irispy.classMethodString('admin.security','createUser',username,'connectAD,dmaRUtilStd','password', fullName, 'DMA2', expirationDate, email)
          print(f"Utilisateur {username} créé avec succès : {status}")
      except Exception as e:
          print(f"Erreur lors de la création de l'utilisateur {username}: {e}")
 
  format_francais = maintenant.strftime("%d/%m/%Y %H:%M:%S")
  print(f"Fin du traitement 'createUsers' -  {format_francais}")   
  
  # Fermer le fichier
  log_file.close()
 
if __name__ == "__main__":
  main()