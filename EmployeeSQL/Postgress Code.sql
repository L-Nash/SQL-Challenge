
Drop Table Employees;

CREATE TABLE Employees (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" Varchar(5)   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" Varchar(50)   NOT NULL,
    "last_name" Varchar(50)   NOT NULL,
    "sex" Varchar(1)   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);
Drop Table "Salaries";
CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);
Drop Table "Titles";
CREATE TABLE "Titles" (
    "title_id" Varchar(50)   NOT NULL,
    "title" Varchar(50)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);
Drop Table "Departments" cascade;
CREATE TABLE "Departments" (
    "dept_no" Varchar(6)   NOT NULL,
    "dept_name" Varchar(50)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no","dept_name")
);
Drop Table "Dept_emp";
CREATE TABLE "Dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" Varchar(4)   NOT NULL,
   );
   
Drop Table "Dept_manager";
CREATE TABLE "Dept_manager" (
    "dept_no" Varchar(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
 );

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_title_id" FOREIGN KEY("title_id")
REFERENCES "Employees" ("emp_title_id");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");


--1. List the employee number, last name, first name, sex, and salary of each employee.
Select employees.emp_no, employees.last_name, employees.first_name, employees.sex, s.salary
From employees
Inner Join "Salaries" as s
on employees.emp_no = s.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.

Select first_name, last_name, hire_date
From employees where hire_date between '1986-01-01' and '1986-12-31';


--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
Select dm.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
From "Dept_manager" as  dm
Inner Join "Departments" as d
on dm.dept_no = d.dept_no
Inner Join "employees" as e 
on dm.emp_no = e.emp_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
Select d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
From "employees" as e
Inner Join "Dept_emp" as de 
on e.emp_no = de.emp_no
Inner Join "Departments" as d
on de.dept_no = d.dept_no;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
Select first_name, last_name, sex
from "employees"
where first_name = 'Hercules' and last_name like 'B%';

--6. List each employee in the Sales department, including their employee number, last name, and first name.
Select emp_no, last_name, first_name
from "employees"
Where emp_no in (Select emp_no
				from "Dept_emp"
				Where dept_no in
					(Select dept_no
					from "Departments"
					Where dept_name = 'Sales'));
					
--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

Select e.emp_no, e.last_name, e.first_name, d.dept_name
from "employees" e
inner join "Dept_emp" de
on e.emp_no = de.emp_no
inner join "Departments" d 
on de.dept_no = d.dept_no
Where dept_name = 'Sales' or dept_name ='Development';

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

Select last_name, count(last_name)
from employees
group by last_name
order by count(last_name) desc;