    -- DROP TABLE columnar.address
    CREATE TABLE columnar.address (
        city varchar(50),
        zip varchar(5),
        country varchar(15)
    )
    WITH STORAGETYPE = COLUMNAR

    -- delete from columnar.Address

    insert into columnar.Address values ('London', '47000', 'UK');
    insert into columnar.Address values ('Paris', '54000', 'France');
    insert into columnar.Address values ('Kyiv', '03000', 'Ukraine');


    -- SELECT city
    -- FROM columnar.Address;