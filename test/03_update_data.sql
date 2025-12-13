USE olfm_db;

UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT';

UPDATE employees
SET department = 'Cloud'
WHERE emp_name = 'Amit Sharma';
