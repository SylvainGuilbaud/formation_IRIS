-- SELECT TOP 3 Name,
-- JSON_ARRAY(%ID,%TABLENAME,UCASE(Name),Age,Home_State) "JSON data" 
-- FROM Sample.Person

-- SELECT TOP 3 Name,
-- JSON_ARRAY(%ID,%TABLENAME,UCASE(Name),Age,Home_State ABSENT ON NULL
-- ) "JSON data" 
-- FROM Sample.Person

-- SELECT JSON_ARRAY(Name,Age,Home_State) "JSON data"
-- FROM Sample.Person

-- SELECT TOP 3 JSON_OBJECT('title':'Person from','country':UCASE(Home_State),'table':%TABLENAME,'name':Name,'id':%ID,'age':Age) "JSON data" 
-- FROM Sample.Person

-- SELECT TOP 3 JSON_OBJECT('title':'Person from','country':UCASE(Home_State),'table':%TABLENAME,'name':Name,'id':%ID,'age':Age ABSENT ON NULL) "JSON data" 
-- FROM Sample.Person

select name,age,dob from Sample.Person


