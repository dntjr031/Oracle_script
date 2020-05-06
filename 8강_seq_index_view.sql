/* Formatted on 2020/05/06 오전 10:44:36 (QP5 v5.360) */
--8강_seq_index_view.sql
--[2020-04-28 화요일]

/*
    <sequence>
    - 연속적인 숫자를 생성해내는 데이터 베이스 객체
    - 기본키가 각각의 입력되는 row를 식별할 수 있기만 하면 된다고 할때,
      시퀀스에 의해 생성된 값을 사용함
    - 테이블에 있는 기본키 값을 생성하기 위해 사용되는 독립적인 객체
    - 테이블에 종속되지 않음 => 하나의 시퀀스를 여러 개의 테이블에 동시에 사용할 수 있다.
    
    create sequence 시퀀스명
        minvalue    --시퀀스의 최소값
        maxvalue    --시퀀스의 최대값
        start with 시작값
        increment by 증가치
        nocache     --cache를 사용하지 않겠다
        nocycle     --생성된 시퀀스값이 최대치 혹은 최소치에 다다랐을 때 초기값부터 다시 시작할 지 여부
        order       --요청되는 순서대로 값을 생성
        
    ※ 시퀀스 사용
    nextval, currval 의사컬럼
    1) nextval - 바로 다음에 생성될 시퀀스를 가지고 있다.
    2) currval - 현재 시퀀스 값을 가지고 있다
*/

SELECT * FROM pd;

CREATE TABLE pd_temp1
AS
    SELECT *
      FROM pd
     WHERE 1 = 0;

SELECT * FROM pd_temp1;

ALTER TABLE pd_temp1
    ADD CONSTRAINT pk_pd_temp1_no PRIMARY KEY (no);

SELECT *
  FROM user_constraints
 WHERE table_name = 'PD_TEMP1';

--시퀀스 생성

CREATE SEQUENCE pd_temp1_seq START WITH 50 INCREMENT BY 1   -- 50부터 시작해서 1씩 증가
                                                         NOCACHE;

--사용자가 생성한 sequence 조회

SELECT * FROM user_sequences;

ALTER TABLE pd_temp1
    MODIFY regdate DEFAULT SYSDATE;

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, '컴퓨터', 2000000);

-- seq = 50

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, '모니터', 350000);

-- seq=51

SELECT * FROM pd_temp1;

SELECT pd_temp1_seq.CURRVAL FROM DUAL;

-- 현재 seq = 51

SELECT pd_temp1_seq.NEXTVAL FROM DUAL;

-- 다음 seq = 52, 값이 증가되어 버려서 이후 사용시 그 다음값(53)부터 처리됨

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, '키보드', 27000);

-- seq = 53

--

CREATE TABLE pd2
(
    no         NUMBER PRIMARY KEY,
    pdcode     CHAR (3) NOT NULL,
    pdname     VARCHAR2 (100),
    price      NUMBER (10) CHECK (price >= 0),
    company    VARCHAR2 (100),
    regdate    DATE DEFAULT SYSDATE
);

-- 1부터 시작해서 1씩 증가하는 시퀀스 객체 생성

CREATE SEQUENCE pd2_seq INCREMENT BY 1 START WITH 1 NOCACHE;

--데이터 입력

INSERT INTO pd2 (no,
                 pdcode,
                 pdname,
                 price,
                 company)
     VALUES (pd2_seq.NEXTVAL,
             'A01',
             '노트북',
             3500000,
             '삼성');

INSERT INTO pd2 (no,
                 pdcode,
                 pdname,
                 price)
     VALUES (pd2_seq.NEXTVAL,
             'B01',
             '키보드',
             38000);

SELECT * FROM pd2;

SELECT * FROM user_sequences;

--시퀀스 삭제
--drop sequence 시퀀스명;

DROP SEQUENCE pd_temp1_seq;

/*
    <index>
    - 테이블의 데이터를 빨리 찾기 위한 꼬리표
    - 인덱스가 없다면 특정한 값을 찾기 위해 모든 데이터 페이지를 다 뒤져야 함
      (table full scan)
    - index seek
      인덱스를 사용하는 것이 더 효과적이라면, 오라클은 모든 페이지를 뒤지지 않고
      인덱스 페이지를 찾아서 쉽게 데이터를 가져옴
    - 한 테이블에 여러 개의 인덱스를 생성할 수 있음
    
    create [unique] index 인덱스명
    on 테이블명(컬럼명1, 컬럼명2, ...)
*/

--primary key나 unique 제약조건을 주면 자동으로 unique index가 생성됨

SELECT * FROM pd2;

