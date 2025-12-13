CREATE DATABASE IF NOT EXISTS olfm_db;
USE olfm_db;

-- Employees table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT NOT NULL AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (emp_id)
) ENGINE=InnoDB;

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    project_id INT NOT NULL AUTO_INCREMENT,
    project_name VARCHAR(100),
    emp_id INT NOT NULL,
    PRIMARY KEY (project_id),
    CONSTRAINT fk_projects_emp
      FOREIGN KEY (emp_id)
      REFERENCES employees(emp_id)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
) ENGINE=InnoDB;
