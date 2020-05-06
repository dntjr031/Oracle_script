/* Formatted on 2020/05/06 오전 10:44:34 (QP5 v5.360) */
--7강_table_제약조건.sql
--[2020-04-27 월요일]

/*
    DDL - 데이터베이스 오브젝트들을 생성, 변경, 삭제, 관리하는 명령어
    [1] create - 오브젝트 생성 명령어
               - create 오브젝트타입 오브젝트명...
                 예) create table 테이블명...
    [2] drop - 오브젝터 제거(영구 소멸)
             - drop 오브젝트타입 오브젝트명;
               예) drop table 테이블명;
    [3] alter - 오브젝트 구조 변경  
              - alter 오브젝트타입 오브젝트명..
                예) alter table dept5
                    add loc varchar2(20);
    [4] truncate
        - truncate table - 테이블의 데이터 삭제
          예) truncate table 테이블명;
          
    ※ drop, truncate, delete 비교
    1) delete - 메모리상의 데이터를 삭제, rollback으로 되돌릴 수 있다.
    2) truncate - 메모리상의 데이터와 데이터파일까지 삭제, 자동 커밋됨
                - delete보다 수행속도가 빠름
        => delete, truncate는 데이터만 삭제, 테이블 구조는 살아있다.
    3) drop - 테이블의 구조까지 영구히 소멸시킴
*/

/*
    ※ 테이블 만들기
    create table 테이블명
    (
        컬럼명1 데이터타입,
        컬럼명2 데이터타입,
        컬럼명3 데이터타입,
        ...
    );
    
    ※ 데이터 타입
    문자형, 숫자형, 날짜형
    [1] 문자형
    char(크기) - 고정길이 문자형, 최대 2000byte까지 저장
    varchar2(크기) - 가변길이 문자형, 최대 4000byte까지 저장
    clob 타입(Character large Object)
    - 크기가 큰 문자열이나 문서의 저장이 가능
    - long타입이 확장된 형태, 4GB까지 저장
*/
--char, varchar2 비교

CREATE TABLE char_exam1
(
    names1    CHAR (3),
    -- 고정길이 3바이트
    names2    VARCHAR2 (3)
-- 가변길이 3바이트
);

INSERT INTO char_exam1
     VALUES ('AA', 'AA');

SELECT names1,
       names2,
       LENGTH (names1),
       LENGTH (names2),
       REPLACE (names1, ' ', '*'),
       REPLACE (names2, ' ', '*')
  FROM char_exam1;

DROP TABLE char_exam1;

CREATE TABLE char_exam1
(
    names1    CHAR (3),
    --생략하면 byte
    names2    VARCHAR2 (3),
    names3    CHAR (6 BYTE),
    names4    CHAR (6 CHAR),
    names5    CHAR (6),
    names6    CLOB
-- 4GB까지 저장
);

INSERT INTO char_exam1
     VALUES ('AAA',
             '가',
             'ABCDEF',
             'ABCDEFG',
             'AB',
             NULL);

-- error, names4는 6개 문자만 입력 가능하므로 에러

INSERT INTO char_exam1
     VALUES ('AAA',
             '가',
             'ABCDEF',
             '가나다라마바',
             '가나',
             NULL);

--인코딩에 따라 한글 1글자는 2바이트나 3바이트
--UTF8 : 한글 1글자가 3바이트

INSERT INTO char_exam1
     VALUES ('AAA',
             '가',
             'ABCDEF',
             '가나다라마바',
             '가나다',
             NULL);

--names5는 6바이트이므로 한글 2글자만 입력 가능

SELECT *
  FROM nls_session_parameters
 WHERE parameter = 'NLS_LENGTH_SEMANTICS';

--=> char, varchar2에서 생략하면 byte

INSERT INTO char_exam1 (names1, names3, names6)
     VALUES ('AAC', 'ABCDEF', 'abcdEFGH가나다 clob 연습');

