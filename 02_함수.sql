-- 1.함수와 문자함수
-- 1) 문자함수
-- 1-1) LOWER(), UPPER(), INITCAP()
select first_name, lower(first_name), upper(first_name), initcap(first_name) from employees;

-- 1-2) SUBSTR() : 지정된 길이만큼 일부 추출
select job_id, substr(job_id, 1, 2), substr(job_id, 4) from employees;

-- 1-3) REPLACE()
select job_id, replace(job_id, 'MGR', 'MANAGER') from employees where job_id like '%MGR';
select job_id, replace(job_id, 'PROG', 'PROGRAMMER') from employees where job_id like '%PROG';

-- 1-4) CONCAT()
select first_name || ' ' || last_name from employees;
select concat(first_name, concat(' ', last_name)) from employees;

-- 1-5) LENGTH()
select first_name, length(first_name) from employees;

-- 1-6) INSTR() : 위치값 반환
select first_name, instr(first_name, 'a') from employees;

-- 1-7) LPAD(), RPAD() : 특정 문자 채우는 함수
select lpad(first_name, 10, '*'), rpad(first_name, 10, '#') from employees;

-- 1-8) LTRIM(), RTRIM() : 특정 문자 제거하는 함수
select job_id, ltrim(job_id, 'A'), rtrim(job_id, 'T') from employees;

-- 1-9) TRIM() : 공백 제거하는 함수
select trim('   Suan    '), trim('   Su an') from dual;

-- 참고) DUAL 테이블 : 하나의 열 DUMMY와 하나의 값 'X'를 가지고 있는 테이블
-- 특정 테이블을 참조하지 않고 출력할 때 사용
select * from dual;

-- [실습] 문자 함수
-- jobs 테이블에서 job_title과 소문자와 대문자로 변환한 job_title을 조회
select job_title, lower(job_title), upper(job_title) from jobs;

-- employees 테이블에서 first_name 첫 1 문자와 last_name 조회
select substr(first_name, 1, 1), last_name from employees;

-- employees 테이블에서 job_id가 'REP'인 부분을 'REPRESENTATIVE'로 바꿔서 조회
select job_id, replace(job_id, 'REP', 'REPRESENTATIVE') from employees where job_id like '%REP%';

-- employees 테이블에서 first_name 첫 1 문자와 last_name을 중간에 공백을 두고 하나로 결합하여 조회
select concat(substr(first_name,1,1), concat(' ', last_name)) from employees;

-- employees 테이블에서 first_name과 last_name의 길이를 합쳐서 조회
select first_name, last_name, length(first_name)+length(last_name) as name_length from employees;

-- employees 테이블에서 job_id와 job_id에 'A' 문자 위치 조회
select job_id, instr(job_id, 'A') from employees;

-- locations 테이블의 city를 15자리 문자열로 바꾸고, 빈 공간을 '.'으로 표현하여 조회
select lpad(city, 15, '.'), rpad(city, 15, '.') from locations;

-- locations 테이블에서 city의 왼쪽부터 'S' 문자를 지운 것과 오른쪽부터 'e' 문자를 지운 결과를 조회
select ltrim(city, 'S'), rtrim(city, 'e') from locations where city like 'S%' or city like '%e';


-- 2. 숫자, 날짜, 변환, 일반 함수
-- 1) 숫자 함수
-- 1-1) CEIL(): 정수로 올림 / FLOOR(): 정수로 내림
select salary, salary/21, ceil(salary/21), floor(salary/21) from employees;

-- 1-2) ROUND(): 반올림 / TRUNC(): 숫자 절삭
select salary, salary/21,
       round(salary/21), round(salary/21, 2), round(salary/21, -1),
       trunc(salary/21), trunc(salary/21, 2), trunc(salary/21, -1)
from employees;

-- 1-3) MOD(): 나머지 구함
select salary, salary/21, mod(salary, 21) from employees;

-- 1-4) SIGN(): 양수일 경우 1, 음수일 경우 -1, 나머지는 0을 반환
select sign(-123), sign(0), sign(123) from dual;

-- 1-5) POWER(): 거듭제곱 / SQRT(): 제곱근
select power(3, 3), sqrt(4) from dual;

