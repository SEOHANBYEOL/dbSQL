SELECT *
FROM countries;

SELECT *
FROM regions;


--008
SELECT countries.region_id, regions.region_name, countries.country_name
FROM countries, regions
WHERE countries.region_id = regions.region_id
AND regions.region_name ='Europe';


--009
SELECT  countries.region_id, regions.region_name, countries.country_name, locations.city
FROM countries, regions, locations
WHERE countries.region_id = regions.region_id 
AND countries.country_id = locations.country_id
AND regions.region_name ='Europe';

--010
SELECT  countries.region_id, regions.region_name, countries.country_name, locations.city, departments.DEPARTMENT_NAME
FROM countries, regions, locations, departments
WHERE countries.region_id = regions.region_id 
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND regions.region_name ='Europe';

SELECT  countries.region_id, regions.region_name, countries.country_name, locations.city, departments.DEPARTMENT_NAME
FROM countries JOIN regions ON (countries.region_id = regions.region_id)
               JOIN locations ON(countries.country_id = locations.country_id)
               jOIN departments ON(locations.location_id = departments.location_id AND regions.region_name ='Europe' );


--011
SELECT  countries.region_id, regions.region_name, countries.country_name, locations.city, departments.DEPARTMENT_NAME, concat(employees.FIRST_NAME, employees.last_name)
FROM countries, regions, locations, departments, employees
WHERE countries.region_id = regions.region_id 
AND countries.country_id = locations.country_id
AND locations.location_id = departments.location_id
AND departments.department_id = employees.department_id
AND regions.region_name ='Europe';

--012
SELECT employees.EMPLOYEE_ID, concat(employees.first_name, employees.last_name),jobs.JOB_ID,jobs.JOB_TITLE
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

--013
SELECT  a.*,j.job_title
    FROM
    (SELECT e.manager_id, concat(m.first_name, m.last_name)mgr_name, e.employee_id, concat(e.first_name, e.last_name)name,e.job_id
    FROM employees e, employees m
    WHERE e.manager_id = m.employee_id)a, jobs j
WHERE a.job_id = j.job_id;


SELECT  a.*,j.job_title
    FROM
    (SELECT e.manager_id, concat(m.first_name, m.last_name)mgr_name, e.employee_id, concat(e.first_name, e.last_name)name, e.job_id
    FROM employees e JOIN employees m
    ON e.manager_id = m.employee_id)a, jobs j
WHERE a.job_id = j.job_id;


SELECT *
FROM employees;

SELECT *
FROM jobs;