USE olfm_db;

SELECT * FROM employees;

SELECT e.emp_name, e.department, p.project_name
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id;
