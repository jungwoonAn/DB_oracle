-- 1. CREATE OR REPLACE FUNCTION
-- 1) to_yyyymmdd 함수(오늘날짜를 yyyymmdd형식으로 출력)
create or replace function to_yyyymmdd(date Date)
    return varchar2
is
    char_date varchar2(20);
begin
    char_date := TO_CHAR(date, 'YYYYMMDD');
    return char_date;
end;
/

-- 함수 실행
select to_yyyymmdd(sysdate) from dual;

-- 2) get_age 함수(만나이 출력)
create or replace function get_age(date Date)
    return number
is
    age number;
begin
    age := trunc(months_between(trunc(sysdate), to_yyyymmdd(date))/12);
    return age;
end;
/

-- 함수 실행
select get_age('20021010') from dual;


-- 2. CREATE OR REPLACE TYPE
-- 타입 정의
create or replace type ename_type as object
(
    first_name varchar2(20),
    last_name varchar2(20)
);
/
-- 테이블 타입 정의
create or replace type ename_table as table of ename_type;
/

-- 테이블 반환 함수 (Pipelined Table Function)
create or replace function emp_table(emp_id number)
    return ename_table
    pipelined
is
    ename ename_type;
begin
    for emp in(select first_name, last_name from employees
                where employee_id=emp_id)
    loop
        ename := ename_type(emp.first_name, emp.last_name);
        pipe row(ename);
    end loop;
    return;
end;
/

-- 함수 실행
select * from table(emp_table(100));