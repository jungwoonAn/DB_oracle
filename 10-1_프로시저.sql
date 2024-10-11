-- 1. CREATE OR REPLACE PROCEDURE
-- 1)첫 번째 직원 출력 프로시저
create or replace procedure first_emp
as
    emp_name varchar2(20);
begin
    select first_name || ' ' || last_name into emp_name
    from employees where employee_id=100;
    dbms_output.put_line(emp_name);
end;
/
-- 서버 출력 허용
set serveroutput on;

-- 프로시저 실행
execute first_emp();


-- 2) 직원 정보 출력 프로시저
-- 매개변수 사용(IN: 입력, OUT: 출력, IN OUT: 입출력 동시)
create or replace procedure print_emp (
    emp_id in employees.employee_id%TYPE
) AS
    emp_name varchar2(20);
begin
    select first_name || ' ' || last_name into emp_name
    from employees where employee_id=emp_id;
    dbms_output.put_line(emp_name);
end;
/

-- 프로시저 실행
exec print_emp(101);


-- 3) 직원 평균 salary 출력 프로시저
create or replace procedure print_emp(
    emp_id in employees.employee_id%TYPE
) as
    emp_name varchar2(20);
begin
    select first_name||' '||last_name into emp_name
    from employees where employee_id=emp_id;
    dbms_output.put_line(emp_name);
end;
/

-- 프로시저 실행
exec print_Emp(100);
exec print_Emp(101);


-- 3-2) 급여 인상 프로시저
create or replace procedure increase_salary (
    p_employee_id in employees.employee_id%TYPE,
    p_increment in number
) as
begin
    update employees
    set salary = salary + p_increment
    where employee_id = p_employee_id;
    commit;
    dbms_output.put_line('Employee ID '|| p_employee_id ||': Salary increased by '|| p_increment);
end;
/

-- 프로시저 실행
exec increase_salary(102, 500);
select * from employees where employee_id=102;


-- 4) 직원 평균 salary 출력 프로시저
create or replace procedure emp_avg_salary (
    avg_salary out number
) as
begin
    select avg(salary) into avg_salary
    from employees;
end emp_avg_salary;
/

-- 프로시저 실행
declare
    avg_salary number;
begin
    emp_avg_salary(avg_salary);
    dbms_output.put_line(avg_salary);
end;
/

-- 5) IF ELSE문 사용 프로시저
create or replace procedure if_salary (
    salary in number
) as
    avg_salary number;
begin
    select avg(salary) into avg_salary from employees;
    
    if salary >= avg_salary then
        dbms_output.put_line('평균 이상');
    else
        dbms_output.put_line('평균 미만');
    end if;
end;
/

-- 프로시저 실행
exec if_salary(7000);
exec if_salary(3000);


-- 6) CASE문 사용 프로시저
create or replace procedure case_hire_date (
    emp_email in employees.email%TYPE
) as
    hire_year nchar(2);
    text_msg varchar2(20);
begin
    select to_char(hire_date, 'YY') into hire_year
    from employees
    where email = emp_email;
    
    case
        when (hire_year='01') then text_msg := '01년도에 입사';
        when (hire_year='02') then text_msg := '02년도에 입사';
        when (hire_year='03') then text_msg := '03년도에 입사';
        when (hire_year='04') then text_msg := '04년도에 입사';
        when (hire_year='05') then text_msg := '05년도에 입사';
        when (hire_year='06') then text_msg := '06년도에 입사';
        when (hire_year='07') then text_msg := '07년도에 입사';
        when (hire_year='08') then text_msg := '08년도에 입사';
        when (hire_year='09') then text_msg := '09년도에 입사';
        else text_msg := '01~09년도 이외에 입사';
    end case;
    dbms_output.put_line(text_msg);
end;
/

-- 프로시저 실행
execute case_hire_Date('SKING');


-- 7) WHILE문 사용 프로시저
create or replace procedure while_print
as
    str varchar(100);
    i number;
begin
    i := 1;
    while (i <= 10) loop
        str := '반복 횟수:' || '(' || i || ')';
        dbms_output.put_line(str);
        i := i+1;
    end loop;
end;
/

-- 프로시저 실행
exec while_print();


-- 8) OUT 파라미터 사용 프로시저
create or replace procedure out_emp (
    emp_id in employees.employee_id%TYPE,
    out_str out varchar2
) as
    emp_name varchar2(20);
begin
    select first_name||' '||last_name into emp_name
    from employees where employee_id = emp_id;
    
    if emp_id = null then
        out_str := '직원: 없음';
    else
        out_str := '직원: '||emp_name;
    end if;
end;
/

-- 프로시저 실행
declare
    out_str varchar2(30);
begin
    out_emp(100, out_Str);
    dbms_output.put_line(out_str);
end;
/

-- 프로시저 실행 (예외 발생): ORA-01403: 데이터를 찾을 수 없습니다.
declare
    out_str varchar2(30);
begin
    out_emp(300, out_Str);
    dbms_output.put_line(out_str);
end;
/


-- 9) 예외처리 사용 프로시저
create or replace procedure out_emp (
    emp_id in employees.employee_id%TYPE,
    out_str out varchar2
) as
    emp_name varchar2(20);
