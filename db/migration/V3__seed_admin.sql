-- Admin inicial: felipe.jaramillo@crediya.com / contra123*
INSERT INTO users
  (name, last_name, email, identity_number, date_born, address, phone_number, id_role, base_salary, password)
VALUES
  ('Felipe','Jaramillo','felipe.jaramillo@crediya.com','1012345678','1990-01-01','NA','0000000',1,10000000,
   crypt('contra123*', gen_salt('bf')))
ON CONFLICT (email) DO UPDATE
  SET password = EXCLUDED.password,
      id_role  = EXCLUDED.id_role;