--상품 코드 인덱스

CREATE UNIQUE INDEX idx_pd2_pdcode
    ON pd2 (pdcode);

--상품명 인덱스

CREATE INDEX idx_pd2_pdname
    ON pd2 (pdname);

--상품 등록일, 회사명 복합키 인덱스

CREATE INDEX idx_pd2_regdate_company
    ON pd2 (regdate, company);

--인덱스 조회

SELECT *
  FROM user_indexes
 WHERE table_name = 'PD2';

SELECT *
  FROM user_ind_columns
 WHERE table_name = 'PD2';

SELECT *
  FROM user_constraints
 WHERE table_name = 'PD2';

--인덱스를 이용한 조회

SELECT *
  FROM pd2
 WHERE pdcode = 'B01';

SELECT *
  FROM pd2
 WHERE pdname = '키보드';

SELECT *
  FROM pd2
 WHERE regdate >= '2020-04-28' AND company = '삼성';

--index 삭제
--drop index 인덱스명
DROP INDEX idx_pd2_pdcode;

/*
    <뷰-view>
    - view는 테이블에 있는 데이터를 보여주는 형식을 정의하는 select문장의 덩어리
    - view는 실제로 데이터를 가지고 있지는 않지만 뷰를 통해 데이터를 조회할 수 있고,
      데이터를 입력, 수정, 삭제할 수 있으며 다른 테이블과 조인도 할 수 있기 때문에 가상의 논리적 테이블이라고 함
      
    create [or replace] view 뷰이름
    as
    select문장;
    
    ※ 뷰를 사용하는 목적
    1) 보안성 - 숨기고 싶은 컬럼들을 숨길 수 있다.
    2) 편의성 - 조인과 같은 복잡한 쿼리문장을 뷰로 만들어 수월하게 질의 할 수 있다.
*/

--testuser 사용자는 emp의 영업부(deptno=30) 사원들의 기본정보
--(이름, job, 입사일)를 검색할 수 있어야 한다면..

--hr사용자가 emp 테이블의 일부 컬럼만 볼 수 있는 뷰를 만들어서
--testuser가 해당 뷰를 볼 수 있게 한다

--1) hr계정에게 뷰 생성 권한을 부여해야 함
--sys관리자 계정에서 권한 부여를 해야 함
--grant create view to hr;

--view 생성 권한 제거하기
--revoke create view from hr;

--2) hr 사용자가 뷰를 만든다

CREATE OR REPLACE VIEW v_emp
AS
    SELECT ename, job, hiredate
      FROM emp
     WHERE deptno = 30;

--select * from 테이블 또는 뷰

SELECT * FROM v_emp;

--생성한 뷰 조회하기

SELECT * FROM emp;

--3) testuser에게 해당 뷰를 select할 수 있는 권한을 부여한다

/*
    sys계정에서 testuser 사용자 계정을 만들기
    
    create user testuser
    identified by testuser123
    default tablespace users;
    
    권한 부여하기(접속을 위한 기본적인 권한)
    grant resource, connect to testuser;
    
    접속하기
    conn testuser/testuser123
*/

GRANT SELECT ON v_emp TO testuser;
-- hr계정의 뷰이므로 select권한 부여가 가능

--권한 제거
--recoke select on v_emp from testuser;

/*
    4) testuser계정에서 뷰 select하기
    select * from hr.v_emp;
              스키마이름.데이터베이스 오브젝트명
*/

--뷰 변경하기
--research 부서의 사원정보도 조회해야 한다면

CREATE OR REPLACE VIEW v_emp
AS
    SELECT ename, job, hiredate
      FROM emp
     WHERE deptno IN (20, 30);

SELECT * FROM emp;

SELECT * FROM v_emp;

--영업부, research부에 속하는 사원들 중에
--1982년 이전에 입사한 사람의 정보(이름, 직무, 입사일)을 조회 하려면?
--1) view

SELECT *
  FROM v_emp
 WHERE hiredate < '1982-01-01';

--2) table

SELECT ename, job, hiredate
  FROM emp
 WHERE deptno IN (20, 30) AND hiredate < '1982-01-01';

--join을 이용하는 경우나 복잡한 쿼리문의 경우 뷰를 만들어서 사용
--employees, departments 테이블 조인

CREATE OR REPLACE VIEW v_employees
AS
    SELECT e.EMPLOYEE_ID,
           e.FIRST_NAME || '-' || e.LAST_NAME    name,
           e.HIRE_DATE,
           e.DEPARTMENT_ID,
           d.DEPARTMENT_NAME,
           NVL2 (e.COMMISSION_PCT,
                 e.salary + e.SALARY * e.commission_pct,
                 e.SALARY)                       pay
      FROM employees  e
           JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT * FROM v_employees;

