USE olfm_db;

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY
) ENGINE=InnoDB;

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    emp_id INT,
    CONSTRAINT fk_projects_emp
      FOREIGN KEY (emp_id)
      REFERENCES employees(emp_id)
) ENGINE=InnoDB;
