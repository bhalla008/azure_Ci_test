USE olfm_db;

SELECT 
    p.project_id,
    e.emp_id
FROM projects p
JOIN employees e
  ON p.emp_id = e.emp_id;
