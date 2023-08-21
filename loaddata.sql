LOAD DATA FROM FILE '/data/kaggle/world/world-data-2023.csv.orig'
into world_RM.Record USING {"from":{"file":{"header": true,"skip": 2,"escapechar":"\""", "columnseparator":","}}}