SELECT * FROM char_exam1;

/*
    [2] 숫자형
    number
    number(전체 자리수)
    number(전체 자리수, 소수이하 자리수)
*/

CREATE TABLE num_exam1
(
    n1    NUMBER,
    n2    NUMBER (9),
    --전체 9자리수 표현가능
    --소수이하 자리수는 표현하지 않음
    n3    NUMBER (9, 2),
    --전체 9자리의 수중 소수이하 2자리까지 표현 가능
    --소수이하 3째자리에서 반올림
    n4    NUMBER (9, 1),
    --전체 9자리의 수중 소수이하 1자리까지 표현 가능
    --소수이하 2째자리에서 반올림
    n5    NUMBER (7),
    --전체 7자리수 표현가능
    n6    NUMBER (7, -2),
    --전체 7자리의 수 표현, 십의자리에서 반올림
    n7    NUMBER (6),
    --전체 7자리수 표현가능
    n8    NUMBER (3, 5)
--1보다 작은 실수 표현, 소수이하 5자리 중 0이 두개(5-3) 붙는다
);

INSERT INTO num_exam1 (n1,
                       n2,
                       n3,
                       n4,
                       n5,
                       n6)
     VALUES (1234567.89,
             1234567.89,
             1234567.89,
             1234567.89,
             1234567.89,
             1234567.89);

INSERT INTO num_exam1 (n1,
                       n2,
                       n3,
                       n4,
                       n5,
                       n6,
                       n7)
     VALUES (1234567.89,
             1234567.89,
             1234567.89,
             1234567.89,
             1234567.89,
             1234567.89,
             1234567.89);

             -- error, n7은 전체 자리수 6개만 가능, 현재 7개이므로 에러

SELECT * FROM num_exam1;

/*
    n8 number(3,5)
    - 전체 자리수가 소수이하 자리수보다 적은 경우
    - 1보다 작은 실수 표현
    - 전체 자리수 3개, 소수이하 자리수 5개
    => 5-3 => 소수이하 자리수에 2개의 0이 붙게 됨
*/

INSERT INTO num_exam1 (n8)
     VALUES (0.00123);

INSERT INTO num_exam1 (n8)
     VALUES (0.01234);

--error

INSERT INTO num_exam1 (n8)
     VALUES (0.0012);

SELECT * FROM num_exam1;

/*
    [3] 날짜형
    date - 년월일 시분초까지 표현
    timestamp - 밀리초까지도 표현
*/

SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24:mi:ss'),
       TO_CHAR (SYSTIMESTAMP, 'yyyy-mm-dd hh24:mi:ss.ff')
  FROM DUAL;

CREATE TABLE date_exam1
(
    d1    DATE,
    d2    TIMESTAMP
);

INSERT INTO date_exam1
     VALUES (SYSDATE, SYSTIMESTAMP);

INSERT INTO date_exam1
     VALUES (SYSDATE, SYSDATE);

INSERT INTO date_exam1
     VALUES (SYSTIMESTAMP, SYSTIMESTAMP);

SELECT * FROM date_exam1;

--테이블 만들기 연습 : tbl_test1

CREATE TABLE tbl_test1
(
    name       VARCHAR2 (30),
    ssn        CHAR (14),
    content    CLOB,
    gender     CHAR,
    age        NUMBER (3),
    regdate    DATE
);

INSERT INTO tbl_test1
     VALUES ('홍길동',
             '970930-2296312',
             '홍길동 아무개입니다.',
             'M',
             25,
             '2020-04-27');

SELECT * FROM tbl_test1;

/*
    <무결정 제약조건>
    데이터 무결성
    - 오라클 서버에서 데이터를 흠 없이 안정되게 지켜 주는 것
    - 제대로 된 데이터들이 올바르게 저장될 수 있도록 하기 위해 
      데이터베이스 측에서 제공하는 기능들 => 무결성 제약조건
    - 무결성을 지키기 위해 제약 조건들을 제공함
    - 제약조건들은 테이블의 컬럼에 적용됨
    
    ※ 무결정 제약 조건(Integrity Constraints)
    [1] null / not null
    [2] unique
    [3] primary key
    [4] foreign key
    [5] check
    [6] default
*/