-- 2) 날짜 함수
-- 2-1) SYSDATE: 시스템 현재 날짜 반환
select sysdate, sysdate+1, sysdate-1 from dual;

-- 2-2) MONTH_BETWEEN(): 날짜와 날짜 사이의 개월 수 계산
select sysdate, hire_date, months_between(sysdate, hire_date) from employees;

--2-3) ADD_MONTHS(): 날짜에 지정한 개월수를 더함
select hire_date, add_months(hire_date, 2), add_months(hire_date, -2) from employees;

-- 2-4) NEXT_DAY(): 돌아오는 요일 날짜 반환 / LAST_DAY(): 월의 마지막 날짜 계산
select hire_date, next_day(hire_date, 3), next_day(hire_date, '수요일'), last_day(hire_date) from employees;

-- 2-5) ROUND(): 날짜를 연도나 월 단위로 반올림 / TRUNC(): 날짜를 연도나 월 단위로 절삭
select hire_date, round(hire_date, 'YEAR'), trunc(hire_date, 'MONTH') from employees;


-- 3) 변환 함수 : 데이터 타입을 필요에 따라 변환
-- 3-1) TO_CHAR(): 숫자와 날짜 데이터를 문자로 변환
select to_char(sysdate, 'CC AD Q') from dual;
select to_char(sysdate, 'YYYY/MM/DD') from dual;
select to_char(sysdate, 'W DAY') from dual;

select to_char(sysdate, 'AM HH:MI:SS') from dual;
select to_char(sysdate, 'HH24:MI:SS PM') from dual;
select to_char(sysdate, 'YY-MM-DD') from dual;
select to_char(sysdate, 'MM"월" DD"일"') from dual; 

select to_char(salary, '9999999') from employees;
select to_char(salary, '0999999') from employees;
select to_char(salary, '$999999') from employees;
select to_char(salary, 'L999999') from employees;
select to_char(salary, '99999.99') from employees;
select to_char(salary, '9,999,999') from employees;

-- 3-2) TO_NUMBER(): 숫자로된 문자열을 숫자 타입으로 변환
select to_number('123') from dual;
select to_number('123.123') from dual;

-- 3-3) TO_DATE(): 숫자로 된 문자열을 날짜 타입으로 변환
select to_date('20240909', 'YYMMDD') from dual;


-- 4) 일반 함수
-- 4-1) NVL(): NULL값을 특정한 값으로 치환
select department_name, manager_id from departments where manager_id is null;
select department_name, nvl(manager_id, 100) from departments where manager_id is null;

select state_province from locations where state_province is null;
select nvl(state_province, 'None') from locations where state_province is null;

-- 4-2) NVL2(): NULL값인 경우와 아닌 경우를 구분하여 특정한 값으로 치환
select department_name, nvl2(manager_id, '관리자 있음', '관리자 없음') from departments;
select city, nvl2(state_province, '주소 있음', '주소 없음') from locations order by state_province;

-- 4-3) DECODE(): 데이터가 조건 값과 일치하면 치환값을 출력, 그렇지 않으면 기본값을 출력
select job_title, min_salary, decode(min_salary, 2500, min_salary*1.1, min_salary) from jobs where min_salary>=2500 order by min_salary;
select job_title, max_salary, decode(max_salary, 40000, max_salary*0.9, max_salary) from jobs where max_salary>=30000;

-- 4-4) CASE(): 복잡한 논리 조건 처리 함수
select job_title, min_salary,
    case
      when min_salary<4000 then min_salary*1.2
      when min_salary between 4000 and 6000 then min_salary*1.1
      else min_salary
    end as 최소급여변경
from jobs order by min_salary;

-- 4-5) RANK(), DENSE_RANK(), ROW_NUMBER()
-- RANK(): 공통 순위는 건너뛰어 다음 순위를 출력
-- DENSE_RANK(): 공통 순위를 건너뛰지 않고, 다음 순위를 출력
-- ROW_NUMBER(): 공통 순위 없이 순위를 출력
select first_name, salary,
       rank() over(order by salary desc) rank,
       dense_rank() over(order by salary desc) dense_rank,
       row_number() over(order by salary desc) row_number
from employees;

