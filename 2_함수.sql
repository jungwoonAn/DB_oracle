-- 1.�Լ��� �����Լ�
-- 1) �����Լ�
-- 1-1) LOWER(), UPPER(), INITCAP()
select first_name, lower(first_name), upper(first_name), initcap(first_name) from employees;

-- 1-2) SUBSTR() : ������ ���̸�ŭ �Ϻ� ����
select job_id, substr(job_id, 1, 2), substr(job_id, 4) from employees;

-- 1-3) REPLACE()
select job_id, replace(job_id, 'MGR', 'MANAGER') from employees where job_id like '%MGR';
select job_id, replace(job_id, 'PROG', 'PROGRAMMER') from employees where job_id like '%PROG';

-- 1-4) CONCAT()
select first_name || ' ' || last_name from employees;
select concat(first_name, concat(' ', last_name)) from employees;

-- 1-5) LENGTH()
select first_name, length(first_name) from employees;

-- 1-6) INSTR() : ��ġ�� ��ȯ
select first_name, instr(first_name, 'a') from employees;

-- 1-7) LPAD(), RPAD() : Ư�� ���� ä��� �Լ�
select lpad(first_name, 10, '*'), rpad(first_name, 10, '#') from employees;

-- 1-8) LTRIM(), RTRIM() : Ư�� ���� �����ϴ� �Լ�
select job_id, ltrim(job_id, 'A'), rtrim(job_id, 'T') from employees;

-- 1-9) TRIM() : ���� �����ϴ� �Լ�
select trim('   Suan    '), trim('   Su an') from dual;

-- ����) DUAL ���̺� : �ϳ��� �� DUMMY�� �ϳ��� �� 'X'�� ������ �ִ� ���̺�
-- Ư�� ���̺��� �������� �ʰ� ����� �� ���
select * from dual;

-- [�ǽ�] ���� �Լ�
-- jobs ���̺��� job_title�� �ҹ��ڿ� �빮�ڷ� ��ȯ�� job_title�� ��ȸ
select job_title, lower(job_title), upper(job_title) from jobs;

-- employees ���̺��� first_name ù 1 ���ڿ� last_name ��ȸ
select substr(first_name, 1, 1), last_name from employees;

-- employees ���̺��� job_id�� 'REP'�� �κ��� 'REPRESENTATIVE'�� �ٲ㼭 ��ȸ
select job_id, replace(job_id, 'REP', 'REPRESENTATIVE') from employees where job_id like '%REP%';

-- employees ���̺��� first_name ù 1 ���ڿ� last_name�� �߰��� ������ �ΰ� �ϳ��� �����Ͽ� ��ȸ
select concat(substr(first_name,1,1), concat(' ', last_name)) from employees;

-- employees ���̺��� first_name�� last_name�� ���̸� ���ļ� ��ȸ
select first_name, last_name, length(first_name)+length(last_name) as name_length from employees;

-- employees ���̺��� job_id�� job_id�� 'A' ���� ��ġ ��ȸ
select job_id, instr(job_id, 'A') from employees;

-- locations ���̺��� city�� 15�ڸ� ���ڿ��� �ٲٰ�, �� ������ '.'���� ǥ���Ͽ� ��ȸ
select lpad(city, 15, '.'), rpad(city, 15, '.') from locations;

-- locations ���̺��� city�� ���ʺ��� 'S' ���ڸ� ���� �Ͱ� �����ʺ��� 'e' ���ڸ� ���� ����� ��ȸ
select ltrim(city, 'S'), rtrim(city, 'e') from locations where city like 'S%' or city like '%e';


-- 2. ����, ��¥, ��ȯ, �Ϲ� �Լ�
-- 1) ���� �Լ�
-- 1-1) CEIL(): ������ �ø� / FLOOR(): ������ ����
select salary, salary/21, ceil(salary/21), floor(salary/21) from employees;

-- 1-2) ROUND(): �ݿø� / TRUNC(): ���� ����
select salary, salary/21,
       round(salary/21), round(salary/21, 2), round(salary/21, -1),
       trunc(salary/21), trunc(salary/21, 2), trunc(salary/21, -1)
from employees;

-- 1-3) MOD(): ������ ����
select salary, salary/21, mod(salary, 21) from employees;

-- 1-4) SIGN(): ����� ��� 1, ������ ��� -1, �������� 0�� ��ȯ
select sign(-123), sign(0), sign(123) from dual;

-- 1-5) POWER(): �ŵ����� / SQRT(): ������
select power(3, 3), sqrt(4) from dual;

-- 2) ��¥ �Լ�
-- 2-1) SYSDATE: �ý��� ���� ��¥ ��ȯ
select sysdate, sysdate+1, sysdate-1 from dual;

