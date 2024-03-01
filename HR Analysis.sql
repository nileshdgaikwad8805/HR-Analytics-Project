-- ----------------------------------------------------------Attrition Analysis:---------------------------------------------------------------------------------
select * from hr2;
select * from hr_1;

-- -------------------Attrition rate --------------------------------------


-- overall attrition rate in the company?
select count(Attrition) as CountOfAttrition 
from hr_1 
where Attrition = 'Yes';

select count(case when Attrition = 'Yes' then 1 End)/ count(Attrition) As Attritionrate  
from hr_1;

--  attrition rate vs different departments?
select Department,count(Attrition) as CountOfAttrition 
from hr_1 
where Attrition = 'Yes'  
group by Department 
order by CountOfAttrition;

--  breakdown of attrition by gender?
select gender,count(Attrition) as CountOfAttrition 
from hr_1 
where Attrition = 'Yes' 
group by gender 
order by CountOfAttrition;

-- ----------------------------------------------------Salary and Compensation: ----------------------------------------------------------------------

--  average monthly income in the company?
select avg(MonthlyIncome) as AverageOfMonthlyIncome 
from hr2;

-- monthly income differ between different job roles?
select JobRole, avg(MonthlyIncome) as AverageOfMonthlyIncome 
from hr_1 inner join hr2 on hr_1.EmployeeNumber = hr2.EmployeeID 
group by JobRole 
order by AverageOfMonthlyIncome;

-- Average Hourly rate of male Research Scientist
SELECT jobRole,AVG(HourlyRate) AS AvgHourlyRate
FROM hr_1
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';


-- attrition with monthly income
SELECT
    AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END) AS AvgSalary_Attrition,
    AVG(CASE WHEN Attrition = 'No' THEN MonthlyIncome END) AS AvgSalary_NoAttrition
FROM hr_1 inner join hr2 on hr_1.EmployeeNumber = hr2.EmployeeID;



-- ---------------------------------------------------Employee Tenure:-------------------------------------------------------------------------------

-- average number of years employees have been with the company with respective to departments?
select department,avg(YearsAtCompany) 
from hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber 
group by Department;

-- Average working years for each Department
select department,avg(totalworkingyears) from hr2 join hr_1 on hr2.employeeid=hr_1.employeenumber group by department;
-- --------------------------------------------------Work-Life Balance:------------------------------------------------------------------------------

-- Overall average of Work- Life Balance 
select avg(WorkLifeBalance) as AvgWorkLifeBalance 
from hr2;

-- Overall average of Daily Rate
select avg(DailyRate) as AvgDailyRate 
from hr_1;

-- the average work-life balance score for employees in each department?
select Department,avg(worklifebalance) 
from hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber 
group by Department;

--  job roles vs work-life balance?
select JobRole,avg(worklifebalance) 
from hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber 
group by JobRole;

--  work-life balance vs attrition?
SELECT
    AVG(CASE WHEN Attrition = 'Yes' then WorkLifeBalance END) AS AvgWorkLifeBalace_Attrition,
    AVG(CASE WHEN Attrition = 'No' then WorkLifeBalance END) AS AvgWorkLifeBalance_NoAttrition
FROM hr_1 inner join hr2 on hr_1.EmployeeNumber = hr2.EmployeeID;

-- --------------------------------------------------Promotion Analysis:-----------------------------------------------------------------------------------

--  average time since the last promotion for employees?
select avg(yearsSinceLastPromotion) 
from hr2;

--  attrition rate vary based on the time since the last promotion?
SELECT YearsSinceLastPromotion,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / COUNT(*) AS AttritionRate
FROM hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

-- ------------------------------------------------Diversity and Inclusion:-----------------------------------------------------------------------------------

--  gender distribution across different departments?
select department,gender,count(gender) 
from hr_1 
group by Department,Gender 
order by Department,gender;

-- job roles vs gender diversity?
SELECT
    JobRole,
    COUNT(DISTINCT CASE WHEN Gender = 'Male' THEN EmployeeID END) AS MaleCount,
    COUNT(DISTINCT CASE WHEN Gender = 'Female' THEN EmployeeID END) AS FemaleCount,
    COUNT(DISTINCT EmployeeID) AS TotalCount,
    (COUNT(DISTINCT CASE WHEN Gender = 'Female' THEN EmployeeID END) / COUNT(DISTINCT EmployeeID)) AS FemalePercentage
FROM hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber
GROUP BY JobRole
ORDER BY FemalePercentage DESC;


--  gender diversity  vs attrition rates?
SELECT
    Gender,
    COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) AS AttritionCount,
    COUNT(DISTINCT EmployeeID) AS TotalCount,
    (COUNT(DISTINCT CASE WHEN Attrition = 'Yes' THEN EmployeeID END) / COUNT(DISTINCT EmployeeID)) AS AttritionRate
FROM hr2 inner join hr_1 on hr2.EmployeeID = hr_1.EmployeeNumber
GROUP BY Gender;

