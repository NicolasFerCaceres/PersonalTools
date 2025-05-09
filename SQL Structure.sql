/*Already used*/
DROP database wallet; 
CREATE database wallet;
use wallet;

CREATE TABLE person (
	person_id  INT PRIMARY KEY AUTO_INCREMENT,
    person_desc VARCHAR(255) NOT NULL
);

INSERT INTO person (person_desc)
VALUES 	('Nicolás'),
		('Mila');

CREATE TABLE brand (
	brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_desc VARCHAR(255) NOT NULL
);

INSERT INTO brand(brand_desc)
VALUES ('Empty');

CREATE TABLE place (
	place_id INT PRIMARY KEY AUTO_INCREMENT,
	place_desc VARCHAR(255) NOT NULL,
    fk_brand_id INT DEFAULT 1,
    FOREIGN KEY(fk_brand_id)
	REFERENCES brand(brand_id)
);

CREATE TABLE tag (
	tag_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_desc VARCHAR(255) NOT NULL
);

CREATE TABLE category (
	cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_desc VARCHAR(255) NOT NULL,
    parent_cat INT 
    DEFAULT NULL,
    FOREIGN KEY (parent_cat)
    REFERENCES category(cat_id)
);

INSERT INTO category (cat_desc)
VALUES ('Empty');

CREATE TABLE discount (
	discount_id INT PRIMARY KEY AUTO_INCREMENT,
    discount_desc VARCHAR(255) NOT NULL
);

CREATE TABLE movement(
	movement_id INT PRIMARY KEY AUTO_INCREMENT,
    movement_total INT NOT NULL,
    movement_disc INT,
    move_date TIMESTAMP NOT NULL,
    fk_move_place INT NOT NULL,
    FOREIGN KEY(fk_move_place)
    REFERENCES place(place_id)
);

CREATE TABLE articles (
	art_id INT PRIMARY KEY AUTO_INCREMENT,
    art_desc VARCHAR(255)NOT NULL,
    art_last_price INT,
    fk_art_category INT DEFAULT 1,
    fk_art_brand INT DEFAULT 1,
    FOREIGN KEY (fk_art_category)
    REFERENCES category(cat_id),
	FOREIGN KEY (fk_art_brand)
	REFERENCES brand(brand_id)
);

CREATE TABLE accounts (
	account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_desc VARCHAR(255) NOT NULL,
    account_total INT,
    fk_account_owner INT NOT NULL,
    FOREIGN KEY (fk_account_owner)
    REFERENCES person(person_id)
);

CREATE TABLE paid_method (
	pm_id INT PRIMARY KEY AUTO_INCREMENT,
    pm_desc VARCHAR(255) NOT NULL,
    fk_account INT,
    FOREIGN KEY (fk_account)
	REFERENCES accounts(account_id)
);


CREATE TABLE subscriptions (
	subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_desc VARCHAR(255) NOT NULL,
    is_active TINYINT NOT NULL DEFAULT 0,
    subscription_price INT NOT NULL,
    subscription_debit VARCHAR(255),
    payment_gap INT,
    fk_subscription_owner INT,
    exp_date TIMESTAMP,
    FOREIGN KEY (fk_subscription_owner)
    REFERENCES person(person_id)
);

CREATE TABLE invoices (
	invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_desc VARCHAR(255) NOT NULL,
    invoice_amount INT,
    is_active TINYINT NOT NULL DEFAULT 0
);

/*AUX TABLES*/

CREATE TABLE aux_art_mov (
	fk_article_id INT NOT NULL,
    fk_movement_id INT NOT NULL,
    quantity INT DEFAULT 1,
    price INT NOT NULL,
    unit_price int NOT NULL,
	fk_discount_id INT,
    discount_amount INT DEFAULT 0,
    FOREIGN KEY (fk_article_id)
    REFERENCES articles(art_id),
    FOREIGN KEY (fk_movement_id) 
    REFERENCES movement(movement_id),
    FOREIGN KEY (fk_discount_id)
    REFERENCES discount(discount_id)
);

CREATE TABLE aux_pm_mov(
	pm_mov_indx INT PRIMARY KEY AUTO_INCREMENT,
    fk_pm_id INT NOT NULL,
    fk_mov_id INT NOT NULL,
    amount INT NOT NULL,
    fees INT NOT NULL,
    fees_value INT NOT NULL,
	FOREIGN KEY (fk_pm_id)
    REFERENCES paid_method(pm_id),
    FOREIGN KEY (fk_mov_id)
    REFERENCES movement(movement_id)
);

CREATE TABLE aux_pm_disc(
	fk_pm_mov_id INT NOT NULL,
    fk_disc_id INT NOT NULL,
    disc_value INT NOT NULL,
    FOREIGN KEY(fk_pm_mov_id)
    REFERENCES aux_pm_mov(pm_mov_indx),
    FOREIGN KEY (fk_disc_id)
    REFERENCES discount(discount_id)
);

CREATE TABLE aux_tag_art (
	fk_tag_id INT NOT NULL,
    fk_art_id INT NOT NULL,
    fk_mov_id INT NOT NULL,
    FOREIGN KEY (fk_tag_id) 
    REFERENCES tag(tag_id),
    FOREIGN KEY (fk_art_id)
    REFERENCES articles(art_id),
    FOREIGN KEY (fk_mov_id)
    REFERENCES movement(movement_id)
);

CREATE TABLE aux_subscription_art (
	fk_tag_id INT NOT NULL,
    fk_subscr_id INT NOT NULL,
    fk_mov_id INT NOT NULL,
    FOREIGN KEY (fk_tag_id) 
    REFERENCES tag(tag_id),
    FOREIGN KEY (fk_subscr_id)
    REFERENCES subscriptions(subscription_id),
    FOREIGN KEY (fk_mov_id)
    REFERENCES movement(movement_id)
);

CREATE TABLE aux_invoices_art (
	fk_tag_id INT NOT NULL,
    fk_invoice_id INT NOT NULL,
    fk_mov_id INT NOT NULL,
    FOREIGN KEY (fk_tag_id) 
    REFERENCES tag(tag_id),
    FOREIGN KEY (fk_invoice_id)
    REFERENCES invoices(invoice_id),
    FOREIGN KEY (fk_mov_id)
    REFERENCES movement(movement_id)
);
