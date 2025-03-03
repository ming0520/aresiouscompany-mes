-- Create a new user
DO $$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles 
      WHERE rolname = 'service_serious'
   ) THEN
      CREATE USER service_serious WITH PASSWORD 'serious123';
   END IF;
END $$;

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE mes_db TO service_serious;

-- Grant all privileges on the public schema to the user
GRANT ALL PRIVILEGES ON SCHEMA public TO service_serious;

-- Grant all privileges on all tables in the public schema to the user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO service_serious;

-- Grant all privileges on all sequences in the public schema to the user
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO service_serious;

-- Grant all privileges on all functions in the public schema to the user
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO service_serious;

-- Production Tables
CREATE TABLE production_orders (
  id SERIAL PRIMARY KEY,
  order_number VARCHAR(50) UNIQUE NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  quantity INTEGER NOT NULL,
  start_date TIMESTAMP,
  due_date TIMESTAMP,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE production_steps (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES production_orders(id),
  step_name VARCHAR(100) NOT NULL,
  status VARCHAR(20) NOT NULL,
  start_time TIMESTAMP,
  end_time TIMESTAMP
);

-- Quality Control Tables
CREATE TABLE quality_inspections (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES production_orders(id),
  inspector_name VARCHAR(100) NOT NULL,
  inspection_date TIMESTAMP NOT NULL,
  status VARCHAR(20) NOT NULL,
  notes TEXT
);

CREATE TABLE defects (
  id SERIAL PRIMARY KEY,
  inspection_id INTEGER REFERENCES quality_inspections(id),
  defect_type VARCHAR(50) NOT NULL,
  severity VARCHAR(20) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Metrics Tables
CREATE TABLE machine_utilization (
  id SERIAL PRIMARY KEY,
  machine_id VARCHAR(50) NOT NULL,
  utilization_percentage DECIMAL(5,2) NOT NULL,
  recorded_at TIMESTAMP DEFAULT NOW()
);


-- Create the database
CREATE DATABASE mes_db;

-- Create a new user
CREATE USER service_serious WITH PASSWORD 'serious123';

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE mes_db TO service_serious;

-- Grant all privileges on the public schema to the user
GRANT ALL PRIVILEGES ON SCHEMA public TO service_serious;

-- Grant all privileges on all tables in the public schema to the user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO service_serious;

-- Grant all privileges on all sequences in the public schema to the user
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO service_serious;

-- Grant all privileges on all functions in the public schema to the user
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO service_serious;

-- Production Tables
CREATE TABLE production_orders (
  id SERIAL PRIMARY KEY,
  order_number VARCHAR(50) UNIQUE NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  quantity INTEGER NOT NULL,
  start_date TIMESTAMP,
  due_date TIMESTAMP,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE production_steps (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES production_orders(id),
  step_name VARCHAR(100) NOT NULL,
  status VARCHAR(20) NOT NULL,
  start_time TIMESTAMP,
  end_time TIMESTAMP
);

-- Quality Control Tables
CREATE TABLE quality_inspections (
  id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES production_orders(id),
  inspector_name VARCHAR(100) NOT NULL,
  inspection_date TIMESTAMP NOT NULL,
  status VARCHAR(20) NOT NULL,
  notes TEXT
);

CREATE TABLE defects (
  id SERIAL PRIMARY KEY,
  inspection_id INTEGER REFERENCES quality_inspections(id),
  defect_type VARCHAR(50) NOT NULL,
  severity VARCHAR(20) NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Metrics Tables
CREATE TABLE machine_utilization (
  id SERIAL PRIMARY KEY,
  machine_id VARCHAR(50) NOT NULL,
  utilization_percentage DECIMAL(5,2) NOT NULL,
  recorded_at TIMESTAMP DEFAULT NOW()
);

-- Insert mock data into production_orders
INSERT INTO production_orders (order_number, product_name, quantity, start_date, due_date, status)
VALUES
  ('PO1001', 'Widget A', 100, '2023-10-01 08:00:00', '2023-10-10 17:00:00', 'In Progress'),
  ('PO1002', 'Widget B', 200, '2023-10-02 09:00:00', '2023-10-12 17:00:00', 'Pending'),
  ('PO1003', 'Widget C', 150, '2023-10-03 10:00:00', '2023-10-15 17:00:00', 'Completed');

-- Insert mock data into production_steps
INSERT INTO production_steps (order_id, step_name, status, start_time, end_time)
VALUES
  (1, 'Cutting', 'Completed', '2023-10-01 08:00:00', '2023-10-01 10:00:00'),
  (1, 'Assembling', 'In Progress', '2023-10-01 10:30:00', NULL),
  (2, 'Cutting', 'Pending', NULL, NULL),
  (3, 'Cutting', 'Completed', '2023-10-03 10:00:00', '2023-10-03 12:00:00'),
  (3, 'Assembling', 'Completed', '2023-10-03 12:30:00', '2023-10-03 15:00:00'),
  (3, 'Packaging', 'Completed', '2023-10-03 15:30:00', '2023-10-03 17:00:00');

-- Insert mock data into quality_inspections
INSERT INTO quality_inspections (order_id, inspector_name, inspection_date, status, notes)
VALUES
  (1, 'John Doe', '2023-10-01 17:00:00', 'Passed', 'No issues found.'),
  (2, 'Jane Smith', '2023-10-02 17:00:00', 'Pending', 'Inspection scheduled.'),
  (3, 'John Doe', '2023-10-03 17:00:00', 'Failed', 'Minor defects found.');

-- Insert mock data into defects
INSERT INTO defects (inspection_id, defect_type, severity, description)
VALUES
  (3, 'Scratch', 'Low', 'Minor scratch on the surface.'),
  (3, 'Misalignment', 'Medium', 'Parts slightly misaligned.');

-- Insert mock data into machine_utilization
INSERT INTO machine_utilization (machine_id, utilization_percentage, recorded_at)
VALUES
  ('M001', 85.50, '2023-10-01 08:00:00'),
  ('M002', 90.00, '2023-10-01 08:00:00'),
  ('M001', 88.75, '2023-10-02 08:00:00'),
  ('M002', 92.30, '2023-10-02 08:00:00');


-- Insert more mock data into production_orders
INSERT INTO production_orders (order_number, product_name, quantity, start_date, due_date, status)
VALUES
  ('PO1004', 'Widget D', 120, '2023-11-01 08:00:00', '2023-11-10 17:00:00', 'In Progress'),
  ('PO1005', 'Widget E', 180, '2023-11-02 09:00:00', '2023-11-12 17:00:00', 'Pending'),
  ('PO1006', 'Widget F', 140, '2023-12-01 10:00:00', '2023-12-15 17:00:00', 'Completed'),
  ('PO1007', 'Widget G', 130, '2024-01-01 08:00:00', '2024-01-10 17:00:00', 'In Progress'),
  ('PO1008', 'Widget H', 190, '2024-01-02 09:00:00', '2024-01-12 17:00:00', 'Pending'),
  ('PO1009', 'Widget I', 110, '2024-02-01 10:00:00', '2024-02-15 17:00:00', 'Completed'),
  ('PO1010', 'Widget J', 115, '2024-03-01 08:00:00', '2024-03-10 17:00:00', 'In Progress'),
  ('PO1011', 'Widget K', 125, '2024-03-02 09:00:00', '2024-03-12 17:00:00', 'Pending'),
  ('PO1012', 'Widget L', 160, '2024-04-01 10:00:00', '2024-04-15 17:00:00', 'Completed'),
  ('PO1013', 'Widget M', 170, '2024-05-01 08:00:00', '2024-05-10 17:00:00', 'In Progress');

-- Insert more mock data into production_steps
INSERT INTO production_steps (order_id, step_name, status, start_time, end_time)
VALUES
  (4, 'Cutting', 'Completed', '2023-11-01 08:00:00', '2023-11-01 10:00:00'),
  (4, 'Assembling', 'In Progress', '2023-11-01 10:30:00', NULL),
  (5, 'Cutting', 'Pending', NULL, NULL),
  (6, 'Cutting', 'Completed', '2023-12-01 10:00:00', '2023-12-01 12:00:00'),
  (6, 'Assembling', 'Completed', '2023-12-02 12:30:00', '2023-12-02 15:00:00'),
  (6, 'Packaging', 'Completed', '2023-12-03 15:30:00', '2023-12-03 17:00:00'),
  (7, 'Cutting', 'Completed', '2024-01-01 08:00:00', '2024-01-01 10:00:00'),
  (7, 'Assembling', 'In Progress', '2024-01-01 10:30:00', NULL),
  (8, 'Cutting', 'Pending', NULL, NULL),
  (9, 'Cutting', 'Completed', '2024-02-01 10:00:00', '2024-02-01 12:00:00');

-- Insert more mock data into quality_inspections
INSERT INTO quality_inspections (order_id, inspector_name, inspection_date, status, notes)
VALUES
  (4, 'John Doe', '2023-11-01 17:00:00', 'Passed', 'No issues found.'),
  (5, 'Jane Smith', '2023-11-02 17:00:00', 'Pending', 'Inspection scheduled.'),
  (6, 'John Doe', '2023-12-01 17:00:00', 'Failed', 'Minor defects found.'),
  (7, 'Jane Smith', '2024-01-01 17:00:00', 'Passed', 'No issues found.'),
  (8, 'John Doe', '2024-01-02 17:00:00', 'Pending', 'Inspection scheduled.'),
  (9, 'Jane Smith', '2024-02-01 17:00:00', 'Failed', 'Minor defects found.'),
  (10, 'John Doe', '2024-02-02 17:00:00', 'Passed', 'No issues found.'),
  (11, 'Jane Smith', '2024-03-01 17:00:00', 'Pending', 'Inspection scheduled.'),
  (12, 'John Doe', '2024-03-02 17:00:00', 'Failed', 'Minor defects found.');

-- Insert more mock data into defects
INSERT INTO defects (inspection_id, defect_type, severity, description)
VALUES
  (6, 'Scratch', 'Low', 'Minor scratch on the surface.'),
  (6, 'Misalignment', 'Medium', 'Parts slightly misaligned.'),
  (9, 'Crack', 'High', 'Visible crack on the part.'),
  (9, 'Rust', 'Medium', 'Rust spots found.'),
  (12, 'Dent', 'Low', 'Small dent on the surface.');

-- Insert more mock data into machine_utilization
INSERT INTO machine_utilization (machine_id, utilization_percentage, recorded_at)
VALUES
  ('M001', 85.00, '2023-11-01 08:00:00'),
  ('M002', 90.50, '2023-11-01 08:00:00'),
  ('M001', 86.75, '2023-11-02 08:00:00'),
  ('M002', 91.30, '2023-11-02 08:00:00'),
  ('M001', 84.50, '2023-12-01 08:00:00'),
  ('M002', 89.25, '2023-12-01 08:00:00'),
  ('M001', 87.75, '2024-01-01 08:00:00'),
  ('M002', 93.00, '2024-01-01 08:00:00'),
  ('M001', 88.50, '2024-02-01 08:00:00'),
  ('M002', 92.75, '2024-02-01 08:00:00');


-- Add the order_value column
ALTER TABLE production_orders
ADD COLUMN order_value DECIMAL(10,2);

-- Update existing records with random order_value
UPDATE production_orders
SET order_value = ROUND((RANDOM() * (5000.00 - 1000.00) + 1000.00)::NUMERIC, 2);


