select * from user_tables;

-- 1. create table
-- ���ο� ���̺� ����
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
--  minvalue 1 maxvalue 9999;

select * from customers;

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


-- 2-1. alter table add
-- ���̺� �� �߰�
alter table customers add(gender varchar2(10));
alter table customers add(age number);
alter table customers add(dob date);

-- �߰��� �÷��� ������ �߰�(����)
update customers set gender='male', age=25, dob='09/01/01' where customer_id=1;
update customers set gender='male', age=45, dob='89/01/01' where customer_id=2;
update customers set gender='male', age=35, dob='99/01/01' where customer_id=5;

select * from customers;

-- 2-2. alter table add constraint
-- ���̺� �� �߰�
alter table customers add constraint AK_email unique (email);
alter table customers add constraint AK_phone unique (phone_number);
alter table customers add constraint CK_age check (age>=0);

desc customers;


-- 2-3. alter table modify
-- ���̺��� �� ����
alter table customers modify (first_name varchar2(30));
alter table customers modify (last_name varchar2(30));
alter table customers modify (email varchar2(30));
alter table customers modify age default 0;

-- ���ڵ� ����
update customers
set first_name='Steven Paul', gender='male', age=50, dob='50/01/01'
where customer_id=3;

update customers
set  first_name='William Henry', gender='male', age=40, dob='89/01/01'
where customer_id=4;

insert into customers (customer_id, first_name, last_name, email)
values (6, 'Lawrence Edward', 'Page', 'larry');

select * from customers;


-- 2-3. alter table rename / drop column
-- ���̺��� �� �̸� ����
alter table customers
rename column phone_number to phone;

alter table customers
rename column gender to sex;

alter table customers
rename column dob to date_of_birth;

-- ���̺��� ��/�������� ����
alter table customers
drop column date_of_birth;

alter table customers
drop constraint age;

alter table customers
drop column sex;


-- 3. truncate / drop table
-- ���̺��� ��� ������ ���� (���̺� ���� ����)
truncate table customers;

select * from customers;

-- ���̺� ���� ����(���̺��� ��� ������ �Ӹ� �ƴ϶� ������ ����/��� �ε����� ���� ���ǵ� ����)
drop table customers;

select * from user_tables;

-- ������ ����
drop sequence customers_seq;


-- [�ǽ�] ���̺� ����
-- products ���̺� ����
create table products(
    product_id number not null primary key,
    product_name varchar2(10) not null,
    reg_date date
);

-- products ���̺� ������ ����
create sequence products_seq increment by 1 start with 1;

select * from products;

-- products ���̺� ������ ����
insert into products values(products_seq.nextval, 'Computer', '24/01/01');
insert into products values(products_seq.nextval, 'Smartphone', '24/02/01');
insert into products values(products_seq.nextval, 'Television', '24/03/01');

-- products ���̺� �� �߰�
alter table products add (weight number);
alter table products add constraint CK_weight check (weight>=0);

alter table products add (price number);
alter table products add constraint CK_price check (price>=0);

-- products ���̺� ������ ����
update products set weight=10, price=1600000 where product_id=1;
update products set weight=0.2, price=1000000 where product_id=2;
update products set weight=20, price=2000000 where product_id=3;

select * from products;

-- products ���̺� �� ����
alter table products modify (product_name varchar2(30));

alter table products
rename column reg_date to regist_date;

desc products;

-- products ���̺��� �� ����
alter table products
drop column weight;

-- products ���̺��� ��� ������ ����
truncate table products;

-- products ���̺� ����
drop table products;
drop sequence products_seq;

select * from user_tables;