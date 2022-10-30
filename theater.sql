CREATE TABLE company (
  id int PRIMARY KEY NOT NULL ,
  name varchar(255) NOT NULL,
  hall_capacity int NOT NULL
);

CREATE TABLE balance (
  company_id int NOT NULL,
  date_t date NOT NULL,
  amount int NOT NULL
);

CREATE TABLE show (
  id int PRIMARY KEY NOT NULL ,
  name varchar(255) NOT NULL,
  company_id int NOT NULL,
  production_cost int NOT NULL,
  distribution_cost int NOT NULL
);

CREATE TABLE presentation (
  id int PRIMARY KEY NOT NULL ,
  show_id int NOT NULL,
  host_company_id int NOT NULL,
  travel_cost int,
  payment int
);

CREATE TABLE event (
  presentation_id int NOT NULL,
  date_t date NOT NULL,
  PRIMARY KEY (presentation_id, date_t)
);

CREATE TABLE discount (
  id int PRIMARY KEY NOT NULL ,
  condition varchar(255) NOT NULL,
  percentage int NOT NULL,
  global NUMBER(1) NOT NULL
);

CREATE TABLE ticket (
  event_presentation_id int NOT NULL,
  event_date date NOT NULL,
  customer_id int NOT NULL,
  discount_id int,
  PRIMARY KEY (event_presentation_id, event_date, customer_id)
);

CREATE TABLE customer (
  id int PRIMARY KEY NOT NULL ,
  name varchar(255) NOT NULL,
  email varchar(255) UNIQUE NOT NULL,
  password varchar(255) NOT NULL
);

CREATE TABLE sponsor (
  id int PRIMARY KEY NOT NULL ,
  name varchar(255) NOT NULL
);

CREATE TABLE grants (
  id int PRIMARY KEY NOT NULL ,
  sponsor_id int NOT NULL,
  beneficiary_company_id int NOT NULL,
  start_date timestamp NOT NULL,
  amount int NOT NULL,
  days_interval int NOT NULL,
  count int NOT NULL
);

ALTER TABLE balance ADD FOREIGN KEY (company_id) REFERENCES company (id);

ALTER TABLE show ADD FOREIGN KEY (company_id) REFERENCES company (id);

ALTER TABLE presentation ADD FOREIGN KEY (show_id) REFERENCES show (id);

ALTER TABLE presentation ADD FOREIGN KEY (host_company_id) REFERENCES company (id);

ALTER TABLE event ADD FOREIGN KEY (presentation_id) REFERENCES presentation (id);

CREATE TABLE discount_presentation (
  discount_id int,
  presentation_id int,
  PRIMARY KEY (discount_id, presentation_id)
);

ALTER TABLE discount_presentation ADD FOREIGN KEY (discount_id) REFERENCES discount (id);

ALTER TABLE discount_presentation ADD FOREIGN KEY (presentation_id) REFERENCES presentation (id);


ALTER TABLE ticket ADD FOREIGN KEY (customer_id) REFERENCES customer (id);

ALTER TABLE ticket ADD FOREIGN KEY (discount_id) REFERENCES discount (id);

ALTER TABLE ticket ADD FOREIGN KEY (event_presentation_id, event_date) REFERENCES event (presentation_id, date_t);

ALTER TABLE grants ADD FOREIGN KEY (sponsor_id) REFERENCES sponsor (id);

ALTER TABLE grants ADD FOREIGN KEY (beneficiary_company_id) REFERENCES company (id);

