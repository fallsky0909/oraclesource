--JAVADB

-- userTBL 테이블 생성
-- no(번호 - 숫자(4)), username(이름 - 한글(4)), birthYear(년도 - 숫자(4)), addr(주소 - 문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정(제약조건명 pk_userTBL)
create table userTBL(
    no number(4) constraint pk_userTBL primary key,
    username nvarchar2(10) not null,
    birthYear number(4) not null,
    addr nvarchar2(50) not null,
    mobile nvarchar2(20)
    );
    
-- 시퀀스 생성
-- user_seq 생성(기본)
create sequence user_seq;

-- insert
-- no : user_seq 값 넣기

insert into userTBL (no, username, birthYear, addr, mobile)
   values (user_seq.nextval, '홍길동', 2010, '서울시 종로구 123', '010-1234-5768');
   
commit;

-- 모든 칼럼 not null

-- paytype : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성
create table paytype(
    pay_no number(1) primary key,
    info nvarchar2(4) not null
    );
    
create sequence paytype_seq;

insert into paytype values(paytype_seq.nextval, 'card');
insert into paytype values(paytype_seq.nextval, 'cash');

select * from paytype; -- 1: card, 2: cash
-- suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no를 참조해서 사용)
create table suser(
    user_id number(4) primary key,
    name nvarchar2(6)not null,
    pay_no number(1) not null references paytype(pay_no)
    );

-- product
-- product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
create table product(
    product_id number(8) primary key,
    pname nvarchar2(30) not null,
    price number(20) not null,
    content nvarchar2(100) not null
    );

create sequence product_seq;

-- order
-- order_id(숫자-8 pk), user_id(user 테이블의 user_id 참조), product_id(product 테이블의 product_id 참조)
-- order_seq 생성
create table orders(
    order_id number(8) primary key,
    user_id number(4) references suser(user_id),
    product_id number(8) references product(product_id)
    );
    
create sequence order_seq;