/* Formatted on 2020/05/06 ���� 11:33:02 (QP5 v5.360) */
--10��_����ڰ���.sql
--[2020-04-29 ������]

--����� ���� ���� ��ȸ

SELECT * FROM dba_users;

--������ ���Ͽ� ���� ���� ��ȸ

SELECT * FROM dba_data_files;

--���̺����̽��� ���� ���� ��ȸ

SELECT * FROM dba_tablespaces;

/*
    ����Ŭ �����ͺ��̽��� ���� ���� ����
    1) �����ͺ�(data block) - �ּ� ���� ����
        �����ͺ��� default size : 8k
    2) �ͽ���Ʈ(extent) - 8���� ������ ���� �� �ϳ��� �ͽ���Ʈ�� ��
    3) ���׸�Ʈ(segment) - �ϳ� �̻��� �ͽ���Ʈ�� ����
    4) ���̺����̽�(tablespace) - ���׸�Ʈ���� �����ϴ� ������ ���� �̸�
    
    �ϳ��� ���̺����̽��� �ּ� 1���� ����������(������ ����)�� ������
*/

--���̺� �����̽� ����

/*
    create tablespace ���̺����̽���
    datafile ������������ ��� size ũ��
    autoextend on next ũ�� --�ڵ� ���� �ɼ�(����)
*/

CREATE TABLESPACE tb_test2
    DATAFILE 'C:\oraclexe\mydata\tb_test2.dbf'
                 SIZE 48 M
                 AUTOEXTEND ON NEXT 10 M;
                 --�ڵ� ���� �ɼ�(����)

--������ ���Ͽ� ���� ���� ��ȸ

SELECT * FROM dba_data_files;

--���̺����̽��� ���� ���� ��ȸ

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


--���̺� �����̽� ����

/*
    drop tablespace ���̺����̽���;
    
    drop tablespace ���̺����̽���
        including contents and datafiles; -- �������� ���������ϱ��� ����
*/

DROP TABLESPACE tb_test3 INCLUDING CONTENTS AND DATAFILES;


-- ����� ���� �����

/*
    create user ������̸�
    identified by ��й�ȣ
    default tablespace ���̺����̽���;
*/

--tb_test2 ���̺����̽��� ����ϴ� ����ڰ��� �����ϱ�

CREATE USER testuser1 IDENTIFIED BY testuser123
    DEFAULT TABLESPACE tb_test2;

SELECT *
  FROM dba_users
 WHERE username LIKE 'TESTUSER%';

--���� ��ȸ

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER1';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER1';


--����ڿ��� ���� �ο��ϱ�
-- create session ���� �ο�(���� ����)
GRANT CREATE SESSION TO testuser1;

/*
    create table tbl_test1
    (
        no number primary key,
        name varchar2(50)
    )tablespace tb_test2;
*/
--���̺� �������� �ο��ϱ�
GRANT CREATE TABLE TO testuser1;
GRANT UNLIMITED TABLESPACE TO testuser1;
--���̺����̽��� ���� ���� �ο�

--���� ��Ż
--revoke ���� from ����ڸ�;
REVOKE CREATE SESSION FROM testuser1;

--testuser2 ����ڿ��� resource, connect role �ο��ϱ�
GRANT CONNECT, RESOURCE TO testuser2;

--���� ��ȸ

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

-- hr ��ȯ ��ȸ

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'HR';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'HR';

--����� ����
--drop user ����� �̸�;
DROP USER testuser7;

SELECT *
  FROM dba_users
 WHERE username LIKE 'TEST%';

--��� ���� ����
--alter user �����ID account unlock;

ALTER USER testuser2
    ACCOUNT UNLOCK;

--���� ��ױ�
--alter user �����ID account lock;

ALTER USER testuser2
    ACCOUNT LOCK;

-- ���� ������ ��ȣ �����ϱ�
--alter user �����ID identified by ���ο��й�ȣ;

ALTER USER testuser2
    IDENTIFIED BY testuser123;

--����Ŭ�� �����ϴ� role��ȸ

SELECT * FROM dba_roles;


----------------------------------------
--[2020-05-06 ������]

SELECT *
  FROM dba_users
 WHERE username LIKE 'TEST%';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER5';

