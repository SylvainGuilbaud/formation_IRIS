CREATE SCHEMA app;

-- CREATE SEQUENCE IF NOT EXISTS app.customer_id_seq
-- 	INCREMENT BY 1
-- 	MINVALUE 1
-- 	MAXVALUE 9223372036854775807
-- 	START 1;

DROP TABLE app.customer;

CREATE TABLE IF NOT EXISTS app.customer (
	-- id integer NOT NULL DEFAULT nextval('app.customer_id_seq'),
	id integer NOT NULL,
	last_name varchar(100) NULL,
	first_name varchar(100) NULL,
	city varchar(100) NULL,
    active bool DEFAULT 't',
    category integer DEFAULT 1,
    hashtag bytea,
	gender varchar,
	country varchar(100),
	description text,
	created timestamp NULL,
    inserted timestamp NULL DEFAULT now(),
    lastUpdate timestamp NULL,
	CONSTRAINT customer_pkey PRIMARY KEY (id)
);