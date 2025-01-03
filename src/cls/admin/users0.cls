Class admin.users
{

ClassMethod CreateUsersFromCSV(filePath As %String = "/data/bna/export_chun_OU_dma_usersTXT.csv") As %Status
{
    set namespace = $NAMESPACE
   
    // Ouvrir le fichier CSV
    Set file = ##class(%Library.File).%New(filePath)
    set sc = file.Open("RS")
    If 'sc {
        Write "Erreur lors de l'ouverture du fichier.", !
        return sc
    }

    // Lire le contenu du fichier
    #; Set currentDate = $ZDATETIMEH($ZNOW(), "YYYY-MM-DD HH24:MI:SS")
    #; Set sixMonthsAgo = $ZDATETIMEH($ZDATETIMEADD(currentDate, -6, "M"), "YYYY-MM-DD HH24:MI:SS")
    zn "%SYS"
    While 'file.AtEnd {
        Set line = file.ReadLine()
        #; write line,!
        Set username = $P(line, ",", 13)
        Set email = $P(line, ",", 29)
        Set lastLogin = $P(line, ",", 51)
        Write $i(i),":",username,":",email,":",lastLogin,!
        read a

        // Convertir la date au format requis
        Set lastLoginDate = $ZDATETIMEH(lastLogin,4,,,,,,,,0)
        Write username,":",lastLoginDate,!
        #; // Vérifier si l'utilisateur s'est connecté dans les six derniers mois
        #; If lastLoginDate >= sixMonthsAgo {
        #;     // Créer l'utilisateur dans le namespace %SYS
        #;     Try {
        #;         Set userRoles = "UserRole" // Définir les rôles appropriés ici
        #;         Set password = "DefaultPassword" // Définir un mot de passe par défaut ou le récupérer d'une autre source
        #;         Set fullName = username // Nom complet de l'utilisateur

        #;         // Appel à la méthode Security.Users.Create
        #;         Set status = ##class(Security.Users).Create(username, userRoles, password, fullName, "%SYS", "", "", 1, 1)
        #;         If status '= 1 {
        #;             Write "Échec de la création de l'utilisateur : ", username, " - Statut : ", status, !
        #;         } Else {
        #;             Write "Utilisateur créé : ", username, !
        #;         }
        #;     } Catch ex {
        #;         Write "Erreur lors de la création de l'utilisateur : ", username, " - ", ex.%Message(), !
        #;     }
        #; }
    }

   zn namespace
   return $$$OK
}

}
