\connect loan_applications;

-- Estados (forzando IDs)
INSERT INTO states (id_state, name, description)
OVERRIDING SYSTEM VALUE
VALUES
  (1, 'Pending Review', 'The application has been received and is awaiting evaluation.'),
  (2, 'Approved',       'The loan application has been approved'),
  (3, 'Rejected',       'The loan application has been rejected'),
  (4, 'In Process',     'The loan is currently being processed for disbursement')
ON CONFLICT (id_state) DO NOTHING;

-- Tipos de crédito (forzando IDs)
INSERT INTO loan_type (id_loan_type, name, min_amount, max_amount, interest_rate, automatic_validation)
OVERRIDING SYSTEM VALUE
VALUES
  (1, 'Mortgage Loan',           5000000.00,  500000000.00, 11.50, FALSE),
  (2, 'Personal/Consumer Loan',  1000000.00,   10000000.00, 20.00, TRUE),
  (3, 'Vehicle Loan',            1000000.00,   15000000.00, 15.00, TRUE),
  (4, 'Revolving Credit',         500000.00,   30000000.00, 28.00, TRUE),
  (5, 'Free Investment Loan',    2000000.00,  120000000.00, 22.00, FALSE)
ON CONFLICT (id_loan_type) DO NOTHING;

-- IMPORTANTÍSIMO: alinear la secuencia para que el siguiente INSERT sin id no choque
SELECT setval(pg_get_serial_sequence('states','id_state'),
              COALESCE((SELECT MAX(id_state)+1 FROM states),1), false);

SELECT setval(pg_get_serial_sequence('loan_type','id_loan_type'),
              COALESCE((SELECT MAX(id_loan_type)+1 FROM loan_type),1), false);
