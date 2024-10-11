-- 2. SELECT INDEX
-- 인덱스 조회
select * from user_indexes;
select * from user_indexes where table_name='EMPLOYEES';

-- 인덱스 컬럼 조회
select * from user_ind_columns;
select * from user_ind_columns where table_name='EMPLOYEES';

-- 인덱스 사용 여부
select * from employees where employee_id=100;
select * from employees where first_name='Steven';

-- 예제 테이블 customer 생성
create table customers(
    customer_id number not null primary key,
    first_name varchar2(10) not null,
    last_name varchar2(10) not null,
    email varchar2(10),
    phone_number varchar2(20),
    regist_date date
);

-- 시퀀스 생성
create sequence customers_seq increment by 1 start with 1;

-- 레코드 추가
insert into customers 
values (customers_seq.nextval, 'Suan', 'Lee', 'suan', '010-1234-1234', '24/01/01');

insert into customers 
values (customers_seq.nextval, 'Elon', 'Musk', 'elon', '010-1111-2222', '24/05/01');

insert into customers 
values (customers_seq.nextval, 'Steve', 'Jobs', 'steve', '010-3333-4444', '24/10/01');

insert into customers 
values (customers_seq.nextval, 'Bill', 'Gates', 'bill', '010-5555-6666', '24/11/01');

insert into customers 
values (customers_seq.nextval, 'Mark', 'Zuckerberg', 'mark', '010-7777-8888', '24/12/01');

select * from customers;

-- customer 테이블 인덱스 조회
select * from user_indexes where table_name='CUSTOMERS';

-- 3-1. CREATE INDEX
-- 인덱스 생성
create index regist_date_idx on customers (regist_date);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where regist_Date='24/01/01';

-- 다중 속성 인덱스 생성
create index name_idx on customers (first_name, last_name);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where first_name='Suan';

-- 3-2. CREATE UNIQUE INDEX
-- 고유 인덱스 생성
create unique index email_idx on customers (email);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where email='suan';

create unique index phone_idx on customers (phone_number);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where phone_number='010-1234-1234';

-- 4. DROP INDEX / TABLE
-- 인덱스 삭제
drop index regist_date_idx;
drop index name_idx;
drop index email_idx;
drop index phone_idx;

select * from user_indexes where table_name='CUSTOMERS';

-- 테이블 삭제
drop table customers;

select * from user_indexes where table_name='CUSTOMERS';


-- [실습] 테이블 생성 및 데이터 삽입
-- products 테이블 생성
create table products(
    product_id number not null primary key,
    product_name varchar2(10) not null,
    reg_date date,
    weight number,
    price number
);

-- products 테이블 시퀀스 생성
create sequence products_seq increment by 1 start with 1;

select * from products;

-- products 테이블에 데이터 삽입
insert into products values(products_seq.nextval, 'Computer', '24/01/01', 10, 1600000);
insert into products values(products_seq.nextval, 'Smartphone', '24/02/01', 0.2, 1000000);
insert into products values(products_seq.nextval, 'Television', '24/03/01', 20, 2000000);

-- [실습] 인덱스 생성
select * from user_indexes where table_name='PRODUCTS';

-- products 테이블의 reg_date 컬럼에 대한 인덱스 reg_date_idx 생성
create index reg_date_idx on products (reg_date);

-- products 테이블의 weight 컬럼에 대한 인덱스 weight_idx 생성
create index weight_idx on products (weight);

-- products 테이블의 price 컬럼에 대한 인덱스 price_idx 생성
create index price_idx on products (price);

-- products 테이블의 product_name 컬럼에 대한 고유 인덱스 product_name_idx 생성
create unique index product_name_idx on products (product_name);

-- products 테이블에 대한 사용자 인덱스 조회
select * from user_indexes where table_name='PRODUCTS';

-- products 테이블에 대한 사용자 인덱스 컬럼 조회
select * from user_ind_columns where table_name='PRODUCTS';

-- products 테이블의 reg_date_idx 인덱스 삭제
drop index reg_date_idx;

-- products 테이블의 weight_idx 인덱스 삭제
drop index weight_idx;

-- products 테이블의 price_idx 인덱스 삭제
drop index price_idx;

-- products 테이블의 product_name_idx 인덱스 삭제
drop index product_name_idx;

-- products 테이블 삭제
drop table products;