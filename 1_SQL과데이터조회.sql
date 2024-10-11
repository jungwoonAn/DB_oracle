-- ���� ���� ����� Ȯ��
show user;

-- hr������ ���� �ִ� ���̺� Ȯ��
select * from user_tables;

-- 1. ������ ��ȸ
-- 1) ��ü ���ڵ� ��ȸ
select * from departments;

-- 2) Ư�� �÷� ��ȸ
select department_id, department_name,  manager_id ,location_id from departments;

select department_id, department_name from departments;

-- 3) ��Ī(alias) ���
select department_id as "�μ� ID", department_name as "�μ� �̸�" from departments;
select department_id as �μ�_ID, department_name as �μ�_�̸� from departments;
select department_id  �μ�_ID, department_name  "�μ� �̸�" from departments;

-- 4) distinct -> �ߺ� ����
select distinct location_id from departments;

-- 5) ���ڿ� ���� ������(||)
select department_id || department_name as �μ��� from departments;
select 'Department of ' || department_name as �μ��� from departments;

-- 6) ��� ������
select first_name, last_name, salary*1.1 from employees;

-- [�ǽ�] ������ ��ȸ: SELECT
-- countries ���̺� ��ȸ
select * from countries;

-- countries ���̺��� country_id�� country_name �÷��� ��ȸ
select country_id, country_name from countries;

-- countries ���̺��� �÷��� country_id�� ����ID, country_name�� ���������� ��ȸ
select country_id as ����ID, country_name ������ from countries;

-- countries ���̺��� region_id�� �ߺ������ϰ� ��ȸ
select distinct region_id from countries;

-- countries ���̺��� country_name�� country_id�� �����Ͽ� ��ȸ
select country_name||country_id from countries;

-- locations ���̺��� street_address�� city �÷��� ��ȸ
select street_address, city from locations;

-- jobs ���̺��� job_id�� job_title �÷��� ��ȸ
select job_id, job_title from jobs;

-- jobs ���̺��� job_title, min_salary, max_salary �÷��� �ּҿ����� �ִ뿬���� 10% �λ�� ���·� ��ȸ
select job_title, min_salary*1.1, max_salary*1.1 from jobs;

-- employees ���̺��� first_name�� last_name�� �����ϰ� �÷����� �̸����� ��ȸ
select first_name || last_name as �̸� from employees;

-- employees ���̺��� job_id�� �ߺ������ϰ� ��ȸ
select distinct job_id from employees;


-- 2. ���� �˻��� ��,������
-- 1) ������ ����(where)
select * from employees where employee_id=100;

-- 2) �� ������
select * from employees where employee_id <= 110;

-- 3) �� ������ and, or, not
select * from employees where employee_id >= 120 and employee_id <= 130;
select * from employees where salary >= 10000 and salary <= 12000;

select * from employees where manager_id=100 or manager_id=120;
select * from employees where last_name='King' or last_name='Smith';

select * from employees where not department_id=50;

-- [�ǽ�] ��, �� ������
-- employees ���̺��� first_name�� 'David'�� ���� ��ȸ
select * from employees where first_name='David';

-- jobs ���̺��� �ּ� ������ 4000 �޷��� ���� ��ȸ
select * from jobs where min_salary=4000;

-- jobs ���̺��� �ּ� ������ 8000 �ʰ��� ���� ��ȸ
select * from jobs where min_salary>8000;

-- jobs ���̺��� �ִ� ������ 10000 ������ ���� ��ȸ
select * from jobs where max_salary<=10000;

-- jobs ���̺��� �ּ� ������ 4000 �̻��̰� �ִ� ������ 10000 ������ ���� ��ȸ
select * from jobs where min_salary>=4000 and max_salary<=10000;

-- employees ���̺��� job_id�� 'IT_PROG'�̸鼭 salary�� 5000 �ʰ��� ���� ��ȸ
select * from employees where job_id='IT_PROG' and salary>5000;

-- 3. ���İ� ���� ����
-- 1) order by
select first_name, last_name from employees order by first_name;
select first_name, last_name from employees order by first_name desc;

select department_name from departments order by department_name;
select department_name from departments order by department_name desc;

select country_id, city from locations order by country_id, city;

select location_id, department_name from departments order by location_id desc, department_name;

-- 2) SQL ����
-- 2-1) between ������
select * from employees where employee_id between 120 and 130;
select * from employees where salary between 10000 and 12000;

-- 2-2) in ������
select * from employees where first_name='Steven' or first_name='John' or first_name='Peter';
select * from employees where first_name in ('Steven', 'John', 'Peter');
select * from countries where country_id in ('US','IL','SG');
select * from locations where city!='Sao Paulo' and city!='London' and city!='Southlake';
select * from locations where city not in ('Sao Paulo','London','Southlake');

-- 2-3) is null ������
select * from locations where state_province is null;
select * from locations where state_province is not null;

-- 2-4) like ������
select * from locations where city like 'South%';
select * from locations where street_address like '%St';
select * from locations where city like 'South____';

-- 3) ���� ������ : union(������-�ߺ� ����), union all(������-�ߺ� ����), minus(������), intersect(������) 
select employee_id, first_name, department_id from employees where department_id=60
union
select employee_id, first_name, department_id from employees where department_id=100;

-- union(������-�ߺ� ����)
select employee_id, first_name from employees where employee_id<=160
union
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- union all(������-�ߺ� ����)
select employee_id, first_name from employees where employee_id<=160
union all
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- minus(������)
select employee_id, first_name from employees where employee_id<=160
minus
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- intersect(������)
select employee_id, first_name from employees where employee_id<=160
intersect
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- [�ǽ�] ����, ���� ������
-- jobs ���̺��� job_title �������� �����Ͽ� ���� ��ȸ
select * from jobs order by job_title;

-- countries ���̺��� country_name ���� ������������ �����Ͽ� ��ȸ
select * from countries order by country_name desc;

-- employees ���̺��� salary�� 10000���� 12000 ������ ���� ��ȸ
select * from employees where salary between 10000 and 12000;

-- employees ���̺��� job_id�� 'IT_PROG'�� 'ST_MAN'�� ���� ��ȸ
select * from employees where job_id in ('IT_PROG','ST_MAN');

-- employees ���̺��� manager_id�� NULL�� ���� ��ȸ
select * from employees where manager_id is null;

-- departments ���̺��� manager_id�� NULL�� �ƴ� �μ� ��ȸ
select * from departments where manager_id is not null;

-- employees ���̺��� job_id�� 'AD'�� �����ϴ� ���� ��ȸ
select * from employees where job_id like 'AD%';

-- employees ���̺��� first_name���� 'ni'�� �����ϴ� ���� ��ȸ
select * from employees where first_name like '%ni%';

-- locations ���̺��� location_id, street_address, city�� ���� 
-- location_id�� 3000 ������ �����Ϳ� 2000 �̻��� �����͸�
-- ������(�ߺ�����), ������, ������ �� ��� ��ȸ
-- 1_������(�ߺ�����)
select location_id, street_address, city from locations where location_id<=3000
union all
select location_id, street_address, city from locations where location_id>=2000;

-- ������
select location_id, street_address, city from locations where location_id<=3000
minus
select location_id, street_address, city from locations where location_id>=2000;

-- ������
select location_id, street_address, city from locations where location_id<=3000
intersect
select location_id, street_address, city from locations where location_id>=2000;