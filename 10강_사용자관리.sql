/* Formatted on 2020/04/29 오후 6:32:07 (QP5 v5.360) */
--10강_사용자관리.sql
--[2020-04-29 수요일]

--사용자 계정 정보 조회

SELECT * FROM dba_users;

--데이터 파일에 대한 정보 조회

SELECT * FROM dba_data_files;

--테이블스페이스에 대한 정보 조회

SELECT * FROM dba_tablespaces;

/*
    오라클 데이터베이스의 논리적 저장 구조
    1) 데이터블럭(data block) - 최소 저장 단위
        데이터블럭의 default size : 8k
    2) 익스텐트(extent) - 8개의 데이터 블럭이 모여 하나의 익스텐트가 됨
    3) 세그먼트(segment) - 하나 이상의 익스텐트로 구성
    4) 테이블스페이스(tablespace) - 세그먼트들을 저장하는 논리적인 공간 이름
    
    하나의 테이블스페이스는 최소 1개의 데이터파일(물리적 파일)로 구성됨
*/

--테이블 스페이스 생성

/*
    create tablespace 테이블스페이스명
    datafile 데이터파일의 경로 size 크기
    autoextend on next 크기 --자동 증가 옵션(선택)
*/

CREATE TABLESPACE tb_test2
    DATAFILE 'C:\oraclexe\mydata\tb_test2.dbf'
                 SIZE 48 M
                 AUTOEXTEND ON NEXT 10 M;
                 --자동 증가 옵션(선택)

--데이터 파일에 대한 정보 조회

SELECT * FROM dba_data_files;

--테이블스페이스에 대한 정보 조회

SELECT * FROM dba_tablespaces;


--

CREATE TABLESPACE tb_test3
    DATAFILE 'C:\oraclexe\mydata\tb_test3_01.dbf'
                 SIZE 48 M
                 AUTOEXTEND ON MAXSIZE 1000 M , 'C:\oraclexe\mydata\tb_test3_02.dbf'
                                                    SIZE 48 M
                                                    AUTOEXTEND ON MAXSIZE 1000 M , 'C:\oraclexe\mydata\tb_test3_03.dbf'
                                                                                       SIZE 48 M
                                                                                       AUTOEXTEND ON MAXSIZE 1000 M;


--테이블 스페이스 제거

/*
    drop tablespace 테이블스페이스명;
    
    drop tablespace 테이블스페이스명
        including contents and datafiles; -- 물리적인 데이터파일까지 삭제
*/

DROP TABLESPACE tb_test3 INCLUDING CONTENTS AND DATAFILES;


-- 사용자 계정 만들기

/*
    create user 사용자이름
    identified by 비밀번호
    default tablespace 테이블스페이스명;
*/

--tb_test2 테이블스페이스를 사용하는 사용자계정 생성하기

CREATE USER testuser1 IDENTIFIED BY testuser123
    DEFAULT TABLESPACE tb_test2;

SELECT *
  FROM dba_users
 WHERE username LIKE 'TESTUSER%';

--권한 조회

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER1';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER1';


--사용자에게 권한 부여하기
-- create session 권한 부여(접속 권한)
GRANT CREATE SESSION TO testuser1;

/*
    create table tbl_test1
    (
        no number primary key,
        name varchar2(50)
    )tablespace tb_test2;
*/
--테이블 생성권한 부여하기
GRANT CREATE TABLE TO testuser1;
GRANT UNLIMITED TABLESPACE TO testuser1;
--테이블스페이스에 대한 권한 부여

--권한 박탈
--revoke 권한 from 사용자명;
REVOKE CREATE SESSION FROM testuser1;

--testuser2 사용자에게 resource, connect role 부여하기
GRANT CONNECT, RESOURCE TO testuser2;

--권한 조회

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER2';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER2';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'RESOURCE';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'CONNECT';

-- hr 권환 조회
SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'HR';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'HR';
 
--사용자 삭제
--drop user 사용자 이름;
drop user testuser7;

select * from dba_users where username like'TEST%';

--잠긴 계정 열기
--alter user 사용자ID account unlock;
alter user testuser2 account unlock;

--계정 잠그기
--alter user 사용자ID account lock;
alter user testuser2 account lock;

-- 기존 계정의 암호 변경하기
--alter user 사용자ID identified by 새로운비밀번호;
alter user testuser2 identified by testuser123;

--오라클이 제공하는 role조회
SELECT * FROM dba_roles;