/*
    [1] null(not null => C)
    - 데이터가 없음을 의미
    - 컬럼의 속성중 하나로 해당 컬럼이 null값을 허용하는지 허용하지 않는지 지정
    - 데이터 타입 다음에 명시해야 함
    - null을 허용하면 null, 허용하지 않으면 not null을 명시
    - 명시하지 않으면 default값인 null로 지정
*/

CREATE TABLE null_exam1
(
    col1    VARCHAR2 (3) NOT NULL,
    col2    VARCHAR2 (3) NULL,
    col3    VARCHAR2 (3)
);

INSERT INTO null_exam1 (col1, col2)
     VALUES ('AA', 'BB');

INSERT INTO null_exam1 (col2, col3)
     VALUES ('CC', 'DD');

--에러 : col1은 not null이므로 값을 입력해야 함 

INSERT INTO null_exam1 (col1, col2, col3)
     VALUES ('TT1', '', NULL);

-- null을 직접 입력하는 경우 : null, '' 입력

INSERT INTO null_exam1 (col1, col3)
     VALUES ('TT2', ' ');

-- ' ' 은 null아님

SELECT *
  FROM null_exam1
 WHERE col3 IS NULL;

SELECT *
  FROM null_exam1
 WHERE col3 IS NOT NULL;

--=> 필수 입력항목에는 not null 제약조건을 지정해야 함

/*
    [2] unique (U)
    - 각 레코드를 유일하게 실별할 수 있는 속성
    - 복합키를 unique 제약조건으로 사용할 수 있다
    - 한 테이블에 여러 개의 unique 제약조건이 올 수 있다
    - null을 허용함
*/

CREATE TABLE unique_exam1
(
    col1    VARCHAR2 (10) UNIQUE NOT NULL,
    col2    VARCHAR2 (10) UNIQUE,
    col3    VARCHAR2 (10) NOT NULL,
    col4    VARCHAR2 (10) NOT NULL,
    CONSTRAINTS uni_tmp_uk UNIQUE (col3, col4)
--복합 unique 키(outline 제약 조건)

);

INSERT INTO unique_exam1 (col1,
                          col2,
                          col3,
                          col4)
     VALUES ('A1',
             'B1',
             'C1',
             'D1');

INSERT INTO unique_exam1 (col1, col3, col4)
     VALUES ('A1', 'CC', 'DD');

             --error : col1이 중복

INSERT INTO unique_exam1 (col1, col3, col4)
     VALUES ('A4', 'C1', 'D1');

             --error : col3, col4 는 복합키로 unique해야 하므로

INSERT INTO unique_exam1 (col1, col3, col4)
     VALUES ('A5', 'C5', 'D5');

             -- col2는 unique이지만, null허용하므로 입력가능 

INSERT INTO unique_exam1
     VALUES ('A6',
             NULL,
             'C6',
             'D6');


INSERT INTO unique_exam1
     VALUES ('A7',
             '',
             'C7',
             'D7');

INSERT INTO unique_exam1 (col1,
                          col2,
                          col3,
                          col4)
     VALUES ('A2',
             'B2',
             'C2',
             'D2');

UPDATE unique_exam1
   SET col1 = 'A1'
 WHERE col2 = 'B2';

--에러(unique 키가 걸린 칼럼에 동일한 값 'A1'을 다시 입력하여 제약조건에 위배)

SELECT * FROM unique_exam1;

/*
    null을 허용한 unique에는 값을 입력하지 않을 수 있따.
    col2의 값이 null인 레코드가 여러 개 
    => unique대상에서 제외됨
    
    unique 제약조건에는 not null을 지정하는 것이 일반적임
*/
--제약조건 조회
--user_constraints, user_cons_columns;

