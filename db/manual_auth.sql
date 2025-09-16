-- Extensión para bcrypt
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Roles
CREATE TABLE IF NOT EXISTS roles (
  id_role SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE NOT NULL,
  description VARCHAR(255)
);

-- Usuarios
CREATE TABLE IF NOT EXISTS users (
  id_user SERIAL PRIMARY KEY,
  name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(150) UNIQUE NOT NULL,
  identity_number VARCHAR(50),
  date_born DATE,
  address VARCHAR(255),
  phone_number VARCHAR(50),
  id_role INT NOT NULL REFERENCES roles(id_role),
  base_salary NUMERIC(12,2),
  password VARCHAR(200) NOT NULL
);

-- Rol ADMIN
INSERT INTO roles (name, description)
VALUES ('ADMIN','Administrador del sistema')
ON CONFLICT (name) DO NOTHING;

-- Usuario admin: felipe.jaramillo@crediya.com / contra123*
DO $$
DECLARE admin_role_id INT;
BEGIN
  SELECT id_role INTO admin_role_id FROM roles WHERE name='ADMIN';
  IF NOT EXISTS (SELECT 1 FROM users WHERE email='felipe.jaramillo@crediya.com') THEN
    INSERT INTO users (name, last_name, email, id_role, password)
    VALUES ('Felipe','Jaramillo','felipe.jaramillo@crediya.com', admin_role_id,
            crypt('contra123*', gen_salt('bf')));  -- bcrypt
  END IF;
END $$;
