DROP TABLE dc.Person;

CREATE TABLE dc.Person (
                                          name VARCHAR(40),
                                          street VARCHAR(60),
                                          city VARCHAR(30),
                                          state VARCHAR(4),
                                          postal_code VARCHAR(10),
                                          phone_nbrs VARCHAR(2000)
);

INSERT INTO dc.Person (name, street, city, state, postal_code, phone_nbrs)
    VALUES (
        'Caroline',
        'One Memorial',
        'Cambridge',
        'MA', '02142',
        '[{"type":"office","number":"(617) 225-5555"},{"type":"mobile","number":"(617) 555-1111"}]'
    );

INSERT INTO dc.Person (name, street, city, state, postal_code, phone_nbrs)
    VALUES (
        'Doe, John',
        '123 Main Street',
        'Cambridge',
        'MA',
        '02142',
        '[{"type":"mobile","country_code":"1","number":"999-999-9999"},{"type":"work","country_code":"1","number":"888-888-8888"}]'
    );

INSERT INTO dc.Person (name, street, city, state, postal_code, phone_nbrs)
VALUES (
    'Smith, Georgia',
    '100 Privet Lane, Unit 20',
    'Melrose',
    'MA',
    '02176',
    '[{"type":"mobile","country_code":"1","number":"555-867-5309"},{"type":"home","country_code":"1","number":"555-123-1234"},{"type":"office","number":"555-000-0000"}]'
    );

INSERT INTO dc.Person (name, street, city, state, postal_code, phone_nbrs)
VALUES (
    'Jones, Thomas',
    '63 North Park Way',
    'Princeton',
    'NJ',
    '08540',
    '[{"type":"mobile","country_code":"1","number":"555-555-5555"},{"type":"work","country_code":"1","number":"555-BR5-4949"}]'
    );

SELECT p.%ID, p.name, p.street, p.city, p.state, p.postal_code,
    pn.phone_type, pn.country_code, pn.phone_nbr
FROM dc.Person p,
    JSON_TABLE(p.phone_nbrs, '$'
    COLUMNS(
    phone_type VARCHAR(10) path '$.type',
    country_code VARCHAR(8) path '$."country_code"',
    phone_nbr VARCHAR(12) path '$.number'
    )
    ) pn;