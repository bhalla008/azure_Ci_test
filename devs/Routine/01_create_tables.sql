CREATE DATABASE IF NOT EXISTS olfm_db;
USE olfm_db;

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