SELECT *
  FROM user_constraints
 WHERE table_name LIKE '%EXAM%';

SELECT *
  FROM user_cons_columns
 WHERE table_name LIKE '%EXAM%';

  SELECT a.TABLE_NAME,
         a.CONSTRAINT_NAME,
         a.CONSTRAINT_TYPE,
         a.INDEX_NAME,
         b.COLUMN_NAME,
         b.POSITION
    FROM user_constraints a
         JOIN user_cons_columns b
             ON     a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
                AND a.TABLE_NAME LIKE '%EXAM%'
ORDER BY CONSTRAINT_NAME;

/*
    [3] primary key (P)
    - 각 레코드를 유일하게 식별할 수 있는 속성
    - 테이블당 하나만 올 수 있다.
    - not null + unique index
    - 복합키도 가능
*/

CREATE TABLE pk_exam1
(
    col1    CHAR (3) PRIMARY KEY,
    -- inline 제약조건
    --col2    char(3) primary key,
    -- error, primart key는 하나만 생성 가능
    col2    VARCHAR (4),
    col3    NUMBER
);

INSERT INTO pk_exam1 (col1, col2, col3)
     VALUES ('A01', 'AA', 1);

INSERT INTO pk_exam1 (col1, col2, col3)
     VALUES ('A01', 'BB', 2);

-- error, unique constraint violated

INSERT INTO pk_exam1 (col1, col2, col3)
     VALUES (NULL, 'CC', e);

--error, primary key는 not null이므로 null을 허용하지 않음


INSERT INTO pk_exam1 (col1)
     VALUES ('A02');

SELECT * FROM pk_exam1;

CREATE TABLE pk_exam2
(
    col1    CHAR (3),
    col2    VARCHAR (4),
    col3    NUMBER,
    CONSTRAINT pk_col1_col2 PRIMARY KEY (col1, col2)
-- outline 제약조건, 복합키
);

INSERT INTO pk_exam2
     VALUES ('A01', 'B01', 10);

INSERT INTO pk_exam2
     VALUES ('A01', 'B01', 10);

-- error

INSERT INTO pk_exam2
     VALUES ('A01', 'B02', 30);

SELECT * FROM pk_exam2;

UPDATE pk_exam2
   SET col2 = 'B01'
 WHERE col1 = 'A01' AND col2 = 'B02';

-- error

/*
    [4] foreign key (R) 외래키 제약조건
    - 다른 테이블을 참조하기 위하여 사용되는 속성들
    - 테이블 간에 관계를 설정할 때 사용되는 키
    - 부모 테이블의 primary key 나 unique는 자식 테이블의 foreign key로 전이된다
    
    - 입력시 부모 테이블을 먼저 insert하고, 그 후에 자식 테이블을 insert해야 함
    - 부모 테이블에 있는 참조 컬럼의 값만 자식 테이블에서 사용할 수 있다
     (부모 테이블에 없는 값을 자식 테이블에서 사용하는 것은 불가능)
    
    - 삭제시 자식 테이블을 먼저 삭제하고, 그 후에 부모 테이블을 삭제해야 함
    - foreign key지정시 on delete cascade 옵션을 주면
     부모 테이블의 레코드를 삭제하면 자식 테이블의 해당 레코크도 함께 삭제됨
*/

/*
    [5] check 제약 조건(C)
    - 입력되는 값을 체크하여 일정한 조건에 해당되는 값만 입력될 수 있게 하는 제약 조건
     예) 성별(gender) 컬럼 => 남자, 여자만 입력되고 다른 값은 입력될 수 없도록
*/

CREATE TABLE check_exam1
(
    no        NUMBER PRIMARY KEY,
    name      VARCHAR2 (30) NOT NULL,
    gender    CHAR (6) CHECK (gender IN ('남자', '여자')),
    -- inline 제약 조건
    pay       NUMBER (10),
    age       NUMBER (3),
    CONSTRAINT ck_check_exam1_pay CHECK (pay >= 0),
    CONSTRAINT ck_check_exam1_age CHECK (age BETWEEN 0 AND 120)
);