begin
    select first_name||' '||last_name into emp_name
    from employees where employee_id = emp_id;
    
    out_str := '직원: '||emp_name;
    exception
        when no_data_found then
            out_str := '직원: 없음';
end;
/

-- 프로시저 실행 (예외 발생)
declare
    out_str varchar2(30);
begin
    out_emp(300, out_Str);
    dbms_output.put_line(out_str);
end;
/

-- 프로시저 실행
declare
    out_str varchar2(30);
begin
    out_emp(100, out_Str);
    dbms_output.put_line(out_str);
end;
/


-- 10) IN OUT 파라미터 사용 프로시저
create or replace procedure in_out_emp (
    emp_name in out varchar2
) as
begin
    select first_name||' '||last_name into emp_name
    from employees
    where first_name=emp_name or last_name=emp_name;
    
    emp_name := '직원: '||emp_name;
    exception
        when no_data_found then
            emp_name := '직원: 없음';
end;
/

-- 프로시저 실행
declare
    emp_name varchar2(30) := 'Lisa';
begin
    in_out_emp(emp_name);
    dbms_output.put_line(emp_name);
end;
/

-- 프로시저 실행 (예외 발생): ORA-01422: 실제 인출은 요구된 것보다 많은 수의 행을 추출합니다
declare
    emp_name varchar2(30) := 'King';
begin
    in_out_emp(emp_name);
    dbms_output.put_line(emp_name);
end;
/

-- 11) rowtype 사용 프로시저
create or replace procedure rowtype_emp (
    emp_id in employees.employee_id%TYPE
) as
    emp_row employees%ROWTYPE;
begin
    select first_name, last_name, job_id
        into emp_row.first_name, emp_row.last_name, emp_row.job_id
    from employees where employee_id=emp_id;
    dbms_output.put_line(emp_row.first_name||' | '||
                         emp_row.last_name||' | '||
                         emp_row.job_id);
end;
/

-- 프로시저 실행
exec rowtype_emp(100);
exec rowtype_emp(200);


-- 12) record 사용 프로시저
create or replace procedure record_emp (
    emp_id in employees.employee_id%TYPE
) as
    TYPE emp_type is record (first_name varchar2(10),
                             last_name varchar2(10),
                             job_id varchar2(10));
    emp_record emp_type;
begin
    select first_name, last_name, job_id
        into emp_record.first_name, emp_record.last_name, emp_record.job_id
    from employees where employee_id=emp_id;
    dbms_output.put_line(emp_record.first_name||' | '||
                         emp_record.last_name||' | '||
                         emp_record.job_id);
end;
/

-- 프로시저 실행
execute record_emp(100);
execute record_emp(200);


-- 13) collection 사용 프로시저
create or replace procedure collection_ex
as
    type v_array_type is varray(5) of number(10);
    type nest_tbl_type is table of varchar2(10);
    type a_array_type is table of number(10) index by varchar2(10);
    v_array v_array_type;
    nest_tbl nest_tbl_type;
    a_array a_array_type; 
    idx varchar2(10);
begin
    v_array := v_array_type(1, 2, 3, 4, 5);
    nest_tbl := nest_tbl_type('A', 'B', 'C', 'D', 'E');
    a_array('A') := 1;
    a_array('B') := 2;
    a_array('C') := 3;
    a_array('D') := 4;
    a_array('E') := 5;
    
    for i in 1 .. 5 loop
        dbms_output.put_line(v_array(i) || ' | ' || nest_tbl(i));
    end loop;

    idx := a_array.first;
    while idx is not null loop
        dbms_output.put_line(idx || ' : ' || a_array(idx));
        idx := a_array.next(idx);
    end loop;
end;
/

-- 프로시저 실행
exec collection_ex();

-- 2. Cursor
-- cursor 사용 프로시저
create or replace procedure cursor_salary
as
    sal number := 0;
    cnt number := 0;
    total number := 0;
    cursor emp_cursor is select salary from employees;
begin
    open emp_cursor;
    loop
        fetch emp_cursor into sal;
        exit when emp_cursor%NOTFOUND;
        total := total + sal;
        cnt := cnt + 1;
    end loop;
    close emp_cursor;
    dbms_output.put_line('평균 SALARY: '|| (total / cnt));
end;
/

create or replace procedure cursor_salary
as
    sal number := 0;
    cnt number := 0;
    total number := 0;
    cursor emp_cursor is select salary from employees;
begin
    open emp_cursor;
    loop
        fetch emp_cursor into sal;
        exit when emp_cursor%NOTFOUND;
        
        -- salary가 NULL인 경우를 건너뜁니다.
        if sal is not null then
            total := total + sal;
            cnt := cnt + 1;
        end if;
        
        -- 중간값 디버깅 출력 (선택 사항)
        dbms_output.put_line('현재 합계: ' || total || ', 현재 카운트: ' || cnt);
    end loop;
    close emp_cursor;

    -- 직원 수가 0이 아닐 때만 평균 계산
    if cnt > 0 then
        dbms_output.put_line('평균 SALARY: ' || (total / cnt));
    else
        dbms_output.put_line('직원이 없습니다.');
    end if;
end;
/

-- 프로시저 실행
exec cursor_salary();