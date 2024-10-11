-- 1. īƼ�� ��(Cartesian Product)
select * from employees;  -- 107��
select count(*) from employees;
select * from departments;  -- 27��
select count(*) from departments;
select * from employees, departments;  -- 107*27 = 2889��
select count(*) from employees, departments;

-- 2. ���� ����(Equi Join): ���� ������ ��ġ�ϴ� �͸� ��ȸ(���� ����)
-- ����Ŭ ����
select * from jobs, job_history
where jobs.job_id = job_history.job_id;

-- ANSI ����
select * from jobs
inner join job_history on jobs.job_id = job_history.job_id;

select * from countries C, locations L
where C.country_id = L.country_id;

select * from employees E, departments D
where E.department_id = D.department_id;

-- 3. �񵿵� ����(Non Equi Join): ������ �÷� ���� �ٸ� �������� ����
select * from employees E, jobs J
where E.salary between J.min_salary and J.max_salary
order by employee_id;

select E.first_name, E.hire_date, H.start_date, H.end_date
from employees E, job_history H
where E.hire_date between H.start_date and H.end_date;

-- 4. �ܺ� ����(Outer Join): ���� ������ �������� �ʴ� �൵ ���(���� ���� ���ǽ� ������ ���� ����� �� ���)
-- ����Ŭ ����
select * from jobs J, job_history H
where J.job_id = H.job_id(+);

-- ANSI ����
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

-- 5. ��ü ����(Self Join): �ڱ� �ڽ��� ���̺�� ����
select E.first_name, E.last_name, M.first_name, M.last_name
from employees E, employees M
where E.manager_id = M.employee_id;

-- [�ǽ�] JOIN
-- countries ���̺�� locations ���̺��� country_id�� �������� �����Ͽ�
-- country_name, state_province, street_address�� ��ȸ
select * from countries;
select * from locations;

select C.country_name, L.state_province, L.street_address
from countries C, locations L
where C.country_id = L.country_id;

-- jobs ���̺�� job_history ���̺��� job_id�� �������� �����Ͽ�
-- job_id, job_title, start_date, end_date�� ��ȸ
select * from jobs;
select * from job_history;

select J.job_id, J.job_title, H.start_date, H.end_date
from jobs J, job_history H
where J.job_id = H.job_id;

-- employees ���̺�� departments ���̺��� department_id �������� �����ϰ�, 
-- employees ���̺�� jobs ���̺��� job_id �������� �����Ͽ� 
-- first_name, last_name, department_name, job_title�� ��ȸ
select * from employees;
select * from departments;
select * from jobs;

select E.first_name, E.last_name, D.department_name, J.job_title
from employees E, departments D, jobs J
where E.department_id = D.department_id and E.job_id = J.job_id;

-- countries ���̺�� locations ���̺��� locations�� country_id�� �������� �ܺ� �����Ͽ�
-- country_id, country_name, city�� ��ȸ
select * from countries;
select * from locations;

select C.country_id, C.country_name, L.city
from countries C, locations L
where C.country_id = L.country_id(+);

-- employees ���̺�� departments ���̺��� departments ���̺��� department_id�� �������� �ܺ� �����Ͽ�
-- employee_id, first_name, last_name, department_name�� employee_id�� �������� �����Ͽ� ��ȸ
select * from employees;
select * from departments;

select E.employee_id, E.first_name, E.last_name, D.department_name
from employees E, departments D
where E.department_id = D.department_id(+)
order by E.employee_id;

-- employees ���̺��� manager_id�� employee_id�� �������� ��ü ������ �ڿ� 
-- ������ first_name�� last_name�� �����ϰ� �������� first_name�� last_name�� �����Ͽ�
-- employee_id�� �������� �����Ͽ� ��ȸ
select E.employee_id, E.first_name||' '||E.last_name, M.first_name||' '||M.last_name
from employees E, employees M
where E.manager_id = M.employee_id
order by E.employee_id; 