/* Formatted on 2020/04/29 ���� 6:32:07 (QP5 v5.360) */
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
drop user testuser7;

select * from dba_users where username like'TEST%';

--��� ���� ����
--alter user �����ID account unlock;
alter user testuser2 account unlock;

--���� ��ױ�
--alter user �����ID account lock;
alter user testuser2 account lock;

-- ���� ������ ��ȣ �����ϱ�
--alter user �����ID identified by ���ο��й�ȣ;
alter user testuser2 identified by testuser123;

--����Ŭ�� �����ϴ� role��ȸ
SELECT * FROM dba_roles;