--���� ��ȸ

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER5';

--�� ��ȸ

-- testrole �̶�� �̸��� ���� �����ϰ�, create session, create table���� �ο��ϱ�
--1) �� �����ϱ�
CREATE ROLE testrole;

SELECT *
  FROM dba_roles
 WHERE role = 'TESTROLE';

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTROLE';

--2) �ѿ� ���� �ο��ϱ�
-- create session, create table, unlimited tablespace
GRANT CREATE SESSION, CREATE TABLE TO testrole;
GRANT UNLIMITED TABLESPACE TO testrole;

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTROLE';

--3) testuser5 ����ڿ��� testrole �ο��ϱ�
GRANT testrole TO testuser5;

ALTER USER testuser5
    QUOTA 100 M ON tb_test2;

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER5';

--���� ��ȸ

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER5';

--�� ��ȸ

--���� �����ͺ��̽��� ��ȸ - orcl, xe ��

SELECT * FROM global_name;

-- object ���� �ֱ�
-- �ش� object �� ������ �������� ������ �ο��ϰų� ��Ż�� �� �ִ�.

-- testuser5���� hr������ employees ���̺��� ��ȸ�ϰ�, ������ �� �մ� ���� �ο�
--(hr �������� ó�� ����)

/*
    --select ���� �ο�
    grant select on hr.employees to testuser5;
     
    --update���� �ο�
    grant update on hr.employees to testuser5;
    
    --select���� ��Ż
    revoke select on hr.employees from testuser5;
    
    --update ���� ��Ż
    revoke update on hr.employees from testuser5;
*/

/*
    testuser5�������� ó��
    
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
    hr ��������
    grant select on hr.employees to testuser5 with grant option;
*/

/*
    with grant option
    - ������ �����ϴ� ����
    �� �ٸ� ����ڿ��� ������ �Ҵ��� �� �� �ְ� ��
    object privilege���� ���
*/

/*
    testuser5���� ó��
    grant select on hr.employees to testuser4;
    => testuser5 ������ testuser4�������� hr�� employees�� select �� �� �ִ� ������ �ο���
    
    => testuser4�� �����ؼ� hr�� employees�� select�ϸ� ��ȸ��
*/

REVOKE RESOURCE, CONNECT FROM testuser2;

GRANT RESOURCE, CONNECT TO testuser6 WITH ADMIN OPTION;

/*
    with admin option
    - ������ �����ϴ� ���, �� �ٸ� ����ڿ��� ������ �Ҵ��� �� �� �ְ� ��
    - system ���� ���ѿ��� ���
*/

SELECT *
  FROM dba_sys_privs
 WHERE grantee = 'TESTUSER6';

SELECT *
  FROM dba_role_privs
 WHERE grantee = 'TESTUSER6';
 
/*
    testuser6���� �����ؼ� testuser2���� resource, connect ����(��) �ο��ϱ�
    grant resource, connect to testuser2;
*/

--hr����
select * from user_views;

--hr������ v_emp �信 select�� �� �մ� ������ testuser6���� �ο��ϱ�
--grant select on hr.v_emp to testuser6;

--testuser6����
select * from hr.v_emp;

/*
    <data dictionary>
    - database ���� ����� ��� ��ü�� ������ �������ִ� ���̺�
    - select * from dictionary;
    
    data dictionary�� ����
    1) DBA_XXX 
        - �����ͺ��̽� ������ ���� ������ ����
    2) ALL_XXX 
        - �ڽ��� ������ object�� �ٸ� ����ڰ� ������ object�߿� �ڽ��� �� �� �ִ� ������ ����
        - ����ڰ� ���� ������ ��� ��Ű���� ������ ����
        - ������ �ο��������ν� ����
    3) USER_XXX 
        - �ڽ��� ������ object ������ ����,
        - ���� �����ͺ��̽��� ������ ����ڰ� ������ ��ü�� ������ ����
*/

--��� �ڷ� ������ ������ ���
select * from dictionary where table_name like 'USER%';

select * from dictionary where table_name like 'ALL_%';

select * from dictionary where table_name like 'DBA_%';

--�ڷ� ���� ���̺��� �� �÷��� ���� ������ ���
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