-- [실습] 숫자, 날짜 함수
-- jobs 테이블에서 min_salary 값을 30으로 나눈 값의 올림값과 내림값을 조회
select min_salary/30, ceil(min_salary/30), floor(min_salary/30) from jobs;

-- jobs 테이블에서 max_salary 값을 30으로 나눈 값을 소수점 둘째자리에서 반올림한 값과 정수 첫째 자리에서 반올림한 값을 조회
select max_salary/30, round(max_salary/30, 2), round(max_salary/30, -1) from jobs;

-- jobs 테이블에서 max_salary 값을 30으로 나눈 값을 소수점 셋째자리에서 절삭한 값과 정수 둘째 자리에서 절삭한 값을 조회
select max_salary/30, trunc(max_salary/30, 3), trunc(max_salary/30, -2) from jobs;

-- 현재 날짜와 현재 날짜에서 한 달 뒤의 날짜를 조회
select sysdate, add_months(sysdate, 1) from dual;

-- 현재 날짜와 현재 날짜에서 돌아오는 월요일과 금요일의 날짜를 조회
select sysdate, next_day(sysdate, '월'), next_day(sysdate, 6) from dual;

-- [실습] 변환 함수
-- 현재 날짜의 월/일과 요일을 조회
select sysdate, to_char(sysdate, 'MM/DD'), to_char(sysdate, 'DAY') from dual;

-- 현재 시간의 오전 또는 오후 그리고 시:분을 조회
select sysdate, to_char(sysdate, 'AM HH:MI') from dual;

-- 2025년 01월 01일의 요일을 조회
select date'2025-01-01', to_char(date'2025-01-01', 'DAY') from dual;

-- [실습] 일반 함수
-- employees 테이블에서 salary, commission_pct, 그리고 salary에 commission_pct를 곱한 값을 salary에 반영하고,
-- commission_pct 정렬 순으로 조회(commission_pct가 null인 경우에는 salary 그대로 반영)
select salary, commission_pct, nvl2(commission_pct, salary*commission_pct, salary)
from employees order by commission_pct;

-- employees 테이블에서 first_name, last_name, department_id, salary 그리고
-- department_id가 50인 경우 salary를 10% 증가시킨 값을 '급여인상', 
-- department_id가 100인 경우 salary를 10% 감소시킨 값을 '급여감소'로 조회
select first_name, last_name, department_id, salary,
    case
      when department_id=50 then salary*1.1
    end as 급여인상,
    case
      when department_id=100 then salary*0.9
    end as 급여감소
from employees where department_id in(50,100);

-- jobs 테이블에서 job_title에 Manager가 들어간 데이터 중에 job_title, max_salary, 그리고
-- max_salary가 20000 이상인 것은 '상위', 10000에서 20000 사이인 것은 '중위',
-- 그 밖에는 '하위'로 표기하는 '급여등급'을 조회
select * from jobs where job_title like '%Manager';
select job_title, max_salary,
    case
      when max_salary>=20000 then '상위'
      when max_salary between 10000 and 20000 then '중위'
      else '하위'
    end as 급여등급
from jobs where job_title like '%Manager';


-- 3. 집계 및 그룹 함수
-- 1) 집계 함수
-- 1-1) COUNT(): 열의 행 갯수를 구하는 함수
select count(*) from employees;
select count(salary) from employees;
select count(manager_id) from employees;  -- null 은 갯수에서 제외
select count(commission_pct) from employees;

-- 1-2) SUM() / AVG()
select sum(salary), avg(salary) from employees;
select sum(salary), count(salary) from employees;
select first_name, salary, sum(salary) over (order by first_name) from employees;

--1-3) MIN() / MAX()
select min(salary), max(salary) from employees;
select min(first_name), max(first_name) from employees;

-- 1-4) STDDEV(): 표준편차 / VARIANCE(): 분산
select stddev(salary), variance(salary) from employees;
select first_name, salary, stddev(salary) over (order by first_name) from employees where department_id=50;


-- 2) 그룹 함수
-- 2-1) GROUP BY 절
select job_id, sum(salary), avg(salary) from employees group by job_id;
select job_id, sum(salary), avg(salary) from employees where department_id=50 group by job_id;
select department_id, min(salary), max(salary) from employees group by department_id;
select department_id, min(salary), max(salary) from employees where hire_date > '20070101' group by department_id;
select country_id, count(country_id) from locations group by country_id order by country_id;

