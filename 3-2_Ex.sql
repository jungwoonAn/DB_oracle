-- ����1. ���(employees) ���̺�� ����(jobs), �μ�(departments), ��ġ(locations) ���̺��� INNER JOIN�Ͽ�
-- �� ����� �̸�(��+�̸�), ������, �μ���, ��ġ���� ����ϼ���.
select * from employees;
select * from jobs;
select * from departments;
select * from locations;

select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", J.job_title, d.department_name, L.city 
from employees E, jobs J, departments D, locations L
where E.job_id=J.job_id and E.department_id=d.department_id and d.location_id=L.location_id
order by E.employee_id;

-- ����2. �� �μ����� �ּ� �޿��� �޴� ����� �̸�(��+�̸�), �μ���, �޿��� ����ϼ���.
select department_id, min(salary)
from employees
group by department_id
order by department_id;

select concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", E.department_id, D.department_name, min_sal.salary
from (select department_id, min(salary) salary
      from employees
      group by department_id) min_sal, departments D, employees E
where min_sal.department_id=E.department_id and min_sal.department_id=D.department_id and min_sal.salary=E.salary
order by D.department_id;

-- ����3. ���(employees) ���̺�� �μ�(departments), �Ŵ���(employees) ���̺��� INNER JOIN�Ͽ�
-- �� ����� �̸�(��+�̸�), �μ���, �׸��� �� ����� �Ŵ��� �̸�(��+�̸�)�� ����ϼ���.
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", d.department_name, concat(M.first_name, concat(' ', M.last_name)) as "�Ŵ��� �̸�"
from employees E, departments D, employees M
where E.department_id=D.department_id(+) and e.manager_id=M.employee_id(+)
order by E.employee_id;

-- ����4. ���(employees) ���̺�� ����(jobs) ���̺��� JOIN�Ͽ� �� ������ ��� ���� ��� �޿��� ����ϼ���.
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

-- ����5. �����(hire_date)�� 2005�� ������ ��� �̸�(��+�̸�), ������, �μ����� ����ϼ���.
select * from employees where hire_date >= '05/01/01' order by hire_date;
select * from jobs;
select * from departments;

select concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", E.hire_date, J.job_title, D.department_name 
from employees E, jobs J, departments D
where E.job_id=J.job_id and E.department_id=D.department_id(+) and E.hire_date >= '05/01/01'
order by E.hire_date;