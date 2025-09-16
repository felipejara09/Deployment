INSERT INTO role (id_rol, name, description) VALUES
  (1,'ADMIN','Administrator'),
  (2,'ADVISOR','Advisor'),
  (3,'CLIENT','Client')
ON CONFLICT (id_rol) DO NOTHING;
