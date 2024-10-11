-- 뷰 예제
select * from emp_details_view;

-- 2. CREATE OR REPLACE VIEW
-- 뷰를 생성할 테이블 확인
select * from employees;

-- 뷰 생성
create view emp_view
as  select employee_id, first_name, last_name, email
    from employees;
    
select * from emp_view;

-- 뷰 생성 및 변경
create or replace view new_employee_view
as  select employee_id, first_name, last_name, email, hire_date, job_id
    from employees
    where employee_id>200;

select * from new_employee_view;

insert into new_employee_view
values (207, 'Suan', 'Lee', 'suan', '21/01/01', 'IT_PROG');

-- 뷰 제거
drop view emp_view;
drop view new_employee_view;

-- 읽기 전용 뷰 생성
create or replace view salary_order_view
as  select first_name, last_name, job_id, salary
    from employees
    order by salary desc
    with read only;

select * from salary_order_view;

-- ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
insert into salary_order_view values ('Suan', 'Lee', 'IT PROG', 10000);

create or replace view job_salary_view
as  select job_id, sum(salary) sum_salary, min(salary) min_salary, max(salary) max_salary
    from employees
    group by job_id
    order by sum(salary)
    with read only;
    
select * from job_salary_view;

-- 뷰 제거
drop view salary_order_view;
drop view job_salary_view;


-- [실습] 뷰 생성
-- employees 테이블에서 07년도에 고용된 직원의 employee_id, first_name, last_name, email, hire_date, 
-- job_id 컬럼 값을 가지는 employee_07_view 이름의 뷰 생성
select * from employees where hire_date like '07/%';

create or replace view employee_07_view
as  select employee_id, first_name, last_name, email, hire_date, job_id
    from employees
    where hire_date like '07/%';
    
select * from employee_07_view;

-- employees 테이블에서 department_id와 job_id로 그룹화하고, 평균 salary가 9000 초과인 직원의
-- department_id, job_id, salary의 평균값인 salary_avg 컬럼 값을 가지며
-- 평균 salary 값이 높은 순으로 정렬한 high_salary_view 이름의 읽기 전용 뷰 생성
select department_id, job_id, avg(salary) salary_avg
from employees
where salary>9000 
group by department_id, job_id
order by avg(salary) desc;

create or replace view high_salary_view
as  select department_id, job_id, avg(salary) salary_avg
    from employees
    where salary>9000 
    group by department_id, job_id
    order by avg(salary) desc
    with read only;

select * from high_salary_view;

-- ORA-01732: 뷰에 대한 데이터 조작이 부적합합니다
delete from high_salary_view where job_id='AD_VP';

-- employees 테이블을 manager_id와 employee_id를 기준으로 자체 조인한 뒤에 
-- department_id와 직원의 first_name과 last_name을 결합하고
-- 관리자의 first_name과 last_name을 결합한 뒤에
-- department_id를 기준으로 정렬하여 employee_manager_view 이름의 읽기 전용 뷰 생성
select E.department_id, concat(E.first_name, concat(' ', E.last_name)) 직원,
       concat(M.first_name, concat(' ', M.last_name)) 관리자
from employees E, employees M
where E.manager_id=M.employee_id
order by E.department_id;

create or replace view employee_manager_view
as  select E.department_id, concat(E.first_name, concat(' ', E.last_name)) 직원,
       concat(M.first_name, concat(' ', M.last_name)) 관리자
    from employees E, employees M
    where E.manager_id=M.employee_id
    order by E.department_id
    with read only;
    
select * from employee_manager_view;

-- 뷰 제거
drop view employee_07_view;
drop view high_salary_view;
drop view employee_manager_view;