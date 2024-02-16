-- query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table
select emp_id, FIRST_NAME, LAST_NAME, GENDER, DEPT 
from emp_record_table;

-- query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
-- less than two

select emp_id, FIRST_NAME, LAST_NAME, GENDER, DEPT 
from emp_record_table
where emp_rating < 2;

-- 	greater than four 

select emp_id, FIRST_NAME, LAST_NAME, GENDER, DEPT 
from emp_record_table
where emp_rating > 4;

-- 	between two and four

select emp_id, FIRST_NAME, LAST_NAME, GENDER, DEPT 
from emp_record_table
where emp_rating between 2 and 4;

-- A query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department 
-- from the employee table and then give the resultant column alias as NAME

Select concat(first_name,' ', last_name)
from emp_record_table
where DEPT = 'finance';

-- a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

SELECT e.emp_ID, e.FIRST_NAME, e.LAST_NAME, COUNT(r.emp_ID) + 1 AS num_reporters
FROM emp_record_table e
LEFT JOIN emp_record_table r ON e.EMP_ID = r.manager_ID
GROUP BY e.emp_ID, e.FIRST_NAME, e.LAST_NAME
HAVING COUNT(r.emp_ID) > 0;

-- Write a query to list down all the employees from the healthcare and finance departments using union.

SELECT emp_id, first_name, last_name, dept
FROM emp_record_table 
WHERE dept = 'healthcare'
UNION
SELECT emp_id, first_name, last_name, dept
FROM emp_record_table 
WHERE dept = 'finance';

-- query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept
-- Also include the respective employee rating along with the max emp rating for the department.

Select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
    (SELECT MAX(EMP_RATING) FROM emp_record_table e2 WHERE e1.dept = e2.dept) AS max_emp_rating
FROM emp_record_table e1;

-- Write a query to calculate the minimum and the maximum salary of the employees in each role

SELECT 
    role,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary 
FROM 
    emp_record_table
GROUP BY 
    role;

-- a query to assign ranks to each employee based on their experience. Take data from the employee record table.

SELECT 
    EMP_ID, 
    FIRST_NAME, 
    EXP,
    DENSE_RANK() OVER (ORDER BY EXP DESC) AS experience_rank
FROM 
    emp_record_table;

-- a query to create a view that displays employees in various countries whose salary is more than six thousand.

Create view high_salary_employee as
select EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
from emp_record_table
where SALARY > 6000;

Select * from high_salary_employees;

-- a nested query to find employees with experience of more than ten years

SELECT 
    EMP_ID, 
    FIRST_NAME, 
    EXP
FROM 
    emp_record_table
WHERE 
    EXP > 10; 

-- Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years.

DELIMITER //

CREATE PROCEDURE GetEmployeesWithExperiencee()
BEGIN
    SELECT 
        EMP_ID, 
        FIRST_NAME, 
        LAST_NAME, 
        EXP
    FROM 
        emp_record_table
    WHERE 
        EXP > 3;
END //

DELIMITER ;


CALL GetEmployeesWithExperiencee;

-- •	Write a query to calculate the bonus for all the employees, based on their ratings and salaries

select emp_id, FIRST_NAME,
SALARY, 
EMP_RATING,
0.5* SALARY *EMP_RATING as BONUS
from emp_record_table;

-- a query to calculate the average salary distribution based on the continent and country

Select 
continent, 
country,
avg(SALARY) as Average_salary
from emp_record_table
group by CONTINENT, COUNTRY;
