-- 테이블 조회
select * from user_tables;

-- 테이블 복사(스키마&데이터)
create table countries_copy as select * from countries;

select * from countries_copy;

-- 데이터 추가 삽입
insert all
    into countries_copy (country_id, country_name, region_id) values ('AT', 'Austria', 1)
    into countries_copy (country_id, country_name, region_id) values ('NO', 'Norway', 1)
    into countries_copy (country_id, country_name, region_id) values ('ID', 'Indonesia', 3)
    into countries_copy (country_id, country_name, region_id) values ('TR', 'Turkey', 4)
select * from dual;

select * from countries_copy;

-- 롤백지점 = 세이브포인트 생성
savepoint save1;

-- 데이터 삭제 작업
delete from countries_copy
where country_id in ('AT','NO','ID','TR');

select * from countries_copy;

-- 세이브포인트로 롤백
rollback to save1; --자동 커밋 비활성화 해야만 사용 가능

select * from countries_copy;

-- 트랜잭션 종료
commit;