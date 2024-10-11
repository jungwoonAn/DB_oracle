-- 1) �⺻ Ű ���� ���� ����
-- ORA-00001: ���Ἲ ���� ����(HR.REG_ID_PK)�� ����˴ϴ�
insert into regions values(3, 'Asia');  
desc regions;
select * from regions where region_id=3;

-- ORA-00001: ���Ἲ ���� ����(HR.COUNTRY_C_ID_PK)�� ����˴ϴ�
insert into countries values ('AR', 'Argentina', 2);
desc countries;
select * from countries where country_id='AR';

-- ORA-00001: ���Ἲ ���� ����(HR.LOC_ID_PK)�� ����˴ϴ�
insert into locations values (1000, 'Street', 12345, 'Korea', null, 'KR');
desc locations;
select * from locations where location_id=1000;

-- ORA-00001: ���Ἲ ���� ����(HR.DEPT_ID_PK)�� ����˴ϴ�
insert into departments values (10, 'Admin', 200, 1700);
desc departments;
select * from departments where department_id=10;

-- ORA-00001: ���Ἲ ���� ����(HR.EMP_EMP_ID_PK)�� ����˴ϴ�
insert into employees
values (100, 'Suan' , 'Lee', 'SUAN', '515.123.4567', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;
select * from employees where employee_id=100;

-- 2) �ܷ� Ű ���� ���� ����
-- ORA-02291: ���Ἲ ��������(HR.COUNTR_REG_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into countries values ('KR', 'South Korea', 5);
desc countries;
select * from regions where region_id=5;

-- ORA-02291: ���Ἲ ��������(HR.LOC_C_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into locations values (3300, 'Street', 12345, 'Seoul', null, 'KR');
desc locations;
select * from countries where country_id='KR';

-- ORA-02291: ���Ἲ ��������(HR.DEPT_LOC_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into departments values (280, 'Testing', null, 3300);
desc departments;
select * from locations where location_id=3300;

-- ORA-02291: ���Ἲ ��������(HR.EMP_JOB_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into employees
values (207, 'Suan' , 'Lee', 'SUAN', '010.123.1234', '21/01/01', 'IT_QA', 10000, null, null, null);
desc employees;
select * from jobs where job_id='IT_QA';

-- ORA-02291: ���Ἲ ��������(HR.JHIST_DEPT_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into job_history values (300, '21/01/01', '21/10/01', 'IT_PROG', 300);
desc job_history;
select * from departments where department_id=300;

-- 3) ���� Ű ���� ���� ����
-- ORA-00001: ���Ἲ ���� ����(HR.EMP_EMAIL_UK)�� ����˴ϴ�
insert into employees
values (207, 'Suan' , 'Lee', 'SKING', '515.123.4567', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;
select * from employees where email='SKING';

-- 4) NOT NULL ���� ���� ����
-- ORA-01400: NULL�� ("HR"."LOCATIONS"."CITY") �ȿ� ������ �� �����ϴ�
insert into locations values (3300, 'Street', 12345, null, null, 'US');
desc locations;

-- ORA-01400: NULL�� ("HR"."DEPARTMENTS"."DEPARTMENT_NAME") �ȿ� ������ �� �����ϴ�
insert into departments values (280, null, null, 3300);
desc departments;

-- ORA-01400: NULL�� ("HR"."EMPLOYEES"."EMAIL") �ȿ� ������ �� �����ϴ�
insert into employees
values (207, 'Suan' , 'Lee', null, '123.123.1234', '21/01/01', 'IT_PROG', 10000, null, null, null);
desc employees;

-- ORA-01400: NULL�� ("HR"."JOB_HISTORY"."START_DATE") �ȿ� ������ �� �����ϴ�
insert into job_history values (200, null, '21/10/01', 'IT_PROG', 200);
desc job_history;

-- ORA-01400: NULL�� ("HR"."JOB_HISTORY"."END_DATE") �ȿ� ������ �� �����ϴ�
insert into job_history values (200, '21/01/01', null, 'IT_PROG', 200);

-- 5) CHECK ���� ���� ����
-- ORA-02290: üũ ��������(HR.EMP_SALARY_MIN)�� ����Ǿ����ϴ�
insert into employees
values (207, 'Suan' , 'Lee', 'SUAN', '123.123.1234', '21/01/01', 'IT_PROG', 0, null, null, null);
-- NUMBER[(P[,S])] : P : ���е��� ��Ÿ���� ���� ��(1~38), ������?������?�Ҽ���?������?��ȿ?����?�ڸ���(-84~127)
desc employees;

-- ORA-02290: üũ ��������(HR.JHIST_DATE_INTERVAL)�� ����Ǿ����ϴ�
insert into job_history values (200, '21/10/01', '21/01/01', 'IT_PROG', 200);
desc job_history;