CREATE DATABASE makersbnb;
CREATE DATABASE makersbnb_test;

CREATE TABLE spaces (id SERIAL PRIMARY KEY, name VARCHAR(60), description VARCHAR(300), price FLOAT, email VARCHAR(50), account_id INTEGER REFERENCES accounts (id));
INSERT INTO "public"."spaces" ("id", "name", "description", "price", "email") VALUES (1, '10 downing street', 'One room flat, suitable for head of state', 10, 'example@test.com');