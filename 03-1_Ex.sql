-- ����1.���(employees)���̺��� �� ����� �̸�(��+�̸�)�� �� ����� �Ŵ��� �̸�(��+�̸�)�� ����ϼ���.
-- �Ŵ����� ���� ��� NULL�� ǥ���ϼ���.
select * from employees;
-- oracle join
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", concat(M.first_name, concat(' ', M.last_name)) as "�Ŵ��� �̸�" 
from employees E, employees M
where E.manager_id = M.employee_id(+)
order by E.employee_id;
-- ANSI join
select E.employee_id, E.first_name||' '||E.last_name as "��� �̸�", M.first_name||' '||M.last_name as "�Ŵ��� �̸�" 
from employees E
left join employees M
on E.manager_id = M.employee_id
order by E.employee_id;

-- ����2. ���(employees)���̺�� �μ�(departments)���̺��� INNER JOIN�Ͽ�
-- ����� �̸�(��+�̸�), �μ���, �μ� ��ġ�� ����ϼ���.
select * from employees;
select * from departments;

select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", d.department_name, d.location_id
from employees E, departments D
where E.department_id = D.department_id
order by E.employee_id;

-- ����3. ���(employees)���̺�� �μ�(departments), ��ġ(locations)���̺��� INNER JOIN�Ͽ�
-- �� ����� �̸�(��+�̸�), �μ���, �μ� ��ġ���� ����ϼ���.
select * from employees;
select * from departments;
select * from locations;
-- oracle join
select concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", D.department_name, L.city
from employees E, departments D, locations L
where E.department_id = D.department_id and D.location_id = L.location_id;
--ANSI join
select E.employee_id, E.first_name||' '||E.last_name as "��� �̸�", D.department_name, L.city
from employees E
join departments D on E.department_id = D.department_id
join locations L on D.location_id = L.location_id;

-- ����4. ���(employees)���̺�� ����(jobs), �μ�(departments)���̺��� INNER JOIN�Ͽ�
-- �� ����� �̸�(��+�̸�), ������, �μ����� ����ϼ���.
select * from employees;
select * from jobs;
select * from departments;
-- oracle join
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", J.job_title, D.department_name
from employees E, jobs J, departments D
where E.job_id = J.job_id and E.department_id = D.department_id
order by E.employee_id;
-- ANSI join
select E.employee_id, E.employee_id, E.first_name||' '||E.last_name as "��� �̸�", J.job_title, D.department_name
from employees E
join jobs J on E.job_id = J.job_id
join departments D on E.department_id = D.department_id
order by E.employee_id;

-- ����5. ���(employees)���̺�� ����(jobs)���̺��� JOIN�Ͽ�
-- �� ����� �̸�(��+�̸�), ������, ����� �޿��� ������ ��� �޿��� ����ϼ���.
select * from employees;
select * from jobs;

select job_id, avg(salary) from employees group by job_id;
-- oracle join(sub query)
select E.employee_id, concat(E.first_name, concat(' ', E.last_name)) as "��� �̸�", J.job_title, E.salary, A.avg_sal
from employees E, jobs J, (select job_id, avg(salary) avg_sal from employees group by job_id) A
where E.job_id = J.job_id and J.job_id = A.job_id
order by E.employee_id;
-- ANSI join
select E.employee_id, E.employee_id, E.first_name||' '||E.last_name as "��� �̸�", J.job_title, E.salary,
       avg(E.salary) over(partition by e.job_id) avg_sal
from employees E
join jobs J on E.job_id = J.job_id
order by E.employee_id;