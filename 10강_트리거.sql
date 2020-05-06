/* Formatted on 2020/05/06 오후 12:48:07 (QP5 v5.360) */
--10강_트리거.sql
--[2020-05-06 수요일]

/*
    <트리거(trigger)>
    - 서브 프로그램 단위의 하나인 트리거는 테이블, 뷰, 스키마, 또는 데이터베이스에 관련된 PL/SQL 블록으로
      관련된 특정 사건(event)이 발생될 때마다 자동으로 해당 PL/SQL블록이 실행됨
    - insert, update, delect의 DML문이나 DDL문의 실행을 데이터베이스에서는 특정 이벤트가
      발생 되었다고 함
      
    주요 트리거 유형
    [1] DML 트리거
        1) 문장 트리거 
            - 영향을 받는 행이 전혀 업더라도 트리거가 한 번은 실행된다
        2) 행 트리거 
            - 테이블이 트리거 이벤트의 영향을 받을 때마다 실행되고, 
             트리거 이벤트의 영향을 받는 행이 없을 경우에는 실행되지 않음
    [2] DML이 아닌 트리거
        1) DDL 이벤트 트리거
            - DML트리거와 거의 동일하지만 트리거를 활용하여 DDL작업을 하는 것만 다름
        2) 데이터베이스 이벤트 트리거
            - 데이터베이스 내에서 생기는 일들을 관리하기 위해서 생성하는 트리거
*/

/*
    create or replace trigger 트리거이름
        트리거 실행시점 [before | after]
        이벤트 [insert | update | delete]
        on {테이블이름 | 뷰이름 | 스키마 | 데이터베이스}
    [for each row]
    begin
        트리거 몸체
    end;
*/
--[1] 부서 테이블(dept)에 insert문 실행 후 메시지를 출력하는 트리거(문장 레벨 트리거) 

CREATE OR REPLACE TRIGGER tr_dept_insert
    AFTER INSERT
    ON dept
BEGIN
    DBMS_OUTPUT.put_line ('정상적으로 입력되었습니다.');
END;

SELECT * FROM user_triggers;

SELECT * FROM dept;

INSERT INTO dept
     VALUES (60, 'TEST2', 'SEOUL');

-- dept 테이블에 insert 이벤트가 발생한 후에 tr_dept_insert 트리거가 수행됨


--[2] 테이블에 데이터를 입력할 수 있는 시간 지정하기(문장 레벨 트리거) 

CREATE TABLE t_order
(
    no          NUMBER,
    ord_code    VARCHAR2 (10),
    ord_date    DATE
);

--입력시간이 15:20 ~ 15:30 일 경우만 입력을 허용하고, 그 외 시간일 경우는 에러를 발생시키는 트리거
create or replace trigger tr_check_time
before insert on t_order
begin
    if to_char(sysdate, 'HH24:mi') not between '15:50' and '16:10' then
        raise_application_error(-20009,'15:50~16:10일 경우에만 입력가능!!');
        rollback;
    end if;
end;

select * from t_order;
insert into t_order
values(1,'A01',sysdate);