-- Database: Wallet
 DROP DATABASE IF EXISTS "Wallet";

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
    person_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    person_desc VARCHAR(255) NOT NULL
);

INSERT INTO person (person_desc)
VALUES
    ('Nicolás'),
    ('Baby');

CREATE TABLE brand (
	brand_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	brand_desc VARCHAR(255) DEFAULT 'EMPTY'
);



CREATE TABLE place (
	place_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	place_desc VARCHAR(255) NOT NULL,
	fk_brand_id INTEGER DEFAULT 1,
	FOREIGN KEY (fk_brand_id) REFERENCES brand(brand_id)
);


CREATE TABLE tag (
	tag_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	tag_desc VARCHAR(255) NOT NULL
);

CREATE TABLE category (
	cat_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	cat_desc VARCHAR(255) NOT NULL,
	parent_cat INTEGER DEFAULT NULL,
	FOREIGN KEY (parent_cat) REFERENCES category(cat_id)
);

INSERT INTO category (cat_desc)
VALUES ('Empty');

CREATE TABLE discount (
	discount_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	discount_desc VARCHAR(255) NOT NULL DEFAULT 'Empty'
);

CREATE TABLE currency (
	currency_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	currency_desc VARCHAR(255) NOT NULL
);

CREATE TABLE currency_convert (
	fk_currency_id INTEGER NOT NULL,
	currency_value NUMERIC(10,2) NOT NULL,
	creation_date TIMESTAMP NOT NULL,
	FOREIGN KEY (fk_currency_id) REFERENCES currency(currency_id)
);

CREATE TABLE movement(
	movement_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    movement_total NUMERIC(10,2) NOT NULL,
	fk_movement_currency INTEGER,
    movement_disc NUMERIC(10,2),
    move_date TIMESTAMP NOT NULL,
    fk_move_place INTEGER NOT NULL,
    FOREIGN KEY (fk_move_place) REFERENCES place(place_id),
	FOREIGN KEY (fk_movement_currency) REFERENCES currency(currency_id)
);

CREATE TABLE articles (
	art_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	art_desc VARCHAR(255) DEFAULT 'Empty',
	art_last_price NUMERIC(10,2),
	fk_art_category INTEGER DEFAULT 1,
	fk_art_brand INTEGER DEFAULT 1,
	FOREIGN KEY (fk_art_category) REFERENCES category (cat_id),
	FOREIGN KEY (fk_art_brand) REFERENCES brand(brand_id)
);

CREATE TABLE accounts (
	account_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	account_desc VARCHAR(255) NOT NULL,
	account_total NUMERIC(10,2) NOT NULL,
	fk_account_owner INTEGER NOT NULL,
	FOREIGN KEY (fk_account_owner) REFERENCES person(person_id)
);

CREATE TABLE paid_method (
	pm_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	pm_desc VARCHAR(255) DEFAULT 'Empty',
	fk_account INTEGER,
	FOREIGN KEY (fk_account) REFERENCES accounts(account_id)
);

CREATE TABLE bills (
	bill_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	bill_desc VARCHAR(255) DEFAULT 'Empty',
	is_active BOOLEAN NOT NULL DEFAULT TRUE,
	bill_last_price NUMERIC(10,2),
	payment_gap INTEGER DEFAULT 1,
	last_pay TIMESTAMP,
	exp_date TIMESTAMP
);

CREATE TABLE aux_art_mov (
	fk_article_id INTEGER NOT NULL,
	fk_movement_id INTEGER NOT NULL,
	quantity INTEGER DEFAULT 1,
	price INTEGER NOT NULL,
	unit_price INT NOT NULL,
	FOREIGN KEY (fk_article_id) REFERENCES articles(art_id),
    FOREIGN KEY (fk_movement_id) REFERENCES movement(movement_id)
);

CREATE TABLE aux_pm_mov(
    fk_pm_id INTEGER NOT NULL,
    fk_mov_id INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    fees INTEGER NOT NULL,
    fees_value NUMERIC(10,2) NOT NULL,
	FOREIGN KEY (fk_pm_id) REFERENCES paid_method(pm_id),
    FOREIGN KEY (fk_mov_id) REFERENCES movement(movement_id)
);


CREATE TABLE aux_tag_art (
	fk_tag_id INT NOT NULL,
    fk_art_id INT NOT NULL,
    FOREIGN KEY (fk_tag_id) REFERENCES tag(tag_id),
    FOREIGN KEY (fk_art_id) REFERENCES articles(art_id)
);


CREATE TABLE aux_disc_mov (
	fk_disc_id INTEGER NOT NULL,
	fk_mov_id INTEGER NOT NULL,
	discount_amount NUMERIC(10,2),
	FOREIGN KEY (fk_disc_id) REFERENCES discount(discount_id),
	FOREIGN KEY (fk_mov_id) REFERENCES movement(movement_id)
);
