-- SQL Basics to advanced techniques for Data Analysts video series code

CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

INSERT INTO EmployeeDemographics VALUES
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

-- Select Statements: *, Top, Distinct, Count, As, Max, Min, Avg

SELECT *
FROM EmployeeDemographics

SELECT TOP 5 *
FROM EmployeeDemographics

SELECT DISTINCT(EmployeeID)
FROM EmployeeDemographics

SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT MIN(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

-- Using master

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

-- Where Statements: =, <>, <, >, And, Or, Like, Null, Not Null, In

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim' -- <> = Doesn't equal

SELECT *
FROM EmployeeDemographics
WHERE Age < 30 AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Age > 30 OR Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%' -- Every last name that starts with an S. Use 'LIKE' to find data to your needs.

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%o%' -- You can use LIKE for numeric values as well.

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

-- Group by, Order by

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC

SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC

SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY Gender ASC -- You can order by descending or ascending with 'DESC' or 'ASC'.

-- Inner Joins, Full / Left / Right / Outer Joins

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeSalary

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Right Outer Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Left Outer Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Full Outer Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, lastName, Salary
FROM SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

-- Union, Union All

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM SQLTutorial.dbo.WareHouseEmployeeDemographics
ORDER BY EmployeeID

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
Full outer Join SQLTutorial.dbo.WareHouseEmployeeDemographics
	ON EmployeeDemographics.EmployeeID =
	WareHouseEmployeeDemographics.EmployeeID

-- Case Statements

SELECT FirstName, LastName, Age,
CASE
	WHEN Age = 38 THEN 'Stanley'
	WHEN Age > 30 THEN 'Old'
	ELSE 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
	ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- Having Clause

SELECT JobTitle, COUNT(JobTitle)
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM SQLTutorial.dbo.EmployeeDemographics
JOIN SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(SALARY) > 4500
ORDER BY AVG(Salary)

-- Updating and deleting data

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET Age = 31
WHERE FirstName = 'Darryl' AND LastName = 'Philbin'

-- Do a select all before activating the delete to make sure you are deleting exactly what you want.
-- Be very careful with the DELETE tool.

SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

-- DELETE FROM SQLTutorial.dbo.EmployeeDemographics
-- WHERE EmployeeID = 1005

-- Aliasing

SELECT FirstName AS Fname
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT FirstName + ' ' + LastName AS FullName
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT AVG(Age) AS AvgAge
FROM [SQLTutorial].[dbo].[EmployeeDemographics]

SELECT Demo.EmployeeID, Sal.Salary
FROM [SQLTutorial].[dbo].[EmployeeDemographics] AS Demo
JOIN [SQLTutorial].[dbo].[EmployeeSalary] AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.FirstName, Sal.JobTitle, Ware.Age
FROM [SQLTutorial].[dbo].[EmployeeDemographics] AS Demo
LEFT JOIN [SQLTutorial].[dbo].[EmployeeSalary] AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQLTutorial].[dbo].WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID

-- Partion By

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER(PARTITION BY Gender) AS TotalGender
FROM SQLTutorial..EmployeeDemographics AS dem
JOIN SQLTutorial..EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID

-- Difference

SELECT Gender, COUNT(Gender)
FROM SQLTutorial..EmployeeDemographics AS dem
JOIN SQLTutorial..EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender

-- CTE: Common table expression

WITH CTE_Employee as
(
	SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER(PARTITION BY Gender) AS TotalGender,
	AVG(Salary) OVER(PARTITION BY Gender) As AvgSalary
	FROM SQLTutorial..EmployeeDemographics AS emp
	JOIN SQLTutorial..EmployeeSalary AS sal
		ON emp.EmployeeID = sal.EmployeeID
	WHERE Salary > '4500'
)
Select FirstName, AvgSalary
FROM CTE_employee

-- Temp Tables

CREATE TABLE #temp_Employee
(
	EmployeeID int,
	JobTitle varchar(100),
	Salary int
)

Insert Into #Temp_employee
Select JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
From SQLTutorial..EmployeeDemographics emp
Join SQLTutorial..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
Group by JobTitle

Select *
From #temp_Employee

Insert into #temp_Employee values
(
	'1001', 'HR', '45000'
)

Insert into #temp_Employee
Select *
From SQLTutorial..EmployeeSalary

Drop TABLE If exists #temp_Employee2
Create TABLE #Temp_employee2
(
	JobTitle varchar(50),
	EmployeesPerJob int,
	AvgAge int,
	AvgSalary int
)

Insert Into #Temp_employee2
Select JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
From SQLTutorial..EmployeeDemographics emp
Join SQLTutorial..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
Group by JobTitle

Select *
From #Temp_employee2


-- String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

-- Drop table EmployeeErrors

Create Table EmployeeErrors
(
	EmployeeID varchar(50),
	FirstName varchar(50),
	LastName varchar(50),
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Delete from EmployeeErrors

Select *
From EmployeeErrors

-- Using Trim, LTRIM, and RTRIM

Select EmployeeID, Trim(EmployeeID) as IDTRIM
From EmployeeErrors

Select EmployeeID, Ltrim(EmployeeID) as IDLTRIM
From EmployeeErrors

Select EmployeeID, Rtrim(EmployeeID) as IDRTRIM
From EmployeeErrors

-- Replace

Select LastName, Replace(LastName, '- Fired', '') as LastNameFixed
From EmployeeErrors

-- Using substring

Select err.FirstName, substring(err.FirstName, 1, 3), dem.FirstName, substring(dem.FirstName, 1, 3)
From EmployeeErrors as err
Join EmployeeDemographics as dem
	on substring(err.FirstName, 1, 3) = substring(dem.FirstName, 1, 3)

-- Possible applications and matching using substrings: use columns gender, lastname, age, date of birth

-- Using upper and lower

Select FirstName, Lower(FirstName)
From EmployeeErrors

Select FirstName, upper(FirstName)
From EmployeeErrors

-- Stored Procedures

Create procedure test
as
Select *
From EmployeeDemographics

exec test

CREATE PROCEDURE avgStats
AS
DROP TABLE IF EXISTS #avgstats
Create table #avgstats (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #avgstats
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics as emp
JOIN SQLTutorial..EmployeeSalary as sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #avgstats

-- Subqueries

select *
From EmployeeSalary

-- Subquery in select

select EmployeeID, Salary, (Select Avg(Salary) From EmployeeSalary)
From EmployeeSalary

-- How to do it with partition by

select EmployeeID, Salary, (Select Avg(Salary) From EmployeeSalary)
From EmployeeSalary

-- why group by doesn't work

select EmployeeID, Salary, (Select Avg(Salary) as AllAvgSalary)
From EmployeeSalary
Group by EmployeeID, Salary
Order by 1, 2

-- Subquery in from

Select a.EmployeeID, AllAvgSalary
From(select EmployeeID, Salary, Avg(Salary) over() as AllAvgSalary From EmployeeSalary) a

-- Subquery in where

select EmployeeID, JobTitle, Salary
From EmployeeSalary
Where EmployeeID in (Select EmployeeID From EmployeeDemographics Where Age > 30)