INSERT INTO check_exam1 (no, name)
     VALUES (1, '홍길동');

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (2,
             '김길동',
             '남자',
             5000000,
             35);

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (3,
             '이길순',
             '여',
             5000000,
             36);

--error, gender check 제약조건 위배

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (4,
             '김길자',
             '여자',
             -5000000,
             37);

--error, pay check 제약조건 위배

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (5,
             '김길동',
             '남자',
             5000000,
             135);

--error, age check 제약조건 위배

SELECT * FROM check_exam1;

  SELECT a.TABLE_NAME,
         a.CONSTRAINT_NAME,
         a.CONSTRAINT_TYPE,
         a.INDEX_NAME,
         b.COLUMN_NAME,
         b.POSITION
    FROM user_constraints a
         JOIN user_cons_columns b
             ON     a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
                AND a.TABLE_NAME LIKE '%EXAM%'
ORDER BY TABLE_NAME;

/*
    [6] default
    - 기본값
    - 컬럼에 특정값을 default값으로 설정하면 테이블에 데이터를 입력할 때
     해당 컬럼에 값을 입력하지 않을 경우, default로 설정한 값이 자동으로 입력됨
    - 컬럼 타입 다음에 'default 디폴트값' 을 명시
    - 반드시 데이터 타입 다음에, null이나 not null 앞에 위치시켜야 함  
*/

CREATE TABLE default_exam1
(
    no          NUMBER PRIMARY KEY,
    name        VARCHAR2 (30),
    gender      CHAR (3) DEFAULT '남' CHECK (gender IN ('남', '여')),
    hiredate    DATE DEFAULT SYSDATE NOT NULL,
    scor        NUMBER (3) DEFAULT 0 NULL
);

INSERT INTO default_exam1 (no, hiredate)
     VALUES (1, SYSDATE);

INSERT INTO default_exam1 (no)
     VALUES (2);

INSERT INTO default_exam1 (no,
                           name,
                           gender,
                           hiredate,
                           scor)
     VALUES (3,
             '홍길선',
             '여',
             DEFAULT,
             90);

INSERT INTO default_exam1
     VALUES (4,
             '김길동',
             DEFAULT,
             DEFAULT,
             DEFAULT);

SELECT * FROM default_exam1;

--제약조건을 이용하여 테이블 만들기
--1) 부서 테이블 만들기
--부서(부모) <=> 사원(자식)
DROP TABLE depart CASCADE CONSTRAINT;

/*
    => 자식 테이블이 참조하고 있는 부모 테이블은 drop할 수 없으나
      참조 제약 조건까지 삭제하고 싶으면 drop시 cascade constraint옵션을 준다
*/

CREATE TABLE depart
(
    dept_cd      CHAR (3) PRIMARY KEY,
    dept_name    VARCHAR2 (50) NOT NULL,
    loc          VARCHAR2 (100)
);

--2) 사원 테이블 만들기
--사원(부모) <=> 사원가족(자식)

CREATE TABLE employee
(
    empno       NUMBER PRIMARY KEY,
    name        VARCHAR2 (30) NOT NULL,
    dcode       CHAR (3)
                   NOT NULL
                   CONSTRAINT fk_employee_dcode REFERENCES depart (dept_cd),
    sal         NUMBER (10) DEFAULT 0 CHECK (sal >= 0),
    email       VARCHAR2 (50) UNIQUE,
    hiredate    DATE DEFAULT SYSDATE
);

SELECT * FROM depart;

SELECT * FROM employee;

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE';

--drop시 cascade constraint옵션을 이용하여 EMPLOYEE의 외래키도 제거했으므로
--다시 depart 테이블도 create하고, 외래키도 추가해 준다.

