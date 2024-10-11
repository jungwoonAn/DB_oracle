-- 문제1. 사원(employees) 테이블과 직무(jobs), 부서(departments), 위치(locations) 테이블을 INNER JOIN하여
-- 각 사원의 이름(성+이름), 직무명, 부서명, 위치명을 출력하세요.
select * from employees;
select * from jobs;
select * from departments;
select * from locations;

select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", J.job_title, d.department_name, L.city 
from employees E, jobs J, departments D, locations L
where E.job_id=J.job_id and E.department_id=d.department_id and d.location_id=L.location_id
order by E.employee_id;

-- 문제2. 각 부서별로 최소 급여를 받는 사원의 이름(성+이름), 부서명, 급여를 출력하세요.
select department_id, min(salary)
from employees
group by department_id
order by department_id;

select concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", E.department_id, D.department_name, min_sal.salary
from (select department_id, min(salary) salary
      from employees
      group by department_id) min_sal, departments D, employees E
where min_sal.department_id=E.department_id and min_sal.department_id=D.department_id and min_sal.salary=E.salary
order by D.department_id;

-- 문제3. 사원(employees) 테이블과 부서(departments), 매니저(employees) 테이블을 INNER JOIN하여
-- 각 사원의 이름(성+이름), 부서명, 그리고 그 사원의 매니저 이름(성+이름)을 출력하세요.
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", d.department_name, concat(M.first_name, concat(' ', M.last_name)) as "매니저 이름"
from employees E, departments D, employees M
where E.department_id=D.department_id(+) and e.manager_id=M.employee_id(+)
order by E.employee_id;

-- 문제4. 사원(employees) 테이블과 직무(jobs) 테이블을 JOIN하여 각 직무별 사원 수와 평균 급여를 출력하세요.
select * from employees;
select * from jobs;

select job_id, count(*), avg(salary)
from employees
group by job_id;

select distinct E.job_id, J.job_title, count(*) over(partition by E.job_id), avg(salary) over(partition by E.job_id)
from employees E, jobs J
where E.job_id=J.job_id;

select E.job_id, J.job_title, E.count, E.avg_sal
from (select job_id, count(*) count, avg(salary) avg_sal
      from employees
      group by job_id) E, jobs J
where E.job_id=J.job_id;

-- 문제5. 고용일(hire_date)이 2005년 이후인 사원 이름(성+이름), 직무명, 부서명을 출력하세요.
select * from employees where hire_date >= '05/01/01' order by hire_date;
select * from jobs;
select * from departments;

select concat(E.first_name, concat(' ', E.last_name)) as "사원 이름", E.hire_date, J.job_title, D.department_name 
from employees E, jobs J, departments D
where E.job_id=J.job_id and E.department_id=D.department_id(+) and E.hire_date >= '05/01/01'
order by E.hire_date;