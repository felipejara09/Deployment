
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS role (
  id_rol       BIGSERIAL PRIMARY KEY,
  name         TEXT NOT NULL UNIQUE,
  description  TEXT
);

CREATE TABLE IF NOT EXISTS users (
  id_user           BIGSERIAL PRIMARY KEY,
  name              TEXT NOT NULL,
  last_name         TEXT NOT NULL,
  email             TEXT NOT NULL UNIQUE,
  identity_number   TEXT NOT NULL UNIQUE,
  date_born         DATE,
  address           TEXT,
  phone_number      TEXT,
  id_role           BIGINT NOT NULL REFERENCES role(id_rol),
  base_salary       NUMERIC(15,2) NOT NULL,
  password          TEXT
);


CREATE INDEX IF NOT EXISTS idx_users_email     ON users (email);
CREATE INDEX IF NOT EXISTS idx_users_identity  ON users (identity_number);