ALTER TABLE employee
    ADD CONSTRAINT fk_employee_dcode FOREIGN KEY (dcode)
            REFERENCES depart (dept_cd);

--3) 사원가족 테이블 만들기

CREATE TABLE family
(
    empno       NUMBER
                   NOT NULL
                   CONSTRAINT fk_family_empno
                       REFERENCES employee (empno) ON DELETE CASCADE,
    name        VARCHAR2 (30) NOT NULL,
    relation    VARCHAR2 (50),
    CONSTRAINT pk_family_empno_name PRIMARY KEY (empno, name)
);

SELECT * FROM family;

--insert
--부모 테이블에 먼저 데이터를 입력
--1) 부서 테이블 insert

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('A01', '인사부', '서울');

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('B01', '영업부', '부산');

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('C01', '총무부', '광주');

SELECT * FROM depart;

--2) 사원테이블 insert
--부모인 부서 테이블의 레코드가 없으면 자식 사원 테이블을 insert할 수 없다

INSERT INTO employee
     VALUES (1001,
             '홍길동',
             'A01',
             5000000,
             'h@nate.com',
             DEFAULT);

INSERT INTO employee
     VALUES (1002,
             '홍길동2',
             'F01',
             5000000,
             'h2@nate.com',
             DEFAULT);

-- error, Oparent key not found

INSERT INTO employee
     VALUES (1003,
             '홍길동3',
             'A01',
             -5000000,
             'h3@nate.com',
             DEFAULT);

--error, sal check제약 조건 위배

INSERT INTO employee
     VALUES (1004,
             '홍길동4',
             'A01',
             5000000,
             'h@nate.com',
             DEFAULT);

--error, email unique 제약조건 위배

INSERT INTO employee
     VALUES (1002,
             '김길동',
             'B01',
             2000000,
             'k@nate.com',
             DEFAULT);

INSERT INTO employee
     VALUES (1003,
             '이길동',
             'C01',
             3000000,
             'l@nate.com',
             DEFAULT);

SELECT * FROM employee;

--3) 사원가족 테이블 insert

INSERT INTO family (empno, name, relation)
     VALUES (1005, '박길수', '부');

--error, parent key not found

INSERT INTO family (empno, name, relation)
     VALUES (1001, '홍아빠', '부');

INSERT INTO family (empno, name, relation)
     VALUES (1001, '김엄마', '모');

INSERT INTO family (empno, name, relation)
     VALUES (1001, '홍아빠', '형');

--error, unique제약조컨 위배

INSERT INTO family (empno, name, relation)
     VALUES (1002, '김아버지', '부');

INSERT INTO family (empno, name, relation)
     VALUES (1002, '박어머니', '모');

INSERT INTO family (empno, name, relation)
     VALUES (1002, '김형', '형');

SELECT * FROM family;

SELECT f.*, e.*
  FROM family f JOIN employee e ON f.EMPNO = e.EMPNO;

--delete
--자식이 참고하고 있는 부모 테이블의 레코드를 삭제하는 경우
--1) on delete cascade 옵션을 주지 않은 경우
--=> 부모 테이블의 레코드를 삭제하면 에러 발생

DELETE FROM depart
      WHERE dept_cd = 'A01';

--error, foreign key 제약조건 위반
--=> 삭제를 반드시 해야 된다면, 자식 레코드를 먼저 삭제한 후 부모 레코드를 삭제한다

--2) on delete cascade 옵션을 준 경우
--=> 부모 테이블의 레코드를 삭제하면 해당 레코드를 참조하는 자식 테이블도 같이 삭제됨

DELETE FROM employee
      WHERE empno = 1001;

--family에서 참조하고 있는 레코드 삭제
--=> 부모인 employee의 1001번 레코드가 삭제되면서 자식인 family의 101번 레코드도 같이 삭제됨

