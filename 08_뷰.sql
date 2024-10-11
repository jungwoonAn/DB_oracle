-- �� ����
select * from emp_details_view;

-- 2. CREATE OR REPLACE VIEW
-- �並 ������ ���̺� Ȯ��
select * from employees;

-- �� ����
create view emp_view
as  select employee_id, first_name, last_name, email
    from employees;
    
select * from emp_view;

-- �� ���� �� ����
create or replace view new_employee_view
as  select employee_id, first_name, last_name, email, hire_date, job_id
    from employees
    where employee_id>200;

select * from new_employee_view;

insert into new_employee_view
values (207, 'Suan', 'Lee', 'suan', '21/01/01', 'IT_PROG');

-- �� ����
drop view emp_view;
drop view new_employee_view;

-- �б� ���� �� ����
create or replace view salary_order_view
as  select first_name, last_name, job_id, salary
    from employees
    order by salary desc
    with read only;

select * from salary_order_view;

-- ORA-42399: �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.
insert into salary_order_view values ('Suan', 'Lee', 'IT PROG', 10000);

create or replace view job_salary_view
as  select job_id, sum(salary) sum_salary, min(salary) min_salary, max(salary) max_salary
    from employees
    group by job_id
    order by sum(salary)
    with read only;
    
select * from job_salary_view;

-- �� ����
drop view salary_order_view;
drop view job_salary_view;


-- [�ǽ�] �� ����
-- employees ���̺��� 07�⵵�� ���� ������ employee_id, first_name, last_name, email, hire_date, 
-- job_id �÷� ���� ������ employee_07_view �̸��� �� ����
select * from employees where hire_date like '07/%';

create or replace view employee_07_view
as  select employee_id, first_name, last_name, email, hire_date, job_id
    from employees
    where hire_date like '07/%';
    
select * from employee_07_view;

-- employees ���̺��� department_id�� job_id�� �׷�ȭ�ϰ�, ��� salary�� 9000 �ʰ��� ������
-- department_id, job_id, salary�� ��հ��� salary_avg �÷� ���� ������
-- ��� salary ���� ���� ������ ������ high_salary_view �̸��� �б� ���� �� ����
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

-- ORA-01732: �信 ���� ������ ������ �������մϴ�
delete from high_salary_view where job_id='AD_VP';

-- employees ���̺��� manager_id�� employee_id�� �������� ��ü ������ �ڿ� 
-- department_id�� ������ first_name�� last_name�� �����ϰ�
-- �������� first_name�� last_name�� ������ �ڿ�
-- department_id�� �������� �����Ͽ� employee_manager_view �̸��� �б� ���� �� ����
select E.department_id, concat(E.first_name, concat(' ', E.last_name)) ����,
       concat(M.first_name, concat(' ', M.last_name)) ������
from employees E, employees M
where E.manager_id=M.employee_id
order by E.department_id;

create or replace view employee_manager_view
as  select E.department_id, concat(E.first_name, concat(' ', E.last_name)) ����,
       concat(M.first_name, concat(' ', M.last_name)) ������
    from employees E, employees M
    where E.manager_id=M.employee_id
    order by E.department_id
    with read only;
    
select * from employee_manager_view;

-- �� ����
drop view employee_07_view;
drop view high_salary_view;
drop view employee_manager_view;