-- 2-2) MONTH_BETWEEN(): ��¥�� ��¥ ������ ���� �� ���
select sysdate, hire_date, months_between(sysdate, hire_date) from employees;

--2-3) ADD_MONTHS(): ��¥�� ������ �������� ����
select hire_date, add_months(hire_date, 2), add_months(hire_date, -2) from employees;

-- 2-4) NEXT_DAY(): ���ƿ��� ���� ��¥ ��ȯ / LAST_DAY(): ���� ������ ��¥ ���
select hire_date, next_day(hire_date, 3), next_day(hire_date, '������'), last_day(hire_date) from employees;

-- 2-5) ROUND(): ��¥�� ������ �� ������ �ݿø� / TRUNC(): ��¥�� ������ �� ������ ����
select hire_date, round(hire_date, 'YEAR'), trunc(hire_date, 'MONTH') from employees;


-- 3) ��ȯ �Լ� : ������ Ÿ���� �ʿ信 ���� ��ȯ
-- 3-1) TO_CHAR(): ���ڿ� ��¥ �����͸� ���ڷ� ��ȯ
select to_char(sysdate, 'CC AD Q') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
select to_char(sysdate, 'W DAY') from dual;

select to_char(sysdate, 'AM HH:MI:SS') from dual;
select to_char(sysdate, 'HH24:MI:SS PM') from dual;
select to_char(sysdate, 'YY-MM-DD') from dual;
select to_char(sysdate, 'MM"��" DD"��"') from dual; 

select to_char(salary, '9999999') from employees;
select to_char(salary, '0999999') from employees;
select to_char(salary, '$999999') from employees;
select to_char(salary, 'L999999') from employees;
select to_char(salary, '99999.99') from employees;
select to_char(salary, '9,999,999') from employees;

-- 3-2) TO_NUMBER(): ���ڷε� ���ڿ��� ���� Ÿ������ ��ȯ
select to_number('123') from dual;
select to_number('123.123') from dual;

-- 3-3) TO_DATE(): ���ڷ� �� ���ڿ��� ��¥ Ÿ������ ��ȯ
select to_date('20240909', 'YYMMDD') from dual;


-- 4) �Ϲ� �Լ�
-- 4-1) NVL(): NULL���� Ư���� ������ ġȯ
select department_name, manager_id from departments where manager_id is null;
select department_name, nvl(manager_id, 100) from departments where manager_id is null;

select state_province from locations where state_province is null;
select nvl(state_province, 'None') from locations where state_province is null;

-- 4-2) NVL2(): NULL���� ���� �ƴ� ��츦 �����Ͽ� Ư���� ������ ġȯ
select department_name, nvl2(manager_id, '������ ����', '������ ����') from departments;
select city, nvl2(state_province, '�ּ� ����', '�ּ� ����') from locations order by state_province;

-- 4-3) DECODE(): �����Ͱ� ���� ���� ��ġ�ϸ� ġȯ���� ���, �׷��� ������ �⺻���� ���
select job_title, min_salary, decode(min_salary, 2500, min_salary*1.1, min_salary) from jobs where min_salary>=2500 order by min_salary;
select job_title, max_salary, decode(max_salary, 40000, max_salary*0.9, max_salary) from jobs where max_salary>=30000;

-- 4-4) CASE(): ������ �� ���� ó�� �Լ�
select job_title, min_salary,
    case
      when min_salary<4000 then min_salary*1.2
      when min_salary between 4000 and 6000 then min_salary*1.1
      else min_salary
    end as �ּұ޿�����
from jobs order by min_salary;

-- 4-5) RANK(), DENSE_RANK(), ROW_NUMBER()
-- RANK(): ���� ������ �ǳʶپ� ���� ������ ���
-- DENSE_RANK(): ���� ������ �ǳʶ��� �ʰ�, ���� ������ ���
-- ROW_NUMBER(): ���� ���� ���� ������ ���
select first_name, salary,
       rank() over(order by salary desc) rank,
       dense_rank() over(order by salary desc) dense_rank,
       row_number() over(order by salary desc) row_number
from employees;

-- [�ǽ�] ����, ��¥ �Լ�
-- jobs ���̺��� min_salary ���� 30���� ���� ���� �ø����� �������� ��ȸ
select min_salary/30, ceil(min_salary/30), floor(min_salary/30) from jobs;

-- jobs ���̺��� max_salary ���� 30���� ���� ���� �Ҽ��� ��°�ڸ����� �ݿø��� ���� ���� ù° �ڸ����� �ݿø��� ���� ��ȸ
select max_salary/30, round(max_salary/30, 2), round(max_salary/30, -1) from jobs;

-- jobs ���̺��� max_salary ���� 30���� ���� ���� �Ҽ��� ��°�ڸ����� ������ ���� ���� ��° �ڸ����� ������ ���� ��ȸ
select max_salary/30, trunc(max_salary/30, 3), trunc(max_salary/30, -2) from jobs;