--회원 테이블 만들기-member2 
--no - 번호, 기본키 
--userid 아이디, unique, 반드시 값 입력되도록 
--name 이름, 반드시 값 입력되도록 
--pwd 비밀번호 , 반드시 값 입력되도록 
--email 이메일, hp 휴대폰번호, zipcode 우편번호, address  주소(시도, 구군, 동),
-- addressDetail 상세주소, 
--regdate 가입일, 기본값:현재일자 
--mileage  마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록

CREATE TABLE member2
(
    no               NUMBER PRIMARY KEY,
    userid           VARCHAR2 (20) UNIQUE NOT NULL,
    name             CHAR (20) NOT NULL,
    pwd              VARCHAR2 (20) NOT NULL,
    email            VARCHAR2 (50),
    hp               VARCHAR2 (20),
    zipcode          VARCHAR2 (10),
    address          VARCHAR2 (50),
    addressdetail    CLOB,
    regdate          DATE DEFAULT SYSDATE,
    mileage          NUMBER DEFAULT 0 CHECK (mileage BETWEEN 0 AND 1000000)
);

CREATE TABLE zipcode
(
    zipcode    VARCHAR2 (10),
    sido       VARCHAR2 (10),
    gugun      VARCHAR2 (10),
    dong       VARCHAR2 (10),
    bunji      VARCHAR2 (10),
    seq        NUMBER (3) PRIMARY KEY
);

CREATE TABLE member1
(
    no               NUMBER PRIMARY KEY,
    userid           VARCHAR2 (20) UNIQUE NOT NULL,
    name             CHAR (20) NOT NULL,
    pwd              VARCHAR2 (20) NOT NULL,
    email            VARCHAR2 (50),
    hp               VARCHAR2 (20),
    zipcodeno        NUMBER (3)
                        CONSTRAINT fk_member1_zipcode REFERENCES zipcode (seq),
    addressdetail    CLOB,
    regdate          DATE DEFAULT SYSDATE,
    mileage          NUMBER DEFAULT 0 CHECK (mileage BETWEEN 0 AND 1000000)
);

--[2020-04-28 화요일]

/*
1) 테이블 생성 후 제약조건 추가
 alter table 테이블명
 add constraint 제약조건이름 제약조건종류(컬럼);
 ex) alter table emp
     add constraint pk_empno primary key(empno);
     
2) 테이블을 만들면서 아웃라인 제약조건 지정
 - 컬럼명을 모두 나열한 이후에
 , constraint 제약조건이름 제약조건 종류(컬럼)
 ex) , constraint pk_empno primary key(empno);
 
3) 인라인 제약조건 지정
 - 컬럼의 데이터타입 뒤에 제약조건 종류
 ex) empno number primary key
*/
--테이블 생성 후 제약조건 추가하기

CREATE TABLE employee2
(
    empno       NUMBER,
    name        VARCHAR2 (30) NOT NULL,
    dcode       CHAR (3) NOT NULL,
    sal         NUMBER (10) DEFAULT 0,
    email       VARCHAR2 (50),
    hiredate    DATE DEFAULT SYSDATE
);

--제약조건 추가하기
--primary key 제약조건 추가

ALTER TABLE employee2
    ADD CONSTRAINT pk_employee2_empno PRIMARY KEY (empno);

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE2';

--default값 조회

SELECT column_name, data_default
  FROM user_tab_columns
 WHERE table_name = 'EMPLOYEE2';

--foreign key 제약조건 추가

ALTER TABLE employee2
    ADD CONSTRAINT fk_employee2_empno FOREIGN KEY (dcode)
            REFERENCES depart (dept_cd);

--check 제약조건 추가

ALTER TABLE employee2
    ADD CONSTRAINT check_employee2_sal CHECK (sal >= 0);

--unique 제약조건 추가

ALTER TABLE employee2
    ADD CONSTRAINT check_employee2_email UNIQUE (email);

--not null, default 제약조건 변경하기

ALTER TABLE employee2
    MODIFY name NULL;

