--create table data.person (name varchar(500),dob date, gender integer)
--create unique index nameIndex on data.person (name)
--create bitmap index genderIndex on data.person (gender)
create index dobIndex on data.person (dob)