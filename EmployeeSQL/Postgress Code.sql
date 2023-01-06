
-- Drop Table Employees;

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
-- Drop Table "Salaries";
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
-- Drop Table "Departments";
CREATE TABLE "Departments" (
    "dept_no" Varchar(6)   NOT NULL,
    "dept_name" Varchar(50)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);
-- Drop Table "Dept_emp";
CREATE TABLE "Dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" Varchar(4)   NOT NULL
--     CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
--         "emp_no","dept_no"
--      )
);
-- Drop Table "Dept_manager";
CREATE TABLE "Dept_manager" (
    "dept_no" Varchar(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

-- ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
-- REFERENCES "Dept_emp" ("emp_no");

-- ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_title_id" FOREIGN KEY("title_id")
-- REFERENCES "Employees" ("emp_title_id");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Select * from "Dept_manager";
-- Select * from "Departments";
-- Select * from "Dept_emp";
-- Select * from "Salaries";
Select * from "employees";
-- Select * from "Titles";

--1. List the employee number, last name, first name, sex, and salary of each employee.
Select ("emp_no", "last_name", "first_name", "sex", "salary")
From employees

--2. List the first name, last name, and hire date for the employees who were hired in 1986.

Select ("first_name", "last_name", "hire_date")
From employees where hire_date between '1986-01-01' and '1986-12-31';