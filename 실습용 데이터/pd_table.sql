drop table pd;
create table pd
(
 no number primary key,
 pdName varchar2(50) not null,
 price number null,
 regdate  date default sysdate
);

drop sequence pd_seq;
create sequence pd_seq
increment by 1
start with 1
nocache;

insert into pd(no, pdname, price, regdate)
 values (pd_seq.nextval, '마우스', 15000, sysdate) ;
insert into pd(no, pdname, price, regdate)
 values (pd_seq.nextval, '컴퓨터', 2300000, sysdate-3) ;
insert into pd(no, pdname, price, regdate)
 values (pd_seq.nextval, '키보드', 47000, sysdate-41) ;
insert into pd(no, pdname, price, regdate)
 values (pd_seq.nextval, '모니터', 340000, sysdate-1) ;
insert into pd(no, pdname, price, regdate)
 values (pd_seq.nextval, '외장하드', 270000, sysdate-20) ;

select * from pd order by no desc;

