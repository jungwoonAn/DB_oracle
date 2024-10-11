-- 5. DML(Data Manipulation Language)-데이터 삽입, 수정, 삭제
-- 데이터 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)는 트랜잭션(Transaction) 과정으로 동작
-- 1) INSERT
select * from countries;

insert into countries
values('KR', 'South Korea', 3);

insert into countries (country_id, country_name, region_id)
values('KP', 'North Korea', 3);
----------
select * from departments;

insert into departments
values(280, 'Testing', 200, 1700);

insert into departments (department_id, department_name, location_id)
values(290, 'Data Analytics', 1700);
----------
select * from jobs;

insert into jobs
values('IT DS', 'Data Scientist', 10000, 20000);

insert into jobs(job_id, job_title, min_salary, max_salary)
values('IT DA', 'Data Analyst', 10000, 20000);

-- DML 명령어를 최종적으로 반영하기 위한 방법
commit;

-- 2) UPDATE
update countries
set country_name='Democratic People''s Republic of Korea'
where country_id='KP';

update countries
set country_name='Republic of Korea'
where country_id='KR';

select * from countries;
----------
select * from departments where department_id=280;

update departments
set department_name='IT Testing'
where department_id=280;

update departments
set department_name='IT Quality Assurance'
where department_id=280;
----------
select * from jobs;

update jobs
SET job_id = 'IT QA', job_title = 'Quality Assurance'
where job_id = 'IT DS';

-- 3) DELETE
select * from countries where country_id like 'K%';

delete from countries where country_id='KP';
delete from countries where country_id='KR';
----------
select * from departments where department_id>260;

delete from departments where department_id=280;
delete from departments where department_id=290;
----------
select * from jobs where job_id like 'IT%';

delete from jobs where job_id='IT QA';
delete from jobs where job_id='IT DA';

-- [실습] INSERT
-- countries 테이블에 다음 표에 해당하는 데이터를 삽입
select * from countries;

insert into countries values('AT', 'Austria', 1);
insert into countries values('NO', 'Norway', 1);
insert into countries values('ID', 'Indonesia', 3);
insert into countries values('TR', 'Turkey', 4);

-- departments 테이블에 다음 표에 해당하는 데이터를 삽입
select * from departments where department_id>=270;

insert into departments values(280, 'Advertising', 200, 1700);
insert into departments values(290, 'Sales Support', 145, 1700);
insert into departments(department_id, department_name, location_id)
values(300, 'Advertising', 1700);
insert into departments(department_id, department_name, location_id)
values(310, 'E-Commerce', 1700);

-- jobs 테이블에 다음 표에 해당하는 데이터를 삽입
select * from jobs;

insert into jobs values('ADV', 'Advisor', 1000, 20000);
insert into jobs values('IT ENG', 'Engineer', 800, 15000);
insert into jobs values('IT RES', 'Researcher', 1200, 22000);

commit;
-- [실습] UPDATE
-- 다음 테이블에 변경된 부분을 반영하는 SQL 작성
select * from departments where department_id between 280 and 310;

update departments set location_id=2000 where department_id between 280 and 310;
update departments set manager_id=102 where department_id>=280 and manager_id is null; 
----------
select * from jobs;

update jobs set min_salary=12000, max_salary=22000 where job_id='ADV';
update jobs set max_salary=16000 where job_id='IT ENG';
update jobs set job_title='Research Engineer', max_salary=24000 where job_id='IT RES';

commit;
-- [실습] DELETE
-- 다음 테이블의 데이터를 삭제하는 SQL 작성
select * from countries where country_id in('AT','NO','ID','TR');
delete from countries where country_id in('AT','NO','ID','TR');
----------
select * from departments where department_id between 280 and 310;
delete from departments where department_id between 280 and 310;
----------
select * from jobs where job_id in('ADV','IT ENG','IT RES');
delete from jobs where job_id in('ADV','IT ENG','IT RES');

commit;