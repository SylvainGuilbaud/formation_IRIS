Class admin.users Extends %RegisteredObject
{

ClassMethod CreateUsersFromCSV(filePath As %String = "/tmp/export_chun_OU_dma_usersTXT.txt") [ Language = python ]
{
import pandas as pd
from datetime import datetime, timedelta
import iris

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
    full_name = row['EmailAddress']
    
    # Appel à la méthode de création d'utilisateur
    try:
        # classmethod Create(
            # Username As %String, 
            # UserRoles As %String, 
            # Password As %String,
            # FullName As %String, 
            # NameSpace As %String, 
            # Routine As %String, 
            # ExpirationDate As %String, 
            # ChangePassword As %Boolean, 
            # Enabled As %Boolean, 
            # Comment As %String, 
            # Flags As %String = 1, 
            # PhoneNumber As %String, 
            # PhoneProvider As %String, 
            # ByRef Attributes As %String, 
            # AccountNeverExpires As %Boolean, 
            # PasswordNeverExpires As %Boolean, 
            # PasswordHashAlgorithm As %String, 
            # PasswordHashWorkFactor As %Integer, 
            # EscalationRoles As %String) as %Status
        status = iris.cls('Security.Users').Create(
            username,
            roles,
            'password',
            'USER','','',
            True,
            True
        )
        print(f"Utilisateur {username} créé avec succès : {status}")
    except Exception as e:
        print(f"Erreur lors de la création de l'utilisateur {username}: {e}")
}

}
