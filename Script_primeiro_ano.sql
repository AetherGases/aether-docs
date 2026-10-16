CREATE TABLE subscription (
  id INT PRIMARY KEY,
  is_active BOOLEAN,
  installments BOOLEAN,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE company (
  id INT PRIMARY KEY,
  id_subscription INT,
  name VARCHAR(255),
  size INT CHECK (size>0)
  registration_date DATE,
  tax_id VARCHAR(50),
  email VARCHAR(255),
  FOREIGN KEY (id_subscription) REFERENCES subscription(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE telephone (
  id INT PRIMARY KEY,
  telephone VARCHAR(20),
  id_company INT,
  FOREIGN KEY (id_company) REFERENCES company(id)
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sector (
  id INT PRIMARY KEY,
  description VARCHAR(255),
  id_company INT,
  FOREIGN KEY (id_company) REFERENCES company(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE report (
  id INT PRIMARY KEY,
  id_company INT,
  file_size FLOAT CHECK (file_size>0),
  status VARCHAR(50) DEFAULT 'pending',
  file_path VARCHAR(255),
  start_period DATE,
  end_period DATE CHECK (end_period>start_period),
  submission_date DATE,
  type VARCHAR(100),
  FOREIGN KEY (id_company) REFERENCES company(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ROI


CREATE TABLE roi_analysis (
  id INT PRIMARY KEY,
  id_report INT,
  calculation_date DATE,
  years_along INT,
  estimated_payback_month FLOAT,
  carbon_credit_revenue FLOAT,
  annual_rate_technology_degradation FLOAT,
  wacc FLOAT,
  FOREIGN KEY (id_report) REFERENCES report(id)
);

CREATE TABLE roi_projection_year (
  id INT PRIMARY KEY,
  id_roi_analysis INT,
  year INT,
  value FLOAT,
  FOREIGN KEY (id_roi_analysis) REFERENCES roi_analysis(id)
);


-- EMPLOYEE 
CREATE TYPE status_employee AS ENUM ('ativo', 'afastado', 'em férias', 'despensado');

CREATE TABLE employee (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  last_name VARCHAR(255),
  email VARCHAR(255),
  status status_employee NOT NULL
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_telephone (
  id INT PRIMARY KEY,
  telephone VARCHAR(20),
  id_employee INT,
  FOREIGN KEY (id_employee) REFERENCES employee(id)
);

CREATE TABLE contract (
  id INT PRIMARY KEY,
  id_employee INT,
  id_company INT,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_company) REFERENCES company(id)
);


-- GAS 

CREATE TABLE gas (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  type VARCHAR(100),
  measurement VARCHAR(50),
  gwp INT
);

CREATE TABLE sector_gas (
  id INT PRIMARY KEY,
  id_sector INT,
  id_gas INT,
  FOREIGN KEY (id_sector) REFERENCES sector(id),
  FOREIGN KEY (id_gas) REFERENCES gas(id)
);

CREATE TABLE gas_reduction (
  id INT PRIMARY KEY,
  unit VARCHAR(100),
  init_emission FLOAT,
  current_emission FLOAT,
  estimated_reduction FLOAT,
  estimated_days INT,
  estimated_roi FLOAT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reduction_gas (
  id INT PRIMARY KEY,
  id_gas_reduction INT,
  id_gas INT,
  FOREIGN KEY (id_gas_reduction) REFERENCES gas_reduction(id),
  FOREIGN KEY (id_gas) REFERENCES gas(id)
);

CREATE TABLE reduction_report (
  id INT PRIMARY KEY,
  id_gas_reduction INT,
  id_report INT,
  FOREIGN KEY (id_gas_reduction) REFERENCES gas_reduction(id),
  FOREIGN KEY (id_report) REFERENCES report(id)
);

CREATE TABLE parana_climate_seal (
  id INT PRIMARY KEY,
  date_achievement DATE,
  current_score FLOAT 
)


-- UNITS / ADDRESS

CREATE TABLE unit (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  cnpj VARCHAR(50),
  cnae VARCHAR(50),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE address (
  id INT PRIMARY KEY,
  street VARCHAR(255),
  number VARCHAR(20),
  complement VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100)
);

CREATE TABLE unit_company (
  id INT PRIMARY KEY,
  id_unit INT,
  id_company INT,
  FOREIGN KEY (id_unit) REFERENCES unit(id),
  FOREIGN KEY (id_company) REFERENCES company(id)
);

CREATE TABLE company_address (
  id INT PRIMARY KEY,
  id_company INT,
  id_address INT,
  FOREIGN KEY (id_company) REFERENCES company(id),
  FOREIGN KEY (id_address) REFERENCES address(id)
);

CREATE TABLE unit_address (
  id INT PRIMARY KEY,
  id_unit INT,
  id_address INT,
  FOREIGN KEY (id_unit) REFERENCES unit(id),
  FOREIGN KEY (id_address) REFERENCES address(id)
);


-- SUBSCRIPTION / PAYMENT


CREATE TABLE plan (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(255),
  price FLOAT CHECK (price>0)
  currency VARCHAR(10)
);

CREATE TABLE payment (
  id INT PRIMARY KEY,
  currency VARCHAR(10),
  due_date DATE,
  payment_type VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subscription_plan (
  id INT PRIMARY KEY,
  id_subscription INT,
  id_plan INT,
  FOREIGN KEY (id_subscription) REFERENCES subscription(id),
  FOREIGN KEY (id_plan) REFERENCES plan(id)
);

CREATE TABLE subscription_payment (
  id INT PRIMARY KEY,
  id_subscription INT,
  id_payment INT,
  FOREIGN KEY (id_subscription) REFERENCES subscription(id),
  FOREIGN KEY (id_payment) REFERENCES payment(id)
);


-- PERMISSIONS


CREATE TABLE permission_group (
  id INT PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE permission (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  description VARCHAR(255)
);

CREATE TABLE group_employee (
  id INT PRIMARY KEY,
  id_employee INT,
  id_group INT,
  FOREIGN KEY (id_employee) REFERENCES employee(id),
  FOREIGN KEY (id_group) REFERENCES permission_group(id)
);

CREATE TABLE permission_permission_group (
  id INT PRIMARY KEY,
  id_group INT,
  id_permission INT,
  FOREIGN KEY (id_group) REFERENCES permission_group(id),
  FOREIGN KEY (id_permission) REFERENCES permission(id)
);


-- ADMIN

CREATE TABLE administrator (
  id INT PRIMARY KEY,
  email VARCHAR(255),
  password VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);