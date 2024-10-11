-- 문제1.사원(employees)테이블에서 각 사원의 이름(성+이름)과 그 사원의 매니저 이름(성+이름)을 출력하세요.
-- 매니저가 없는 경우 NULL로 표시하세요.
select * from employees;
-- oracle join
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", concat(M.first_name, concat(' ', M.last_name)) as "매니저 이름" 
from employees E, employees M
where E.manager_id = M.employee_id(+)
order by E.employee_id;
-- ANSI join
select E.employee_id, E.first_name||' '||E.last_name as "사원 이름", M.first_name||' '||M.last_name as "매니저 이름" 
from employees E
left join employees M
on E.manager_id = M.employee_id
order by E.employee_id;

-- 문제2. 사원(employees)테이블과 부서(departments)테이블을 INNER JOIN하여
-- 사원의 이름(성+이름), 부서명, 부서 위치를 출력하세요.
select * from employees;
select * from departments;

select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", d.department_name, d.location_id
from employees E, departments D
where E.department_id = D.department_id
order by E.employee_id;

-- 문제3. 사원(employees)테이블과 부서(departments), 위치(locations)테이블을 INNER JOIN하여
-- 각 사원의 이름(성+이름), 부서명, 부서 위치명을 출력하세요.
select * from employees;
select * from departments;
select * from locations;
-- oracle join
select concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", D.department_name, L.city
from employees E, departments D, locations L
where E.department_id = D.department_id and D.location_id = L.location_id;
--ANSI join
select E.employee_id, E.first_name||' '||E.last_name as "사원 이름", D.department_name, L.city
from employees E
join departments D on E.department_id = D.department_id
join locations L on D.location_id = L.location_id;

-- 문제4. 사원(employees)테이블과 직무(jobs), 부서(departments)테이블을 INNER JOIN하여
-- 각 사원의 이름(성+이름), 직무명, 부서명을 출력하세요.
select * from employees;
select * from jobs;
select * from departments;
-- oracle join
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", J.job_title, D.department_name
from employees E, jobs J, departments D
where E.job_id = J.job_id and E.department_id = D.department_id
order by E.employee_id;
-- ANSI join
select E.employee_id, E.employee_id, E.first_name||' '||E.last_name as "사원 이름", J.job_title, D.department_name
from employees E
join jobs J on E.job_id = J.job_id
join departments D on E.department_id = D.department_id
order by E.employee_id;

-- 문제5. 사원(employees)테이블과 직무(jobs)테이블을 JOIN하여
-- 각 사원의 이름(성+이름), 직무명, 사원의 급여와 직무별 평균 급여를 출력하세요.
select * from employees;
select * from jobs;

select job_id, avg(salary) from employees group by job_id;
-- oracle join(sub query)
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", J.job_title, E.salary, A.avg_sal
from employees E, jobs J, (select job_id, avg(salary) avg_sal from employees group by job_id) A
where E.job_id = J.job_id and J.job_id = A.job_id
order by E.employee_id;
-- ANSI join
select E.employee_id, E.employee_id, E.first_name||' '||E.last_name as "사원 이름", J.job_title, E.salary,
       avg(E.salary) over(partition by e.job_id) avg_sal
from employees E
join jobs J on E.job_id = J.job_id
order by E.employee_id;