SELECT * FROM employees;

SELECT * FROM departments;

--해당 뷰에서 급여가 10000 이상인 사원 조회

SELECT *
  FROM v_employees
 WHERE pay > 10000;

--gogak에서 고객 정보와 고객의 성별, 나이를 view로 만들기
--v_gogak_info

CREATE OR REPLACE VIEW v_gogak_info
AS
    SELECT GNO,
           GNAME,
           JUMIN,
           POINT,
           CASE
               WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
               ELSE '여자'
           END    gender,
             EXTRACT (YEAR FROM SYSDATE)
           - (  SUBSTR (jumin, 1, 2)
              + (CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                     ELSE 2000
                 END))
           + 1    age
      FROM gogak;

--해당 뷰를 이용하여 20대, 30대 여자만 조회

SELECT *
  FROM v_gogak_info
 WHERE TRUNC (age, -1) IN (20, 30) AND gender = '여자';

--inline view 이용

SELECT *
  FROM (SELECT GNO,
               GNAME,
               JUMIN,
               POINT,
               CASE
                   WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
                   ELSE '여자'
               END    gender,
                 EXTRACT (YEAR FROM SYSDATE)
               - (  SUBSTR (jumin, 1, 2)
                  + (CASE
                         WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                         ELSE 2000
                     END))
               + 1    age
          FROM gogak)
 WHERE TRUNC (age, -1) IN (20, 30) AND gender = '여자';



/*
    <뷰를 통한 데이터 수정>
    1. 뷰를 통한 조회도 가능하고, 입력, 수정, 삭제도 가능함 => updatable view
    2. 조회만 가능한 뷰도 있음 => read only view
*/

--updatable view 만들기

/*
    create or replace view 뷰이름
    as
        select문;
*/

--rede only view 만들기

/*
    create or replace view 뷰이름
    as
        select문
    with read only;
*/

CREATE OR REPLACE VIEW v_emp_readonly
AS
    SELECT ename, job, hiredate
      FROM emp
     WHERE deptno IN (20, 30)
WITH READ ONLY;

SELECT * FROM v_emp_readonly;

SELECT * FROM v_emp;

SELECT * FROM emp;

UPDATE v_emp_readonly
   SET ename = 'SMITH2'
 WHERE ename = 'SMITH';

-- error, cannot perform a DML operation on a read-only view

UPDATE v_emp
   SET ename = 'SMITH2'
 WHERE ename = 'SMITH';

-- updatable view는 입력, 수정, 삭제 가능

INSERT INTO v_emp (ename, job, hiredate)
     VALUES ('홍길동', 'CLERK', SYSDATE);

--error, cannot insert NULL into ("HR"."EMP"."EMPNO")
--=> 뷰를 통한 입력을 하는 경우, 뷰에 없는 컬럼은 null을 허용하거나 default값이 있어야 함
--   그렇지 않으면 에러 발생

CREATE OR REPLACE VIEW v_emp_2
AS
    SELECT empno,
           ename,
           job,
           hiredate
      FROM emp
     WHERE deptno IN (20, 30);

INSERT INTO v_emp_2 (empno,
                     ename,
                     job,
                     hiredate)
     VALUES (9999,
             '홍길동',
             'CLERK',
             SYSDATE);

-- 뷰의 조건을 벗어나는 범위이지만 입력 가능함

SELECT *
  FROM v_emp_2
 WHERE empno = 9999;

-- 입력은 가능하지만 범위 밖이므로 조회 불가능

DELETE FROM v_emp_2
      WHERE empno = 9999;

-- 입력은 가능하지만 범위 밖이므로 삭제도 불가능

/*
    기본적으로 뷰를 만들때 뷰의 조건을 벗어나는 범위로 데이터를 수정할 수 있으며
    이를 허용하지 않고자 할때는 with check option을 사용
*/

CREATE OR REPLACE VIEW v_emp_3
AS
    SELECT empno,
           ename,
           job,
           hiredate
      FROM emp
     WHERE deptno IN (20, 30)
WITH CHECK OPTION;

--뷰의 조건을 벗어나는 범위로는 데이터 변경 불가

INSERT INTO v_emp_3 (empno,
                     ename,
                     job,
                     hiredate)
     VALUES (9998,
             '홍길동',
             'CLERK',
             SYSDATE);

-- error, with check option 위배, view WITH CHECK OPTION where-clause violation

SELECT * FROM v_emp_3;

SELECT * FROM user_views;