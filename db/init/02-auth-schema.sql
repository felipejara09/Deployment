\connect authentication

-- Para BCrypt
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Tablas
CREATE TABLE IF NOT EXISTS roles (
  id_role INT PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS users (
  id_user SERIAL PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  identity_number VARCHAR(30),
  date_born DATE,
  address VARCHAR(200),
  phone_number VARCHAR(30),
  id_role INT NOT NULL REFERENCES roles(id_role),
  base_salary NUMERIC(12,2) DEFAULT 0,
  password VARCHAR(100) NOT NULL
);

-- Datos semilla
INSERT INTO roles (id_role, name, description) VALUES
  (1,'ADMIN','Administrador'),
  (2,'USER','Usuario')
ON CONFLICT (id_role) DO NOTHING;

-- Usuario admin inicial
INSERT INTO users
 (name, last_name, email, identity_number, date_born, address, phone_number, id_role, base_salary, password)
VALUES
 ('Felipe','Jaramillo','felipe.jaramillo@crediya.com','1234567890','1990-01-01','Calle 123','3000000000',1,0,
  crypt('contra123*', gen_salt('bf')))
ON CONFLICT (email) DO NOTHING;