-- ���� ��¥�� ���� ��¥���� �� �� ���� ��¥�� ��ȸ
select sysdate, add_months(sysdate, 1) from dual;

-- ���� ��¥�� ���� ��¥���� ���ƿ��� �����ϰ� �ݿ����� ��¥�� ��ȸ
select sysdate, next_day(sysdate, '��'), next_day(sysdate, 6) from dual;

-- [�ǽ�] ��ȯ �Լ�
-- ���� ��¥�� ��/�ϰ� ������ ��ȸ
select sysdate, to_char(sysdate, 'MM/DD'), to_char(sysdate, 'DAY') from dual;

-- ���� �ð��� ���� �Ǵ� ���� �׸��� ��:���� ��ȸ
select sysdate, to_char(sysdate, 'AM HH:MI') from dual;

-- 2025�� 01�� 01���� ������ ��ȸ
select date'2025-01-01', to_char(date'2025-01-01', 'DAY') from dual;

-- [�ǽ�] �Ϲ� �Լ�
-- employees ���̺��� salary, commission_pct, �׸��� salary�� commission_pct�� ���� ���� salary�� �ݿ��ϰ�,
-- commission_pct ���� ������ ��ȸ(commission_pct�� null�� ��쿡�� salary �״�� �ݿ�)
select salary, commission_pct, nvl2(commission_pct, salary*commission_pct, salary)
from employees order by commission_pct;

-- employees ���̺��� first_name, last_name, department_id, salary �׸���
-- department_id�� 50�� ��� salary�� 10% ������Ų ���� '�޿��λ�', 
-- department_id�� 100�� ��� salary�� 10% ���ҽ�Ų ���� '�޿�����'�� ��ȸ
select first_name, last_name, department_id, salary,
    case
      when department_id=50 then salary*1.1
    end as �޿��λ�,
    case
      when department_id=100 then salary*0.9
    end as �޿�����
from employees where department_id in(50,100);

-- jobs ���̺��� job_title�� Manager�� �� ������ �߿� job_title, max_salary, �׸���
-- max_salary�� 20000 �̻��� ���� '����', 10000���� 20000 ������ ���� '����',
-- �� �ۿ��� '����'�� ǥ���ϴ� '�޿����'�� ��ȸ
select * from jobs where job_title like '%Manager';
select job_title, max_salary,
    case
      when max_salary>=20000 then '����'
      when max_salary between 10000 and 20000 then '����'
      else '����'
    end as �޿����
from jobs where job_title like '%Manager';


-- 3. ���� �� �׷� �Լ�
-- 1) ���� �Լ�
-- 1-1) COUNT(): ���� �� ������ ���ϴ� �Լ�
select count(*) from employees;
select count(salary) from employees;
select count(manager_id) from employees;  -- null �� �������� ����
select count(commission_pct) from employees;

-- 1-2) SUM() / AVG()
select sum(salary), avg(salary) from employees;
select sum(salary), count(salary) from employees;
select first_name, salary, sum(salary) over (order by first_name) from employees;

--1-3) MIN() / MAX()
select min(salary), max(salary) from employees;
select min(first_name), max(first_name) from employees;

-- 1-4) STDDEV(): ǥ������ / VARIANCE(): �л�
select stddev(salary), variance(salary) from employees;
select first_name, salary, stddev(salary) over (order by first_name) from employees where department_id=50;


-- 2) �׷� �Լ�
-- 2-1) GROUP BY ��
select job_id, sum(salary), avg(salary) from employees group by job_id;
select job_id, sum(salary), avg(salary) from employees where department_id=50 group by job_id;
select department_id, min(salary), max(salary) from employees group by department_id;
select department_id, min(salary), max(salary) from employees where hire_date > '20070101' group by department_id;
select country_id, count(country_id) from locations group by country_id order by country_id;

-- 2-2) ���� GROUP BY ��
-- employees ���̺� ��ü ���ڵ� ��ȸ
select * from employees;

-- department_id 50~100 ���ڵ��� salary ��, ��� ���ϱ�
select sum(salary), avg(salary) from employees where department_id between 50 and 100;

-- department_id 50~100 ���ڵ��� department_id �������� �׷�ȭ�Ͽ� �׷��� salary ��, ��� ���ϱ�
-- �Ϲ� �÷��� �����Լ��� ���� ����� ��� GROUP BY���� �׷��� ������ ������� ��!
-- group by ���̴� � ������� �Ϲ� �÷��� ���� �����Լ��� ����� �����ؾ� ���� �� �� ����
select department_id, sum(salary), avg(salary)
from employees 
where department_id between 50 and 100
group by department_id;

