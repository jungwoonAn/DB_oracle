-- 1. 카티션 곱(Cartesian Product)
select * from employees;  -- 107행
select count(*) from employees;
select * from departments;  -- 27행
select count(*) from departments;
select * from employees, departments;  -- 107*27 = 2889행
select count(*) from employees, departments;

-- 2. 동등 조인(Equi Join): 조인 조건이 일치하는 것만 조회(내부 조인)
-- 오라클 조인
select * from jobs, job_history
where jobs.job_id = job_history.job_id;

-- ANSI 조인
select * from jobs
inner join job_history on jobs.job_id = job_history.job_id;

select * from countries C, locations L
where C.country_id = L.country_id;

select * from employees E, departments D
where E.department_id = D.department_id;

-- 3. 비동등 조인(Non Equi Join): 동일한 컬럼 없이 다른 조건으로 조인
select * from employees E, jobs J
where E.salary between J.min_salary and J.max_salary
order by employee_id;

select E.first_name, E.hire_date, H.start_date, H.end_date
from employees E, job_history H
where E.hire_date between H.start_date and H.end_date;

-- 4. 외부 조인(Outer Join): 조인 조건을 만족하지 않는 행도 출력(동등 조인 조건시 누락된 행을 출력할 때 사용)
-- 오라클 조인
select * from jobs J, job_history H
where J.job_id = H.job_id(+);

-- ANSI 조인
select * from jobs J
left join job_history H on J.job_id = H.job_id;

select * from countries C, locations L
where C.country_id = L.country_id(+);

select * from countries C
left join locations L on C.country_id = L.country_id;

select * from employees E, departments D
where E.department_id(+) = D.department_id;

select * from employees E
right join departments D on E.department_id = D.department_id;

-- 5. 자체 조인(Self Join): 자기 자신의 테이블과 조인
select E.first_name, E.last_name, M.first_name, M.last_name
from employees E, employees M
where E.manager_id = M.employee_id;

-- [실습] JOIN
-- countries 테이블과 locations 테이블을 country_id를 기준으로 조인하여
-- country_name, state_province, street_address를 조회
select * from countries;
select * from locations;

select C.country_name, L.state_province, L.street_address
from countries C, locations L
where C.country_id = L.country_id;

-- jobs 테이블과 job_history 테이블을 job_id를 기준으로 조인하여
-- job_id, job_title, start_date, end_date를 조회
select * from jobs;
select * from job_history;

select J.job_id, J.job_title, H.start_date, H.end_date
from jobs J, job_history H
where J.job_id = H.job_id;

-- employees 테이블과 departments 테이블을 department_id 기준으로 조인하고, 
-- employees 테이블과 jobs 테이블을 job_id 기준으로 조인하여 
-- first_name, last_name, department_name, job_title을 조회
select * from employees;
select * from departments;
select * from jobs;

select E.first_name, E.last_name, D.department_name, J.job_title
from employees E, departments D, jobs J
where E.department_id = D.department_id and E.job_id = J.job_id;

-- countries 테이블과 locations 테이블을 locations의 country_id를 기준으로 외부 조인하여
-- country_id, country_name, city를 조회
select * from countries;
select * from locations;

select C.country_id, C.country_name, L.city
from countries C, locations L
where C.country_id = L.country_id(+);

-- employees 테이블과 departments 테이블을 departments 테이블의 department_id를 기준으로 외부 조인하여
-- employee_id, first_name, last_name, department_name을 employee_id를 기준으로 정렬하여 조회
select * from employees;
select * from departments;

select E.employee_id, E.first_name, E.last_name, D.department_name
from employees E, departments D
where E.department_id = D.department_id(+)
order by E.employee_id;

-- employees 테이블을 manager_id와 employee_id를 기준으로 자체 조인한 뒤에 
-- 직원의 first_name과 last_name을 결합하고 관리자의 first_name과 last_name을 결합하여
-- employee_id를 기준으로 정렬하여 조회
select E.employee_id, E.first_name||' '||E.last_name, M.first_name||' '||M.last_name
from employees E, employees M
where E.manager_id = M.employee_id
order by E.employee_id; 