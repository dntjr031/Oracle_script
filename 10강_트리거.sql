/* Formatted on 2020/05/06 오후 6:47:26 (QP5 v5.360) */
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

----------실습----------

CREATE TABLE 상품
(
    품번       NUMBER,
    항목명    VARCHAR2 (20),
    단가       NUMBER
);

CREATE TABLE 입고
(
    품번    NUMBER,
    수량    NUMBER,
    금액    NUMBER
);

CREATE TABLE 판매
(
    품번    NUMBER,
    수량    NUMBER,
    금액    NUMBER
);

CREATE TABLE 재고
(
    품번    NUMBER,
    수량    NUMBER,
    금액    NUMBER
);

INSERT INTO 상품
     VALUES (100, '새우깡', 900);

INSERT INTO 상품
     VALUES (200, '감자깡', 900);

INSERT INTO 상품
     VALUES (300, '맛동산', 1000);

INSERT INTO 입고
     VALUES (100, 10, 9000);

INSERT INTO 입고
     VALUES (200, 10, 9000);

INSERT INTO 입고
     VALUES (300, 10, 10000);

INSERT INTO 재고
     VALUES (100, 10, 9000);

INSERT INTO 재고
     VALUES (200, 10, 9000);

INSERT INTO 재고
     VALUES (300, 10, 10000);

SELECT * FROM 입고;

SELECT * FROM 재고;

SELECT * FROM 상품;

SELECT * FROM 판매;

--상품이 입고되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 증가되는 트리거 작성 하기  

CREATE OR REPLACE TRIGGER tr_입고
    AFTER INSERT
    ON 입고
    FOR EACH ROW
BEGIN
    UPDATE 재고
       SET 수량 = 수량 + :new.수량, 금액 = 금액 + :new.금액
     WHERE 품번 = :new.품번;
END;

INSERT INTO 입고
     VALUES (100, 2, 1800);

SELECT * FROM 입고;

SELECT * FROM 재고;

--상품이 판매되면 재고 테이블에서 자동으로 해당 상품의 재고 수량과 금액이 감소되는 트리거 작성 하기  

CREATE OR REPLACE TRIGGER tr_판매
    AFTER INSERT
    ON 판매
    FOR EACH ROW
BEGIN
    UPDATE 재고
       SET 수량 = 수량 - :new.수량, 금액 = 금액 - :new.금액
     WHERE 품번 = :new.품번;
END;

INSERT INTO 판매
     VALUES (100, 3, 2700);

SELECT * FROM 판매;

SELECT * FROM 재고;

--분석함수
--순위함수 - rank(), dense_rank(), row_number()

/*
    rank | dense_rank | row_number(expr)
        over ( <partition by 컬럼> <order by 컬럼> )
*/
-- 급여가 높은 순서대로 수위를 부여하여 출력

SELECT * FROM employees;

SELECT EMPLOYEE_ID,
       FIRST_NAME,
       HIRE_DATE,
       SALARY,
       DEPARTMENT_ID,
       RANK () OVER (ORDER BY salary DESC)
           AS "전체 순위(rank)",
       RANK () OVER (PARTITION BY department_id ORDER BY salary DESC)
           AS "부서내 순위(rank)",
       DENSE_RANK () OVER (ORDER BY salary DESC)
           AS "전체 순위(dense_rank)",
       DENSE_RANK () OVER (PARTITION BY department_id ORDER BY salary DESC)
           AS "부서내 순위(dense_rank)",
       ROW_NUMBER () OVER (ORDER BY salary DESC)
           AS "전체 순위(row_number)",
       ROW_NUMBER () OVER (PARTITION BY department_id ORDER BY salary DESC)
           AS "부서내 순위(row_number)"
  FROM employees;

--order by department_id;

--급여가 가장 많은 사원 5명 (1~5위)만 조회
--rank이용

SELECT EMPLOYEE_ID,
       FIRST_NAME,
       HIRE_DATE,
       SALARY,
       DEPARTMENT_ID,
       RANK () OVER (ORDER BY salary DESC)     "급여 순위"
  FROM employees
 WHERE "급여 순위" <= 5;

-- error, rank등 분석함수는 where절에 올 수 없다.

SELECT *
  FROM (SELECT EMPLOYEE_ID,
               FIRST_NAME,
               HIRE_DATE,
               SALARY,
               DEPARTMENT_ID,
               RANK () OVER (ORDER BY salary DESC)     "급여 순위"
          FROM employees)
 WHERE "급여 순위" <= 5;

-- top-n 분석
-- 입사일 기준으로 정렬한 후 조회

SELECT ROW_NUMBER () OVER (ORDER BY hiredate DESC)     NO,
       empno,
       ename,
       hiredate
  FROM emp;

SELECT ROWNUM AS NO, A.*
  FROM (  SELECT empno, ename, hiredate
            FROM emp
        ORDER BY hiredate DESC) A;

--최근에 입사한 7명을 순서대로 조회
--1) rownum

SELECT ROWNUM AS NO, A.*
  FROM (  SELECT empno, ename, hiredate
            FROM emp
        ORDER BY hiredate DESC) A
 WHERE ROWNUM <= 7;

--2) row_number()

SELECT *
  FROM (SELECT ROW_NUMBER () OVER (ORDER BY hiredate DESC)     NO,
               empno,
               ename,
               hiredate
          FROM emp)
 WHERE NO <= 7;

--누적 합계 구하기
--sum() over()

SELECT p_code,
       p_date,
       p_qty                                                     판매량,
       SUM (p_qty) OVER (PARTITION BY p_code ORDER BY p_date)    누적판매량
  FROM panmae;

--group by 이용

  SELECT p_code, p_date, SUM (p_qty) AS qty_total
    FROM panmae
GROUP BY p_code, p_date
ORDER BY p_code, p_date;

SELECT A.*,
       SUM (qty_total) OVER (PARTITION BY p_code ORDER BY p_date)    누적판매량
  FROM (  SELECT p_code, p_date, SUM (p_qty) AS qty_total
            FROM panmae
        GROUP BY p_code, p_date) A;

--view 만들기

CREATE OR REPLACE VIEW v_panmae
AS
    SELECT A.*,
           SUM (qty_total) OVER (PARTITION BY p_code ORDER BY p_date)    누적판매량
      FROM (  SELECT p_code, p_date, SUM (p_qty) AS qty_total
                FROM panmae
            GROUP BY p_code, p_date) A;

SELECT * FROM v_panmae;

--panmae 이용
--판매내역 출력하되 판매일자, 판매량, 판매금액, 누적 판매량, 누적 판매금액 조회
--날짜별로 누적

SELECT A.*,
       SUM ("sum_qty") OVER (ORDER BY p_date)       "누적 판매랑",
       SUM ("sum_total") OVER (ORDER BY p_date)     "누적 판매금액"
  FROM (SELECT P_DATE, SUM (P_QTY) "sum_qty", SUM (P_TOTAL) "sum_total"
          FROM panmae group by p_date) A;