--name 컬럼이 not null 이었는데 null로 변경

ALTER TABLE employee2
    MODIFY name NOT NULL;

--name 컬럼이 null 이었는데 not null로 변경

ALTER TABLE employee2
    MODIFY sal DEFAULT 1000;

-- sal 컬럼의 default값이 0이었는데 1000으로 변경

--제약조건 이름 변경하기

ALTER TABLE employee2
    RENAME CONSTRAINT fk_employee2_empno TO fk_employee2_dcode;

--제약조건 제거하기

ALTER TABLE employee2
    DROP CONSTRAINT pk_employee2_empno;

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE2';

--outline

CREATE TABLE employee3
(
    empno       NUMBER,
    name        VARCHAR2 (30) NOT NULL,
    dcode       CHAR (3) NOT NULL,
    sal         NUMBER (10) DEFAULT 0,
    email       VARCHAR2 (50),
    hiredate    DATE DEFAULT SYSDATE,
    CONSTRAINT pk_employee3_empno PRIMARY KEY (empno),
    CONSTRAINT fk_employee3_dcode FOREIGN KEY (dcode)
        REFERENCES depart (dept_cd),
    CONSTRAINT ck_employee3_sal CHECK (sal >= 0),
    CONSTRAINT uk_employee3_email UNIQUE (email)
);

SELECT * FROM employee3;

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE3';

--

SELECT * FROM user_tables;

SELECT * FROM user_objects;

/*
    create table depart_temp1
    as
    select 문
    
    을 이용해서 테이블을 만들면, null, not null을 제외한 제약조건은 복사되지 않음
*/

CREATE TABLE depart_temp1
AS
    SELECT * FROM depart;

SELECT *
  FROM user_constraints
 WHERE table_name = 'DEPART';

SELECT *
  FROM user_constraints
 WHERE table_name = 'DEPART_TEMP1';

--복사한 테이블에 primary key 추가

ALTER TABLE depart_temp1
    ADD CONSTRAINT pk_depart_temp1_dept_cd PRIMARY KEY (dept_cd);

-- not null에도 제약조건이름 넣기

CREATE TABLE employee4
(
    empno       NUMBER,
    name        VARCHAR2 (30) CONSTRAINT nn_employee4_name NOT NULL,
    dcode       CHAR (3) NOT NULL,
    sal         NUMBER (10) DEFAULT 0,
    email       VARCHAR2 (50),
    hiredate    DATE DEFAULT SYSDATE,
    CONSTRAINT pk_employee4_empno PRIMARY KEY (empno),
    CONSTRAINT ck_employee4_sal CHECK (sal >= 0),
    CONSTRAINT uk_employee4_email UNIQUE (email)
);

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE4';



--테이블 변경하기(alter table 이용)

--1) 새로운 컬럼 추가

SELECT * FROM depart;

ALTER TABLE depart
    ADD pdept CHAR (3);

--추가될 때 값은 null이 들어감

ALTER TABLE depart
    ADD country VARCHAR2 (50) DEFAULT '한국';

--추가될 때 값은 default값이 들어감

--2) 컬럼의 데이터 크기 변경하기
--country 컬럼의 데이터 타입 변경, varchar2(50) => varchar2(100)

ALTER TABLE depart
    MODIFY country VARCHAR2 (100);

DESC depart;

--3) 컬럼 이름 변경
--loc => area 로 변경

ALTER TABLE depart
    RENAME COLUMN loc TO area;

SELECT * FROM depart;

--cf. 테이블 이름 변경하기

SELECT * FROM depart_temp1;

RENAME depart_temp1 TO depart_temp10;

SELECT * FROM depart_temp10;

--컬럼 삭제하기

ALTER TABLE depart_temp10
    DROP COLUMN loc;

CREATE TABLE depart_temp2
AS
    SELECT *
      FROM depart
     WHERE 1 = 0;

SELECT * FROM depart_temp2;