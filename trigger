CREATE TABLE employee_salary(
emp_id NUMBER,
salary NUMBER,
emp_name VARCHAR2(50)
);

CREATE TABLE employee_salary_log(
emp_id NUMBER,
new_salary NUMBER,
updated_date DATE,
updated_by VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trg_log
AFTER UPDATE OF salary ON employee_salary
FOR EACH ROW
DECLARE
   username VARCHAR2(20);
BEGIN
   SELECT USER INTO username FROM dual;
   INSERT INTO employee_salary_log
   VALUES(:NEW.emp_id, :NEW.salary, SYSDATE, username);
END;
/

INSERT INTO employee_salary VALUES(201,40000,'Vikram');

UPDATE employee_salary
SET salary = 30000
WHERE emp_id = 201;

COMMIT;
