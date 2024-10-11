-- 4. 서브 쿼리(Sub Query)
-- 1) 단일 행 서브 쿼리(=, >, >=, <, <=, <>, !=)
select phone_number from employees where employee_id=100;
select * from employees
where phone_number 
    = (select phone_number from employees where employee_id=100);

select hire_date from employees where email='SKING';
select * from employees
where hire_date
    = (select hire_date from employees where email='SKING');
    
select * from employees
where hire_date
    < (select hire_date from employees where email='SKING');

select salary from employees where hire_date='06/01/03';
select * from employees
where salary
    = (select salary from employees where hire_date='06/01/03');
    
select * from employees
where salary
    >= (select salary from employees where hire_date='06/01/03')
order by salary;

-- 2) 다중 행 서브 쿼리(IN, NOT IN, EXIXTS, ANY(SOME), ALL)
-- 2-1) IN / NOT IN 연산자
select max(salary) from employees group by department_id;
select * from employees
where salary in (select max(salary) 
                 from employees 
                 group by department_id);
    
select * from employees
where salary not in (select max(salary)
                     from employees
                     group by department_id);
                     
-- 2-2) EXISTS 연산자
select * from employees
where exists (select * from employees where employee_id=100);

select * from employees
where exists (select * from employees where employee_id=99);

-- 2-3) ANY / ALL 연산자
select * from employees
where salary = any(6000, 10000, 12000);  -- 7행
select * from employees where salary=6000 or salary=10000 or salary=12000;
select * from employees where salary in (6000, 10000, 12000);

select * from employees
where salary <> any(6000, 10000, 12000)
order by salary;  -- 107행
select count(*) from employees where salary<>6000 or salary<>10000 or salary<>12000;

select * from employees
where salary < any(6000, 10000, 12000);  -- 98행
select count(*) from employees where salary<12000;

select * from employees
where salary <= all(6000, 10000, 12000);  --  52행
select count(*) from employees where salary<=6000 and salary<=10000 and salary<=12000;
select count(*) from employees where salary <= 6000;

select * from employees
where salary >= all(6000, 10000, 12000);  -- 9행
select count(*) from employees where salary>=6000 and salary>=10000 and salary>=12000;
select count(*) from employees where salary>=12000;

select * from employees
where salary <> all(6000, 10000, 12000);  -- 100행
select count(*) from employees where salary<>6000 and salary<>10000 and salary<>12000;
select count(*) from employees where salary!=6000 and salary!=10000 and salary!=12000;

select salary from employees where hire_date>'08/01/01';
select * from employees 
where salary < any(select salary
                   from employees
                   where hire_date>'08/01/01');  -- 92행
select count(*) from employees where salary < 10500;
                   
select * from employees 
where salary < all(select salary
                   from employees
                   where hire_date>'08/01/01');
select * from employees where salary < 2200;

select max(salary) from employees group by department_id order by max(salary);
select * from employees
where salary > any(select max(salary)
                   from employees
                   group by department_id);  -- 60행
select count(*) from employees where salary > 4400;

select * from employees
where salary < all(select max(salary)
                   from employees
                   group by department_id);  -- 46행
select count(*) from employees where salary < 4400;

-- 3) 인라인 뷰(Inline View) : from절에 있는 서브 쿼리가 인라인 뷰를 생성
select department_id from departments where department_name='IT';  -- department_id = 60
select *
from employees E, (select department_id
                   from departments
                   where department_name='IT') D
where E.department_id = D.department_id;

select department_id, avg(salary) avg_sal from employees group by department_id;
select E.last_name, E.salary, D.avg_sal
from employees E, (select department_id, avg(salary) avg_sal
                   from employees
                   group by department_id) D
where E.department_id = D.department_id and E.salary > D.avg_sal;

select department_name, (select avg(salary)
                         from employees
                         group by department_name)
from departments;
     
select D.department_name, avg(salary)
from departments D, employees E
where D.department_id = E.department_id
group by department_name;

select salary from employees order by salary desc;
select rownum, salary
from (select salary from employees order by salary desc)
where rownum <= 10;

-- [실습] 서브 쿼리
-- departments 테이블에서 department_name이 'IT'인 department_id와 일치하는
-- employees 테이블의 first_name, last_name, job_id, salary를 조회
select department_id from departments where department_name='IT';  -- 60
select first_name, last_name, job_id, salary
from employees
where department_id
    = (select department_id
       from departments
       where department_name='IT');

-- locations 테이블에서 state_province이 'California'인 location_id와 일치하는
-- departments 테이블의 department_id, department_name을 조회
select location_id from locations where state_province='California';  -- 1500
select department_id, department_name
from departments
where location_id
    = (select location_id
       from locations
       where state_province='California');
       
-- countries 테이블에서 region_id가 3인 country_id가 포함된
-- locations 테이블의 city, state_province, street_address를 조회
select country_id from countries where region_id=3;
select city, state_province, street_address
from locations
where country_id in (select country_id
                     from countries 
                     where region_id=3);
                     
-- departments 테이블에서 manager_id가 null이 아닌 department_id와 일치하는
-- employees 테이블의 first_name, last_name, job_id, salary를 조회
select department_id from departments where manager_id is not null;
select first_name, last_name, job_id, salary
from employees
where department_id 
    = any(select department_id 
          from departments 
          where manager_id is not null);

-- locations 테이블에서 city가 'Seattle'를 포함하지 않는 location_id와 일치하는
-- departments 테이블의 department_id, department_name을 조회
select location_id from locations where city not in 'Seattle';
select department_id, department_name
from departments
where location_id
    = any(select location_id 
          from locations 
          where city not in 'Seattle');
          
-- regions 테이블에서 region_name이 'Europe'인 region_id가 일치하는
-- countries 테이블에서 country_id가 포함된 locations 테이블의 city, state_province, street_address를 조회
select region_id from regions where region_name='Europe';  -- 1
select city, state_province, street_address
from locations
where country_id in (select country_id
                     from countries
                     where region_id = (select region_id
                                        from regions
                                        where region_name='Europe'));