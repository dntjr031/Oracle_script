/* Formatted on 2020/05/06 오전 11:33:02 (QP5 v5.360) */
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
DROP USER testuser7;

SELECT *
  FROM dba_users
 WHERE username LIKE 'TEST%';

--잠긴 계정 열기
--alter user 사용자ID account unlock;

ALTER USER testuser2
    ACCOUNT UNLOCK;

--계정 잠그기
--alter user 사용자ID account lock;

ALTER USER testuser2
    ACCOUNT LOCK;

-- 기존 계정의 암호 변경하기
--alter user 사용자ID identified by 새로운비밀번호;

ALTER USER testuser2
    IDENTIFIED BY testuser123;

--오라클이 제공하는 role조회

SELECT * FROM dba_roles;


----------------------------------------
--[2020-05-06 수요일]

SELECT *
  FROM dba_users
 WHERE username LIKE 'TEST%';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER5';

--권한 조회

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER5';

--롤 조회

-- testrole 이라는 이름의 롤을 생성하고, create session, create table권한 부여하기
--1) 롤 생성하기
CREATE ROLE testrole;

SELECT *
  FROM dba_roles
 WHERE role = 'TESTROLE';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTROLE';

--2) 롤에 권한 부여하기
-- create session, create table, unlimited tablespace
GRANT CREATE SESSION, CREATE TABLE TO testrole;
GRANT UNLIMITED TABLESPACE TO testrole;

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTROLE';

--3) testuser5 사용자에게 testrole 부여하기
GRANT testrole TO testuser5;

ALTER USER testuser5
    QUOTA 100 M ON tb_test2;

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER5';

--권한 조회

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER5';

--롤 조회

--전역 데이터베이스명 조회 - orcl, xe 등

SELECT * FROM global_name;

-- object 권한 주기
-- 해당 object 의 소유자 계정에서 권한을 부여하거나 박탈할 수 있다.

-- testuser5에게 hr계정의 employees 테이블을 조회하고, 수정할 수 잇는 권한 부여
--(hr 계정에서 처리 가능)

/*
    --select 권한 부여
    grant select on hr.employees to testuser5;
     
    --update권한 부여
    grant update on hr.employees to testuser5;
    
    --select권한 박탈
    revoke select on hr.employees from testuser5;
    
    --update 권한 박탈
    revoke update on hr.employees from testuser5;
*/

/*
    testuser5계정에서 처리
    
    update hr.employees
    set salary=2000
    where employee_id=100;
*/

GRANT RESOURCE, CONNECT TO testuser4;

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER4';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER4';

/*
    hr 계정에서
    grant select on hr.employees to testuser5 with grant option;
*/

/*
    with grant option
    - 권한을 위임하는 기증
    또 다른 사용자에게 권한을 할당해 줄 수 있게 됨
    object privilege에서 사용
*/

/*
    testuser5에서 처리
    grant select on hr.employees to testuser4;
    => testuser5 계정이 testuser4계정에게 hr의 employees에 select 할 수 있는 권한을 부여함
    
    => testuser4로 접속해서 hr의 employees를 select하면 조회됨
*/

REVOKE RESOURCE, CONNECT FROM testuser2;

GRANT RESOURCE, CONNECT TO testuser6 WITH ADMIN OPTION;

/*
    with admin option
    - 권한을 위임하는 기능, 또 다른 사용자에게 권한을 할당해 줄 수 있게 됨
    - system 관련 권한에서 사용
*/

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER6';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER6';
 
/*
    testuser6으로 접속해서 testuser2에게 resource, connect 권한(롤) 부여하기
    grant resource, connect to testuser2;
*/

--hr에서
select * from user_views;

--hr계정의 v_emp 뷰에 select할 수 잇는 권한을 testuser6에게 부여하기
--grant select on hr.v_emp to testuser6;

--testuser6에서
select * from hr.v_emp;

/*
    <data dictionary>
    - database 내에 저장된 모든 객체의 정보를 제공해주는 테이블
    - select * from dictionary;
    
    data dictionary의 종류
    1) DBA_XXX 
        - 데이터베이스 관리를 위한 정보를 제공
    2) ALL_XXX 
        - 자신이 생성한 object와 다른 사용자가 생성한 object중에 자신이 볼 수 있는 정보를 제공
        - 사용자가 접근 가능한 모든 스키마의 정보를 제공
        - 권한을 부여받음으로써 가능
    3) USER_XXX 
        - 자신이 생성한 object 정보를 제공,
        - 현재 데이터베이스에 접속한 사용자가 소유한 객체의 정보를 제공
*/

--모든 자료 사전의 정보를 출력
select * from dictionary where table_name like 'USER%';

select * from dictionary where table_name like 'ALL_%';

select * from dictionary where table_name like 'DBA_%';

--자료 사전 테이블의 각 컬럼에 대한 설명을 출력
select * from dict_columns
where table_name = 'USER_CONS_COLUMNS';

select * from USER_CONS_COLUMNS;

--[1] user_xxx
select * from user_objects;
select * from user_tables;

select * from user_constraints;
select * from user_cons_columns;

select * from user_indexes;
select * from user_ind_columns;

select * from user_sequences;

select * from user_views;
select * from user_source;

--[2] all_XXX
select owner, table_name
from all_tables where table_name='EMPLOYEES';

--[3] dba_XXX
select * from dba_users;

select * from dba_data_files;
select * from dba_tablespaces;

select * from dba_roles;

select * from dba_sys_privs;
select * from dba_role_privs;