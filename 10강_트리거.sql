/* Formatted on 2020/05/06 오후 5:10:40 (QP5 v5.360) */
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

--입력시간이 15:50 ~ 16:10 일 경우만 입력을 허용하고, 그 외 시간일 경우는 에러를 발생시키는 트리거

CREATE OR REPLACE TRIGGER tr_check_time
    BEFORE INSERT
    ON t_order
BEGIN
    IF TO_CHAR (SYSDATE, 'HH24:mi') NOT BETWEEN '16:10' AND '16:30'
    THEN
        raise_application_error (
            -20009,
            '15:50~16:10일 경우에만 입력가능!!');
    END IF;
END;

SELECT * FROM t_order;

INSERT INTO t_order
     VALUES (3, 'A03', SYSDATE);

DROP TRIGGER tr_check_time;

--[3] 테이블에 입력될 데이터 값을 지정하고, 그 값 외에는 에러를 발생시키는 트리거(행 레벨 트리거) 
--제품 코드가 'C100'인 제품이 입력될 경우 입력을 허용하고, 나머지 제품은 모두 에러를 발생시키는 트리거

CREATE OR REPLACE TRIGGER tr_code_check
    BEFORE INSERT
    ON t_order
    FOR EACH ROW
-- 행 레벨 트리거
BEGIN
    IF :new.ord_code != 'C100'
    THEN
        raise_application_error (
            -20010,
            '제품코드가 C100인 제품만 입력 가능');
    END IF;
END;

/*
    old - 변경할때 변경전의 값을 가지고 있음
    new - 데이터가 추가 혹은 변경되면 new 연산자로 변경 후의 값을 얻을 수 있음
    user - 현재 접속중인 사용자를 나타냄
*/

INSERT INTO t_order
     VALUES (3, 'C100', SYSDATE);

INSERT INTO t_order
     VALUES (4, 'C200', SYSDATE);

--error

--[4] 기존 테이블(t_test1)에 데이터가 업데이트될 때 기존 내용을 
--백업 테이블(t_test1_bak)로 이동시키는 트리거 

CREATE TABLE t_test1
(
    no      NUMBER,
    name    VARCHAR2 (10)
);

CREATE TABLE t_test1_bak
AS
    SELECT * FROM t_test1;

INSERT INTO t_test1
     VALUES (1, 'AAA');

INSERT INTO t_test1
     VALUES (2, 'BBB');

COMMIT;

SELECT * FROM t_test1;

SELECT * FROM t_test1_bak;

CREATE OR REPLACE TRIGGER tr_backup_t_test1
    AFTER UPDATE
    ON t_test1
    FOR EACH ROW
BEGIN
    INSERT INTO t_test1_bak (no, name)
         VALUES (:old.no, :old.name);
END;

UPDATE t_test1
   SET name = 'CCC'
 WHERE no = 1;

SELECT * FROM t_test1;

SELECT * FROM t_test1_bak;

UPDATE t_test1
   SET name = 'DDD';

--2개의 행이 update됨 => 2번 행레벨 트리거가 수행됨


--[5] 기존 테이블(t_test2)의 데이터가 삭제될 때 기존 내용을 백업 테이블(t_test2_bak)로 
--이동시키며 이때 백업 테이블에 삭제한 시간, 삭제 전 데이터를 모두 기록하는 트리거 

CREATE TABLE t_test2
(
    no      NUMBER,
    name    VARCHAR2 (10)
);

CREATE TABLE t_test2_bak
(
    no         NUMBER,
    name       VARCHAR2 (10),
    regdate    DATE DEFAULT SYSDATE
);

INSERT INTO t_test2
     VALUES (1, 'AAA');

INSERT INTO t_test2
     VALUES (2, 'BBB');

COMMIT;

CREATE OR REPLACE TRIGGER tr_backup_t_test2
    AFTER DELETE
    ON t_test2
    FOR EACH ROW
BEGIN
    INSERT INTO t_test2_bak
         VALUES (:old.no, :old.name, SYSDATE);
END;

SELECT * FROM user_triggers;

SELECT * FROM t_test2;

SELECT * FROM t_test2_bak;


DELETE FROM t_test2;

-- 2개의 행이 삭제되면 행레벨 트리거도 2번 수행

INSERT INTO t_test2
     VALUES (5, 'FFF');

INSERT INTO t_test2
     VALUES (6, 'GGG');

DELETE FROM t_test2
      WHERE no = 100;

-- 삭제된 행이 없으므로 수행되지 않음

DELETE FROM t_test2
      WHERE no = 5;

-- 한 번 수행


--[6] 기존 테이블(t_test3)의 추가, 변경, 삭제된 내용을 별도의 로그 테이블을 생성하여 기록을 남기도록 트리거를 설정

CREATE TABLE t_test3
(
    no      NUMBER,
    name    VARCHAR2 (10)
);

CREATE TABLE t_test3_history
(
    o_no       NUMBER,
    -- 변경전이나 삭제된 데이터를 저장하는 칼럼은 o 로 시작
    o_name     VARCHAR2 (10),
    n_no       NUMBER,
    -- 변경 후나 추가된 데이터를 저장하는 칼럼은 시작은 n 으로 정의
    n_name     VARCHAR2 (10),
    who        VARCHAR2 (30),
    -- 어떤 사용자가 어떤 작업을 언제작업 했는지 정보를 저장
    regdate    DATE DEFAULT SYSDATE,
    chk        CHAR (1)
-- U, I, D
);

INSERT INTO t_test3
     VALUES (1, 'AAA');

INSERT INTO t_test3
     VALUES (2, 'BBB');

COMMIT;

SELECT * FROM t_test3;

SELECT * FROM t_test3_history;

CREATE OR REPLACE TRIGGER tr_log_t_test3
    AFTER UPDATE
    ON t_test3
    FOR EACH ROW
BEGIN
    INSERT INTO t_test3_history (o_no,
                                 o_name,
                                 n_no,
                                 n_name,
                                 who,
                                 chk)
         VALUES (:old.no,
                 :old.name,
                 :new.no,
                 :new.name,
                 USER,
                 'U');
END;

UPDATE t_test3
   SET name = 'CCC'
 WHERE no = 1;


CREATE OR REPLACE TRIGGER tr_delete_t_test3
    AFTER DELETE
    ON t_test3
    FOR EACH ROW
BEGIN
    INSERT INTO t_test3_history (o_no,
                                 o_name,
                                 n_no,
                                 n_name,
                                 who,
                                 chk)
         VALUES (:old.no,
                 :old.name,
                 :new.no,
                 :new.name,
                 USER,
                 'D');
END;

DELETE FROM t_test3
      WHERE no = 2;

SELECT * FROM t_test3;

SELECT * FROM t_test3_history;

CREATE OR REPLACE TRIGGER tr_insert_t_test3
    AFTER INSERT
    ON t_test3
    FOR EACH ROW
BEGIN
    INSERT INTO t_test3_history (n_no,
                                 n_name,
                                 who,
                                 chk)
         VALUES (:new.no,
                 :new.name,
                 USER,
                 'I');
END;

INSERT INTO t_test3
     VALUES (1, 'AAA');

INSERT INTO t_test3
     VALUES (2, 'BBB');

SELECT * FROM t_test3;

SELECT * FROM t_test3_history;