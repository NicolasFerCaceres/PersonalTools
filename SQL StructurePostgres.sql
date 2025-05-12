-- Database: Wallet

-- DROP DATABASE IF EXISTS "Wallet";

CREATE DATABASE "Wallet"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Uruguay.1252'
    LC_CTYPE = 'Spanish_Uruguay.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE person (
    person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_desc VARCHAR(255) NOT NULL
);

