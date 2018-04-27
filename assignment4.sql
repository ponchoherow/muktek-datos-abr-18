

#1 Write a query to find the name (FIRST_NAME, LAST_NAME) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest. Employees
SELECT FIRST_NAME, LAST_NAME, SALARY, JOB_ID FROM Employees
WHERE SALARY > (SELECT MAX(SALARY) FROM Employees WHERE job_id = 'SH_CLERK')
ORDER BY SALARY;

#2 Write a query to find the name (FIRST_NAME, LAST_NAME) of the employees who are not supervisors. Employees
SELECT b.FIRST_NAME,b.LAST_NAME  FROM Employees b 
WHERE NOT EXISTS (SELECT 'X' FROM Employees a WHERE a.MANAGER_id = b.EMPLOYEE_id);



#3 Write a query to display the employee ID, first name, last name, and department names of all employees. Employees, Departments
SELECT employee_id, first_name, last_name, (SELECT department_name FROM Departments d
WHERE e.department_id = d.department_id) department FROM Employees e ORDER BY department;



 #4 Write a query to fetch even numbered records from employees table. Employees
 SET @i = 0; 
SELECT i, employee_id 
FROM (SELECT @i := @i + 1 AS i, employee_id FROM Employees)
a WHERE MOD(a.i, 2) = 0;

#5 Write a query to find the 5th maximum salary in the employees table. Employees
SELECT DISTINCT SALARY FROM Employees e1 
WHERE 5 = (SELECT COUNT(DISTINCT SALARY) FROM Employees  e2 
WHERE e2.salary >= e1.salary);


#6 Write a query to find the 4th minimum salary in the employees table. Employees
SELECT DISTINCT SALARY 
FROM Employees empleados1
WHERE 4 = (SELECT COUNT(DISTINCT salary) 
FROM Employees  empleados2 
WHERE empleados2.salary <= empleados1.salary);



#7 Write a query to select last 10 records from a table. Employees
SELECT * FROM (
SELECT * FROM Employees ORDER BY EMPLOYEE_ID DESC LIMIT 10) sub ORDER BY EMPLOYEE_ID ASC;


#8 Write a query to list the department ID and name of all the departments where no employee is working. Employees, Departments
SELECT * FROM Departments 
WHERE DEPARTMENT_ID
NOT IN (select department_id FROM Employees);

#9 Write a query to get 3 maximum salaries. Employees
SELECT DISTINCT SALARY FROM Employees a 
WHERE 3 >= (SELECT COUNT(DISTINCT SALARY) FROM Employees b 
WHERE b.salary >= a.salary) 
ORDER BY a.salary DESC;


#10 Write a query to get 3 minimum salaries. Employees
SELECT DISTINCT SALARY FROM Employees a 
WHERE  3 >= (SELECT COUNT(DISTINCT salary)  FROM Employees b 
WHERE b.salary <= a.salary) 
ORDER BY a.salary DESC;



############ Y hacer los siguientes queries por join:



#1 Write a query to get the department name and number of employees in the department.
SELECT department_name AS 'Departments', COUNT(*) AS '# Employees' FROM Departments 
INNER JOIN Employees ON Employees.department_id = Departments.department_id 
GROUP BY Departments.department_id, department_name 
ORDER BY department_name;

#2 Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history.
SELECT EMPLOYEE_ID, JOB_TITLE, END_DATE-START_DATE Days FROM JobHistory 
NATURAL JOIN Jobs 
WHERE department_id=90;

#3 Write a query to display the department ID and name and first name of manager.
SELECT d.department_id, d.department_name, d.manager_id, e.first_name FROM Departments d 
INNER JOIN Employees e 
ON (d.manager_id = e.employee_id);

#4 Write a query to display the department name, manager name, and city.
SELECT d.department_name, e.first_name, l.city FROM Departments d 
JOIN Employees e ON (d.manager_id = e.employee_id) 
JOIN Locations l USING (location_id);


#5 Write a query to display the job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY) FROM Employees 
NATURAL JOIN Jobs 
GROUP BY JOB_TITLE;


#6 Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
SELECT JOB_TITLE, FIRST_NAME, SALARY-min_salary 'SALARIO - SALARIO MINIMO' FROM Employees 
NATURAL JOIN Jobs;

#7 Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
SELECT a.* FROM JobHistory a 
JOIN Employees e ON (a.employee_id = e.employee_id) 
WHERE SALARY > 10000;

8#Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
FROM Departments d, Employees e, JobHistory jh
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
AND YEAR(END_DATE - START_DATE) > 15
AND d.MANAGER_ID = e.MANAGER_ID;