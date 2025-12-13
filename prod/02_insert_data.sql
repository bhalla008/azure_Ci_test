USE olfm_db;

INSERT INTO employees (emp_name, department, salary)
VALUES
('Amit Sharma', 'IT', 75000),
('Neha Verma', 'HR', 65000),
('Rohit Singh', 'Finance', 70000);

INSERT INTO projects (project_name, emp_id)
VALUES
('Azure Migration', 1),
('Payroll Automation', 2),
('Cost Optimization', 3);
