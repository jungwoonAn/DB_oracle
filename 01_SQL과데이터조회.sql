-- 현재 접속 사용자 확인
show user;

-- hr계정이 갖고 있는 테이블 확인
select * from user_tables;

-- 1. 데이터 조회
-- 1) 전체 레코드 조회
select * from departments;

-- 2) 특정 컬럼 조회
select department_id, department_name,  manager_id ,location_id from departments;

select department_id, department_name from departments;

-- 3) 별칭(alias) 사용
select department_id as "부서 ID", department_name as "부서 이름" from departments;
select department_id as 부서_ID, department_name as 부서_이름 from departments;
select department_id  부서_ID, department_name  "부서 이름" from departments;

-- 4) distinct -> 중복 제거
select distinct location_id from departments;

-- 5) 문자열 연결 연산자(||)
select department_id || department_name as 부서명 from departments;
select 'Department of ' || department_name as 부서명 from departments;

-- 6) 산술 연산자
select first_name, last_name, salary*1.1 from employees;

-- [실습] 데이터 조회: SELECT
-- countries 테이블 조회
select * from countries;

-- countries 테이블에서 country_id와 country_name 컬럼만 조회
select country_id, country_name from countries;

-- countries 테이블에서 컬럼명 country_id를 국가ID, country_name를 국가명으로 조회
select country_id as 국가ID, country_name 국가명 from countries;

-- countries 테이블에서 region_id를 중복제외하고 조회
select distinct region_id from countries;

-- countries 테이블에서 country_name과 country_id를 연결하여 조회
select country_name||country_id from countries;

-- locations 테이블에서 street_address와 city 컬럼만 조회
select street_address, city from locations;

-- jobs 테이블에서 job_id와 job_title 컬럼만 조회
select job_id, job_title from jobs;

-- jobs 테이블에서 job_title, min_salary, max_salary 컬럼을 최소연봉과 최대연봉을 10% 인상된 상태로 조회
select job_title, min_salary*1.1, max_salary*1.1 from jobs;

-- employees 테이블에서 first_name과 last_name을 연결하고 컬럼명을 이름으로 조회
select first_name || last_name as 이름 from employees;

-- employees 테이블에서 job_id를 중복제외하고 조회
select distinct job_id from employees;


-- 2. 조건 검색과 비교,논리연산
-- 1) 데이터 제한(where)
select * from employees where employee_id=100;

-- 2) 비교 연산자
select * from employees where employee_id <= 110;

-- 3) 논리 연산자 and, or, not
select * from employees where employee_id >= 120 and employee_id <= 130;
select * from employees where salary >= 10000 and salary <= 12000;

select * from employees where manager_id=100 or manager_id=120;
select * from employees where last_name='King' or last_name='Smith';

select * from employees where not department_id=50;

-- [실습] 비교, 논리 연산자
-- employees 테이블에서 first_name이 'David'인 직원 조회
select * from employees where first_name='David';

-- jobs 테이블에서 최소 월급이 4000 달러인 직업 조회
select * from jobs where min_salary=4000;

-- jobs 테이블에서 최소 월급이 8000 초과인 직업 조회
select * from jobs where min_salary>8000;

-- jobs 테이블에서 최대 월급이 10000 이하인 직업 조회
select * from jobs where max_salary<=10000;

-- jobs 테이블에서 최소 월급이 4000 이상이고 최대 월급이 10000 이하인 직업 조회
select * from jobs where min_salary>=4000 and max_salary<=10000;

-- employees 테이블에서 job_id가 'IT_PROG'이면서 salary가 5000 초과인 직원 조회
select * from employees where job_id='IT_PROG' and salary>5000;

-- 3. 정렬과 집합 연산
-- 1) order by
select first_name, last_name from employees order by first_name;
select first_name, last_name from employees order by first_name desc;

select department_name from departments order by department_name;
select department_name from departments order by department_name desc;

select country_id, city from locations order by country_id, city;

select location_id, department_name from departments order by location_id desc, department_name;

-- 2) SQL 연산
-- 2-1) between 연산자
select * from employees where employee_id between 120 and 130;
select * from employees where salary between 10000 and 12000;

-- 2-2) in 연산자
select * from employees where first_name='Steven' or first_name='John' or first_name='Peter';
select * from employees where first_name in ('Steven', 'John', 'Peter');
select * from countries where country_id in ('US','IL','SG');
select * from locations where city!='Sao Paulo' and city!='London' and city!='Southlake';
select * from locations where city not in ('Sao Paulo','London','Southlake');

-- 2-3) is null 연산자
select * from locations where state_province is null;
select * from locations where state_province is not null;

-- 2-4) like 연산자
select * from locations where city like 'South%';
select * from locations where street_address like '%St';
select * from locations where city like 'South____';

-- 3) 집합 연산자 : union(합집합-중복 제외), union all(합집합-중복 포함), minus(차집합), intersect(교집합) 
select employee_id, first_name, department_id from employees where department_id=60
union
select employee_id, first_name, department_id from employees where department_id=100;

-- union(합집합-중복 제외)
select employee_id, first_name from employees where employee_id<=160
union
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- union all(합집합-중복 포함)
select employee_id, first_name from employees where employee_id<=160
union all
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- minus(차집합)
select employee_id, first_name from employees where employee_id<=160
minus
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- intersect(교집합)
select employee_id, first_name from employees where employee_id<=160
intersect
select employee_id, first_name from employees where employee_id>=140
order by employee_id;

-- [실습] 정렬, 집합 연산자
-- jobs 테이블에서 job_title 기준으로 정렬하여 직업 조회
select * from jobs order by job_title;

-- countries 테이블에서 country_name 기준 내림차순으로 정렬하여 조회
select * from countries order by country_name desc;

-- employees 테이블에서 salary가 10000에서 12000 사이인 직원 조회
select * from employees where salary between 10000 and 12000;

-- employees 테이블에서 job_id가 'IT_PROG'와 'ST_MAN'인 직원 조회
select * from employees where job_id in ('IT_PROG','ST_MAN');

-- employees 테이블에서 manager_id가 NULL인 직원 조회
select * from employees where manager_id is null;

-- departments 테이블에서 manager_id가 NULL이 아닌 부서 조회
select * from departments where manager_id is not null;

-- employees 테이블에서 job_id가 'AD'로 시작하는 직원 조회
select * from employees where job_id like 'AD%';

-- employees 테이블의 first_name에서 'ni'를 포함하는 직원 조회
select * from employees where first_name like '%ni%';

-- locations 테이블에서 location_id, street_address, city에 대해 
-- location_id가 3000 이하인 데이터와 2000 이상인 데이터를
-- 합집합(중복포함), 차집합, 교집합 한 결과 조회
-- 1_합집합(중복포함)
select location_id, street_address, city from locations where location_id<=3000
union all
select location_id, street_address, city from locations where location_id>=2000;

-- 차집합
select location_id, street_address, city from locations where location_id<=3000
minus
select location_id, street_address, city from locations where location_id>=2000;

-- 교집합
select location_id, street_address, city from locations where location_id<=3000
intersect
select location_id, street_address, city from locations where location_id>=2000;