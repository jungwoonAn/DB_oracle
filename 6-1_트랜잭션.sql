-- ���̺� ��ȸ
select * from user_tables;

-- ���̺� ����(��Ű��&������)
create table countries_copy as select * from countries;

select * from countries_copy;

-- ������ �߰� ����
insert all
    into countries_copy (country_id, country_name, region_id) values ('AT', 'Austria', 1)
    into countries_copy (country_id, country_name, region_id) values ('NO', 'Norway', 1)
    into countries_copy (country_id, country_name, region_id) values ('ID', 'Indonesia', 3)
    into countries_copy (country_id, country_name, region_id) values ('TR', 'Turkey', 4)
select * from dual;

select * from countries_copy;

-- �ѹ����� = ���̺�����Ʈ ����
savepoint save1;

-- ������ ���� �۾�
delete from countries_copy
where country_id in ('AT','NO','ID','TR');

select * from countries_copy;

-- ���̺�����Ʈ�� �ѹ�
rollback to save1; --�ڵ� Ŀ�� ��Ȱ��ȭ �ؾ߸� ��� ����

select * from countries_copy;

-- Ʈ����� ����
commit;