-- department_id 50~100 ���ڵ��� 1�� department_id �׷�, 2�� job_id�� �׷�ȭ �Ͽ� �׷��� salary �հ� ��� ���ϱ�
select job_id, department_id, sum(salary), avg(salary)
from employees
where department_id between 50 and 100
group by  department_id, job_id;

select job_id, department_id, sum(salary), avg(salary)
from employees
where department_id between 50 and 100
group by job_id, department_id
order by job_id;

select department_id, manager_id, sum(salary), avg(salary)
from employees
where department_id=50
group by department_id, manager_id
order by manager_id;

select manager_id, department_id, job_id, sum(salary), min(salary), max(salary)
from employees
where manager_id in (100, 101)
group by manager_id, department_id, job_id
order by manager_id, department_id;

-- 2-3) HAVING ��: GROUP BY�� ������
select job_id, sum(salary), avg(salary) from employees group by job_id having avg(salary)>10000;
select department_id, min(salary), max(salary) from employees group by department_id having max(salary)>7000 order by max(salary);
select country_id, count(country_id) from locations group by country_id having count(country_id)>2 order by country_id;

select job_id, department_id, sum(salary), avg(salary) 
from employees 
where department_id between 50 and 100
group by job_id, department_id
having avg(salary)>9000
order by job_id;

select manager_id, department_id, job_id, sum(salary), min(salary), max(salary)
from employees
where manager_id in (100, 101)
group by manager_id, department_id, job_id
having sum(salary) between 10000 and 40000
order by manager_id, department_id;

-- [�ǽ�] ���� �Լ�
-- employees ���̺��� salary�� 8000�̻��� ������ ���� ��ȸ
select count(*) from employees where salary>=8000;

-- employees ���̺��� hire_date�� 2007�� 1�� 1�� ������ ������ ���� ��ȸ
select count(*) ������ from employees where hire_date>='07/01/01';

-- jobs ���̺��� max_salary ���� �հ�� ����� ��ȸ
select sum(max_salary), avg(max_salary) from jobs;

-- employees ���̺��� job_id�� 'IT_PROG'�� ������ salary �հ�� ����� ��ȸ
select sum(salary), avg(salary) from employees where job_id='IT_PROG';

-- employees ���̺��� department_id�� 50�� 80 ������ ������
-- first_name, salary, �׸��� commission_pct�� ��հ���
-- first_name ���� �������� ��ȸ (null ���� 0���� ���)
select first_name, salary, avg(nvl(commission_pct, 0)) over (order by first_name)
from employees
where department_id between 50 and 80;

-- jobs ���̺��� max_salary ���� �ּڰ��� max_salary ���� �ִ��� ��ȸ
select * from jobs;
select min(max_salary), max(max_salary) from jobs;

-- jobs ���̺��� job_title�� 'Programmer'�� ������ max_salary ���� �ּڰ��� max_salary ���� �ִ��� ��ȸ
select job_title, max_salary from jobs where job_title='Programmer';
select min(max_salary), max(max_salary) from jobs where job_title='Programmer';

-- employees ���̺��� department_id�� 50�� �������� hire_date �ּҰ��� �ִ� ��ȸ
select min(hire_date), max(hire_date) from employees where department_id=50;

-- employees ���̺��� department_id�� 100�� �������� first_name, salary, �׸��� salary�� �л갪�� hire_date ���� �������� ��ȸ
select first_name, salary, variance(salary) over (order by hire_date)from employees where department_id=100;

-- [�ǽ�] �׷� �Լ�
-- employees ���̺��� hire_date ���� 2004�� 1�� 1�Ϻ��� 2006�� 12�� 31�� ������ �����͸�
-- job_id �������� �׷�ȭ�� �ڿ� job_id�� salary �ּڰ��� �ִ밪�� ��ȸ
select job_id, min(salary), max(salary) from employees
where hire_date between '04/01/01' and '06/12/31'
group by job_id;

-- employees ���̺��� department_id �� 50�� 80�� �����͸�
-- department_id�� job_id �������� �׷�ȭ�� �ڿ� department_id�� job_id, salary �հ�, �ּڰ�, �ִ밪��
-- job_id �������� �����Ͽ� ��ȸ
select department_id, job_id, sum(salary), min(salary), max(salary)
from employees
where department_id in (50, 80)
group by department_id, job_id
order by job_id;

-- employees ���̺��� department_id�� job_id �������� �׷�ȭ�� �ڿ� 
-- salary ��հ��� 12000 �̻��� �����͸� department_id�� job_id, salary �ּڰ�, �ִ밪, �����
-- department_id �������� �����Ͽ� ��ȸ
select department_id, job_id, min(salary), max(salary), avg(salary)
from employees
group by department_id, job_id
having avg(salary)>=12000
order by department_id;