-- 2. SELECT INDEX
-- �ε��� ��ȸ
select * from user_indexes;
select * from user_indexes where table_name='EMPLOYEES';

-- �ε��� �÷� ��ȸ
select * from user_ind_columns;
select * from user_ind_columns where table_name='EMPLOYEES';

-- �ε��� ��� ����
select * from employees where employee_id=100;
select * from employees where first_name='Steven';

-- ���� ���̺� customer ����
create table customers(
    customer_id number not null primary key,
    first_name varchar2(10) not null,
    last_name varchar2(10) not null,
    email varchar2(10),
    phone_number varchar2(20),
    regist_date date
);

-- ������ ����
create sequence customers_seq increment by 1 start with 1;

-- ���ڵ� �߰�
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

-- customer ���̺� �ε��� ��ȸ
select * from user_indexes where table_name='CUSTOMERS';

-- 3-1. CREATE INDEX
-- �ε��� ����
create index regist_date_idx on customers (regist_date);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where regist_Date='24/01/01';

-- ���� �Ӽ� �ε��� ����
create index name_idx on customers (first_name, last_name);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where first_name='Suan';

-- 3-2. CREATE UNIQUE INDEX
-- ���� �ε��� ����
create unique index email_idx on customers (email);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where email='suan';

create unique index phone_idx on customers (phone_number);

select * from user_indexes where table_name='CUSTOMERS';
select * from customers where phone_number='010-1234-1234';

-- 4. DROP INDEX / TABLE
-- �ε��� ����
drop index regist_date_idx;
drop index name_idx;
drop index email_idx;
drop index phone_idx;

select * from user_indexes where table_name='CUSTOMERS';

-- ���̺� ����
drop table customers;

select * from user_indexes where table_name='CUSTOMERS';


-- [�ǽ�] ���̺� ���� �� ������ ����
-- products ���̺� ����
create table products(
    product_id number not null primary key,
    product_name varchar2(10) not null,
    reg_date date,
    weight number,
    price number
);

-- products ���̺� ������ ����
create sequence products_seq increment by 1 start with 1;

select * from products;

-- products ���̺� ������ ����
insert into products values(products_seq.nextval, 'Computer', '24/01/01', 10, 1600000);
insert into products values(products_seq.nextval, 'Smartphone', '24/02/01', 0.2, 1000000);
insert into products values(products_seq.nextval, 'Television', '24/03/01', 20, 2000000);

-- [�ǽ�] �ε��� ����
select * from user_indexes where table_name='PRODUCTS';

-- products ���̺��� reg_date �÷��� ���� �ε��� reg_date_idx ����
create index reg_date_idx on products (reg_date);

-- products ���̺��� weight �÷��� ���� �ε��� weight_idx ����
create index weight_idx on products (weight);

-- products ���̺��� price �÷��� ���� �ε��� price_idx ����
create index price_idx on products (price);

-- products ���̺��� product_name �÷��� ���� ���� �ε��� product_name_idx ����
create unique index product_name_idx on products (product_name);

-- products ���̺� ���� ����� �ε��� ��ȸ
select * from user_indexes where table_name='PRODUCTS';

-- products ���̺� ���� ����� �ε��� �÷� ��ȸ
select * from user_ind_columns where table_name='PRODUCTS';

-- products ���̺��� reg_date_idx �ε��� ����
drop index reg_date_idx;

-- products ���̺��� weight_idx �ε��� ����
drop index weight_idx;

-- products ���̺��� price_idx �ε��� ����
drop index price_idx;

-- products ���̺��� product_name_idx �ε��� ����
drop index product_name_idx;

-- products ���̺� ����
drop table products;