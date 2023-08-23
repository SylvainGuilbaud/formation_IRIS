-- LOAD DATA FROM FILE '/data/kaggle/world/world-data-2023.csv.orig'
-- into world_RM.Record USING {"from":{"file":{"header": true,"skip": 2,"escapechar":"\""", "columnseparator":","}}}


LOAD DATA FROM FILE '/data/personne/test/loaddata_personnes.csv'
into formation_RM_personne.Record (ID,DateNaissance,Nom,Prenom,Sexe)
USING
{
  "from": {
    "file": {
    --    "header": false,
    --    "skip": 2
    --    "charset": "UTF-8"
    --    "escapechar": "\"""
       "columnseparator": ";"
    }
  }
}


-- SELECT TOP 5 * FROM %SQL_Diag.Result ORDER BY createTime DESC

-- SELECT actor,message,severity,sqlcode
-- FROM %SQL_Diag.Message
-- WHERE diagResult = 
--   (SELECT TOP 1 resultId
--   FROM %SQL_Diag.Result
--   ORDER BY resultId DESC)