-- 2-2) 다중 GROUP BY 절
-- employees 테이블 전체 레코드 조회
select * from employees;

-- department_id 50~100 레코드의 salary 합, 평균 구하기
select sum(salary), avg(salary) from employees where department_id between 50 and 100;

-- department_id 50~100 레코드중 department_id 기준으로 그룹화하여 그룹의 salary 합, 평균 구하기
-- 일반 컬럼과 집계함수를 같이 사용할 경우 GROUP BY절로 그룹핑 기준을 정해줘야 함!
-- group by 없이는 어떤 방식으로 일반 컬럼의 값을 집계함수의 결과와 연결해야 할지 알 수 없음
select department_id, sum(salary), avg(salary)
from employees 
where department_id between 50 and 100
group by department_id;

-- department_id 50~100 레코드중 1차 department_id 그룹, 2차 job_id로 그룹화 하여 그룹의 salary 합과 평균 구하기
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

-- 2-3) HAVING 절: GROUP BY의 조건절
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

-- [실습] 집계 함수
-- employees 테이블에서 salary가 8000이상인 직원의 수를 조회
select count(*) from employees where salary>=8000;

-- employees 테이블에서 hire_date가 2007년 1월 1일 이후인 직원의 수를 조회
select count(*) 직원수 from employees where hire_date>='07/01/01';

-- jobs 테이블에서 max_salary 값의 합계와 평균을 조회
select sum(max_salary), avg(max_salary) from jobs;

-- employees 테이블에서 job_id가 'IT_PROG'인 직원의 salary 합계와 평균을 조회
select sum(salary), avg(salary) from employees where job_id='IT_PROG';

-- employees 테이블에서 department_id가 50과 80 사이인 직원의
-- first_name, salary, 그리고 commission_pct의 평균값을
-- first_name 정렬 기준으로 조회 (null 값은 0으로 출력)
select first_name, salary, avg(nvl(commission_pct, 0)) over (order by first_name)
from employees
where department_id between 50 and 80;

-- jobs 테이블에서 max_salary 값의 최솟값과 max_salary 값의 최댓값을 조회
select * from jobs;
select min(max_salary), max(max_salary) from jobs;

-- jobs 테이블에서 job_title이 'Programmer'인 직업의 max_salary 값의 최솟값과 max_salary 값의 최댓값을 조회
select job_title, max_salary from jobs where job_title='Programmer';
select min(max_salary), max(max_salary) from jobs where job_title='Programmer';

-- employees 테이블에서 department_id가 50인 데이터의 hire_date 최소값과 최댓값 조회
select min(hire_date), max(hire_date) from employees where department_id=50;

-- employees 테이블에서 department_id가 100인 데이터의 first_name, salary, 그리고 salary의 분산값을 hire_date 정렬 기준으로 조회
select first_name, salary, variance(salary) over (order by hire_date)from employees where department_id=100;

-- [실습] 그룹 함수
-- employees 테이블에서 hire_date 값이 2004년 1월 1일부터 2006년 12월 31일 사이의 데이터를
-- job_id 기준으로 그룹화한 뒤에 job_id와 salary 최솟값과 최대값을 조회
select job_id, min(salary), max(salary) from employees
where hire_date between '04/01/01' and '06/12/31'
group by job_id;

-- employees 테이블에서 department_id 가 50과 80인 데이터를
-- department_id와 job_id 기준으로 그룹화한 뒤에 department_id와 job_id, salary 합계, 최솟값, 최대값을
-- job_id 기준으로 정렬하여 조회
select department_id, job_id, sum(salary), min(salary), max(salary)
from employees
where department_id in (50, 80)
group by department_id, job_id
order by job_id;

-- employees 테이블에서 department_id와 job_id 기준으로 그룹화한 뒤에 
-- salary 평균값이 12000 이상인 데이터만 department_id와 job_id, salary 최솟값, 최대값, 평균을
-- department_id 기준으로 정렬하여 조회
select department_id, job_id, min(salary), max(salary), avg(salary)
from employees
group by department_id, job_id
having avg(salary)>=12000
order by department_id;