-- 1) 기본 키 제약 조건 위반
-- ORA-00001: 무결성 제약 조건(HR.REG_ID_PK)에 위배됩니다
insert into regions values(3, 'Asia');  
desc regions;
select * from regions where region_id=3;

-- ORA-00001: 무결성 제약 조건(HR.COUNTRY_C_ID_PK)에 위배됩니다
insert into countries values ('AR', 'Argentina', 2);
desc countries;
select * from countries where country_id='AR';

-- ORA-00001: 무결성 제약 조건(HR.LOC_ID_PK)에 위배됩니다
insert into locations values (1000, 'Street', 12345, 'Korea', null, 'KR');
desc locations;
select * from locations where location_id=1000;

-- ORA-00001: 무결성 제약 조건(HR.DEPT_ID_PK)에 위배됩니다
insert into departments values (10, 'Admin', 200, 1700);
desc departments;
select * from departments where department_id=10;

-- ORA-00001: 무결성 제약 조건(HR.EMP_EMP_ID_PK)에 위배됩니다
insert into employees
values (100, 'Suan' , 'Lee', 'SUAN', '515.123.4567', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;
select * from employees where employee_id=100;

-- 2) 외래 키 제약 조건 위반
-- ORA-02291: 무결성 제약조건(HR.COUNTR_REG_FK)이 위배되었습니다- 부모 키가 없습니다
insert into countries values ('KR', 'South Korea', 5);
desc countries;
select * from regions where region_id=5;

-- ORA-02291: 무결성 제약조건(HR.LOC_C_ID_FK)이 위배되었습니다- 부모 키가 없습니다
insert into locations values (3300, 'Street', 12345, 'Seoul', null, 'KR');
desc locations;
select * from countries where country_id='KR';

-- ORA-02291: 무결성 제약조건(HR.DEPT_LOC_FK)이 위배되었습니다- 부모 키가 없습니다
insert into departments values (280, 'Testing', null, 3300);
desc departments;
select * from locations where location_id=3300;

-- ORA-02291: 무결성 제약조건(HR.EMP_JOB_FK)이 위배되었습니다- 부모 키가 없습니다
insert into employees
values (207, 'Suan' , 'Lee', 'SUAN', '010.123.1234', '21/01/01', 'IT_QA', 10000, null, null, null);
desc employees;
select * from jobs where job_id='IT_QA';

-- ORA-02291: 무결성 제약조건(HR.JHIST_DEPT_FK)이 위배되었습니다- 부모 키가 없습니다
insert into job_history values (300, '21/01/01', '21/10/01', 'IT_PROG', 300);
desc job_history;
select * from departments where department_id=300;

-- 3) 유일 키 제약 조건 위반
-- ORA-00001: 무결성 제약 조건(HR.EMP_EMAIL_UK)에 위배됩니다
insert into employees
values (207, 'Suan' , 'Lee', 'SKING', '515.123.4567', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;
select * from employees where email='SKING';

-- 4) NOT NULL 제약 조건 위반
-- ORA-01400: NULL을 ("HR"."LOCATIONS"."CITY") 안에 삽입할 수 없습니다
insert into locations values (3300, 'Street', 12345, null, null, 'US');
desc locations;

-- ORA-01400: NULL을 ("HR"."DEPARTMENTS"."DEPARTMENT_NAME") 안에 삽입할 수 없습니다
insert into departments values (280, null, null, 3300);
desc departments;

-- ORA-01400: NULL을 ("HR"."EMPLOYEES"."EMAIL") 안에 삽입할 수 없습니다
insert into employees
values (207, 'Suan' , 'Lee', null, '123.123.1234', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;

-- ORA-01400: NULL을 ("HR"."JOB_HISTORY"."START_DATE") 안에 삽입할 수 없습니다
insert into job_history values (200, null, '21/10/01', 'IT_PROG', 200);
desc job_history;

-- ORA-01400: NULL을 ("HR"."JOB_HISTORY"."END_DATE") 안에 삽입할 수 없습니다
insert into job_history values (200, '21/01/01', null, 'IT_PROG', 200);

-- 5) CHECK 제약 조건 위반
-- ORA-02290: 체크 제약조건(HR.EMP_SALARY_MIN)이 위배되었습니다
insert into employees
values (207, 'Suan' , 'Lee', 'SUAN', '123.123.1234', '21/01/01', 'IT_PROG', 0, null, null, null);
-- NUMBER[(P[,S])] : P : 정밀도를 나타내느 정수 값(1~38), 스케일?값으로?소숫점?이하의?유효?숫자?자리수(-84~127)
desc employees;

-- ORA-02290: 체크 제약조건(HR.JHIST_DATE_INTERVAL)이 위배되었습니다
insert into job_history values (200, '21/10/01', '21/01/01', 'IT_PROG', 200);
desc job_history;