	--CREATING THE COMPANY
	CREATE DATABASE CompanyJK
USE CompanyJK


---CREATING THE SCHEMA
CREATE SCHEMA JK


--CREATING THE TABLE FOR DEPARTMENT INSIDE THE SCHEMA
CREATE TABLE JK.Department (
NUM_S INT PRIMARY KEY,
Label VARCHAR(255),
Manager_Name VARCHAR(255)
);

--CREATING THE TABLE FOR EMPLOYEE INSIDE THE SCHEMA
CREATE TABLE JK.Employee (
NUM_E INT PRIMARY KEY,
NAME VARCHAR (255),
POSITION VARCHAR(255),
SALARY DECIMAL(10,2),
Department_NUM_S INT,

 FOREIGN KEY( Department_NUM_S)
REFERENCES JK.Department (NUM_S)
);

--CREATING THE TABLE FOR PROJECT INSIDE THE SCHEMA
CREATE TABLE JK.Project (
NUM_P INT PRIMARY KEY,
Title VARCHAR (255),
Start_Date DATE,
End_Date DATE,
Department_NUM_S INT, 

FOREIGN KEY (Department_NUM_S)
REFERENCES JK.Department(NUM_S)
);

--CREATING THE TABLE FOR EMPLOYEE_PROJECT INSIDE THE SCHEMA
CREATE TABLE JK.Employee_Project (
NUM_E INT,
NUM_P INT,
Role VARCHAR (255),

PRIMARY KEY (NUM_E,NUM_P),

FOREIGN KEY (NUM_E)
REFERENCES JK.Employee (NUM_E),

FOREIGN KEY (NUM_P)
REFERENCES JK.Project (NUM_P)
);


--ADDING ROLE Column to the table above 
ALTER TABLE JK.Employee_Project
ADD Role varchar(255);



--INSERTING VALUES INTO DEPARTMENT TABLE
INSERT INTO JK.Department 
VALUES 
(1,'IT','Alice_Johnson'),
(2,'HR','Bob_Smith'),
(3,'Marketing','Clara_Bennett');

--INSERTING VALUES INTO EMPLOYEE TABLE
INSERT INTO JK.Employee
VALUES
(101,'John Doe','Developer',60000.00,1),
(102,'Jane Smith','Analyst',55000.00,2),
(103,'Mike Brown','Designer',50000.00,3),
(104,'Sarah Johnson','Data Scientist',70000.00,1),
(105,'Emma Wilson',	'HR Specialist',52000.00,2);


--INSERTING VALUES INTO project TABLE
INSERT INTO JK.Project
VALUES
(201,'Web Redesign','2024-01-15','2024-06-30',1),
(202,'Eployee Onboarding','2024-03-01','2024-09-01',2),
(203,'Market Research','2024-02-01','2024-07-31',3),
(204,'IT Infrastructure Setup','2024-04-01','2024-12-31',1);

--INSERTING INTO EMPLOYEE PROJECT TABLE
INSERT INTO JK.Employee_Project
VALUES
(101,201,'Frontend Developer'),
(104,201,'Backend Developer'),
(102,202,'Trainer'),
(105,202,'Coordinator'),
(103,203,'Research Lead'),
(101,204,'Network Specialist');


--CHANGING THE ROLE OF AN EMPLOYEE IN EMPLOYEE PROJECT TABLE 
UPDATE JK.Employee_Project
SET Role= 'Full Stack Developer'
WHERE NUM_E = 101 AND NUM_P=201

--	DELETING A RECORD 
DELETE FROM JK.Employee_Project
where NUM_E= 103

DELETE FROM JK.Employee
WHERE NUM_E=103




--a query to retrieve the names of employees who are assigned to more than one project, including the total number of projects for each employee.
SELECT E.NAME,E.NUM_E, COUNT (EP.NUM_P) AS Total_Projects
FROM JK.Employee E
JOIN JK.Employee_Project EP
ON E.NUM_E=EP.NUM_E
GROUP BY E.NAME,E.NUM_E
HAVING COUNT (EP.NUM_P) > 1

--Write a query to retrieve the list of projects managed by each department, including the department label and manager’s name.
SELECT P.Title,D.Label, D.Manager_Name
from JK.Project P
JOIN JK.Department D
ON P.Department_NUM_S =D.NUM_S
GROUP BY P.Title,D.Label,D.Manager_Name

--Write a query to retrieve the names of employees working on the project "Website Redesign," including their roles in the project.

SELECT E.NAME,EP.Role                        
FROM JK.Employee E                          
JOIN JK.Employee_Project EP
ON E.NUM_E=EP.NUM_E
JOIN JK.Project P
ON EP.NUM_P=P.NUM_P
WHERE P.Title='Web Redesign'

select distinct e.NAME,p.Title,ep.role
from jk.Employee e
join jk.Employee_Project ep
on e.NUM_E =ep.NUM_E
join jk.Project p
on ep.NUM_P = p.NUM_P
where p.Title = 'Web Redesign'

 

--Write a query to retrieve the department with the highest number of employees, including the department label, manager name, and the total number of employees.


select D.Label,D.Manager_Name,COUNT(E.NUM_E) AS Total_number_of_employees
from jk.Department D 
join jk.Employee E
on D.NUM_S=E.Department_NUM_S
GROUP BY D.Label,D.Manager_Name
ORDER BY COUNT(E.NUM_E) DESC;




--Write a query to retrieve the names and positions of employees earning a salary greater than 60,000, including their department names.
SELECT e.NAME,e.POSITION,d.Label
from JK.Employee e
JOIN JK.Department d
ON e.Department_NUM_S=d.NUM_S
where e.SALARY > 60000.00
group by e.NAME,e.POSITION,d.Label
  

     --Write a query to retrieve the number of employees assigned to each project, including the project title.
     select p.Title, count(e.NUM_E) AS number_of_employees
     from jk.Project p
     join   jk.Employee_Project ep
     on p.NUM_P= ep.NUM_P
     join jk.Employee e 
     on ep.NUM_E = e.NUM_E
     group by p.Title;

     



   

--Write a query to retrieve a summary of roles employees have across different projects, including the employee name, project title, and role.
select e.NAME,ep.Role,p.Title
from jk.Employee e
join jk.Employee_Project ep
on e.NUM_E=ep.NUM_E
join jk.Project p
on ep.NUM_P=p.NUM_P
group by e.NAME,p.Title,ep.Role;

--Write a query to retrieve the total salary expenditure for each department, including the department label and manager name.

select d.Label, d.Manager_Name,sum(e.salary) as Total_Salary_Expenditure
from JK.Department d
left join jk.Employee e 
on d.NUM_S = e.Department_NUM_S
group by d.Label, d.Manager_Name






SELECT * FROM JK.Employee
SELECT * FROM JK.Department
SELECT * FROM JK.Project
SELECT * FROM JK.Employee_Project

   
