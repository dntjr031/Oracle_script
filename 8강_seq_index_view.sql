/* Formatted on 2020/05/06 ���� 10:44:36 (QP5 v5.360) */
--8��_seq_index_view.sql
--[2020-04-28 ȭ����]

/*
    <sequence>
    - �������� ���ڸ� �����س��� ������ ���̽� ��ü
    - �⺻Ű�� ������ �ԷµǴ� row�� �ĺ��� �� �ֱ⸸ �ϸ� �ȴٰ� �Ҷ�,
      �������� ���� ������ ���� �����
    - ���̺� �ִ� �⺻Ű ���� �����ϱ� ���� ���Ǵ� �������� ��ü
    - ���̺� ���ӵ��� ���� => �ϳ��� �������� ���� ���� ���̺� ���ÿ� ����� �� �ִ�.
    
    create sequence ��������
        minvalue    --�������� �ּҰ�
        maxvalue    --�������� �ִ밪
        start with ���۰�
        increment by ����ġ
        nocache     --cache�� ������� �ʰڴ�
        nocycle     --������ ���������� �ִ�ġ Ȥ�� �ּ�ġ�� �ٴٶ��� �� �ʱⰪ���� �ٽ� ������ �� ����
        order       --��û�Ǵ� ������� ���� ����
        
    �� ������ ���
    nextval, currval �ǻ��÷�
    1) nextval - �ٷ� ������ ������ �������� ������ �ִ�.
    2) currval - ���� ������ ���� ������ �ִ�
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

--������ ����

CREATE SEQUENCE pd_temp1_seq START WITH 50 INCREMENT BY 1   -- 50���� �����ؼ� 1�� ����
                                                         NOCACHE;

--����ڰ� ������ sequence ��ȸ

SELECT * FROM user_sequences;

ALTER TABLE pd_temp1
    MODIFY regdate DEFAULT SYSDATE;

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, '��ǻ��', 2000000);

-- seq = 50

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, '�����', 350000);

-- seq=51

SELECT * FROM pd_temp1;

SELECT pd_temp1_seq.CURRVAL FROM DUAL;

-- ���� seq = 51

SELECT pd_temp1_seq.NEXTVAL FROM DUAL;

-- ���� seq = 52, ���� �����Ǿ� ������ ���� ���� �� ������(53)���� ó����

INSERT INTO pd_temp1 (no, pdname, price)
     VALUES (pd_temp1_seq.NEXTVAL, 'Ű����', 27000);

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

-- 1���� �����ؼ� 1�� �����ϴ� ������ ��ü ����

CREATE SEQUENCE pd2_seq INCREMENT BY 1 START WITH 1 NOCACHE;

--������ �Է�

INSERT INTO pd2 (no,
                 pdcode,
                 pdname,
                 price,
                 company)
     VALUES (pd2_seq.NEXTVAL,
             'A01',
             '��Ʈ��',
             3500000,
             '�Ｚ');

INSERT INTO pd2 (no,
                 pdcode,
                 pdname,
                 price)
     VALUES (pd2_seq.NEXTVAL,
             'B01',
             'Ű����',
             38000);

SELECT * FROM pd2;

SELECT * FROM user_sequences;

--������ ����
--drop sequence ��������;

DROP SEQUENCE pd_temp1_seq;

/*
    <index>
    - ���̺��� �����͸� ���� ã�� ���� ����ǥ
    - �ε����� ���ٸ� Ư���� ���� ã�� ���� ��� ������ �������� �� ������ ��
      (table full scan)
    - index seek
      �ε����� ����ϴ� ���� �� ȿ�����̶��, ����Ŭ�� ��� �������� ������ �ʰ�
      �ε��� �������� ã�Ƽ� ���� �����͸� ������
    - �� ���̺� ���� ���� �ε����� ������ �� ����
    
    create [unique] index �ε�����
    on ���̺��(�÷���1, �÷���2, ...)
*/

--primary key�� unique ���������� �ָ� �ڵ����� unique index�� ������

SELECT * FROM pd2;

--��ǰ �ڵ� �ε���

CREATE UNIQUE INDEX idx_pd2_pdcode
    ON pd2 (pdcode);

--��ǰ�� �ε���

CREATE INDEX idx_pd2_pdname
    ON pd2 (pdname);

--��ǰ �����, ȸ��� ����Ű �ε���

CREATE INDEX idx_pd2_regdate_company
    ON pd2 (regdate, company);

--�ε��� ��ȸ

SELECT *
  FROM user_indexes
 WHERE table_name = 'PD2';

SELECT *
  FROM user_ind_columns
 WHERE table_name = 'PD2';

SELECT *
  FROM user_constraints
 WHERE table_name = 'PD2';

--�ε����� �̿��� ��ȸ

SELECT *
  FROM pd2
 WHERE pdcode = 'B01';

SELECT *
  FROM pd2
 WHERE pdname = 'Ű����';

SELECT *
  FROM pd2
 WHERE regdate >= '2020-04-28' AND company = '�Ｚ';

--index ����
--drop index �ε�����
DROP INDEX idx_pd2_pdcode;

/*
    <��-view>
    - view�� ���̺� �ִ� �����͸� �����ִ� ������ �����ϴ� select������ ���
    - view�� ������ �����͸� ������ ������ ������ �並 ���� �����͸� ��ȸ�� �� �ְ�,
      �����͸� �Է�, ����, ������ �� ������ �ٸ� ���̺�� ���ε� �� �� �ֱ� ������ ������ ���� ���̺��̶�� ��
      
    create [or replace] view ���̸�
    as
    select����;
    
    �� �並 ����ϴ� ����
    1) ���ȼ� - ����� ���� �÷����� ���� �� �ִ�.
    2) ���Ǽ� - ���ΰ� ���� ������ ���������� ��� ����� �����ϰ� ���� �� �� �ִ�.
*/

--testuser ����ڴ� emp�� ������(deptno=30) ������� �⺻����
--(�̸�, job, �Ի���)�� �˻��� �� �־�� �Ѵٸ�..

--hr����ڰ� emp ���̺��� �Ϻ� �÷��� �� �� �ִ� �並 ����
--testuser�� �ش� �並 �� �� �ְ� �Ѵ�

--1) hr�������� �� ���� ������ �ο��ؾ� ��
--sys������ �������� ���� �ο��� �ؾ� ��
--grant create view to hr;

--view ���� ���� �����ϱ�
--revoke create view from hr;

--2) hr ����ڰ� �並 �����

CREATE OR REPLACE VIEW v_emp
AS
    SELECT ename, job, hiredate
      FROM emp
     WHERE deptno = 30;

--select * from ���̺� �Ǵ� ��

SELECT * FROM v_emp;

--������ �� ��ȸ�ϱ�

SELECT * FROM emp;

--3) testuser���� �ش� �並 select�� �� �ִ� ������ �ο��Ѵ�

/*
    sys�������� testuser ����� ������ �����
    
    create user testuser
    identified by testuser123
    default tablespace users;
    
    ���� �ο��ϱ�(������ ���� �⺻���� ����)
    grant resource, connect to testuser;
    
    �����ϱ�
    conn testuser/testuser123
*/

GRANT SELECT ON v_emp TO testuser;
-- hr������ ���̹Ƿ� select���� �ο��� ����

--���� ����
--recoke select on v_emp from testuser;

/*
    4) testuser�������� �� select�ϱ�
    select * from hr.v_emp;
              ��Ű���̸�.�����ͺ��̽� ������Ʈ��
*/

--�� �����ϱ�
--research �μ��� ��������� ��ȸ�ؾ� �Ѵٸ�

CREATE OR REPLACE VIEW v_emp
AS
    SELECT ename, job, hiredate
      FROM emp
     WHERE deptno IN (20, 30);

SELECT * FROM emp;

SELECT * FROM v_emp;

--������, research�ο� ���ϴ� ����� �߿�
--1982�� ������ �Ի��� ����� ����(�̸�, ����, �Ի���)�� ��ȸ �Ϸ���?
--1) view

SELECT *
  FROM v_emp
 WHERE hiredate < '1982-01-01';

--2) table

SELECT ename, job, hiredate
  FROM emp
 WHERE deptno IN (20, 30) AND hiredate < '1982-01-01';

--join�� �̿��ϴ� ��쳪 ������ �������� ��� �並 ���� ���
--employees, departments ���̺� ����

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

--�ش� �信�� �޿��� 10000 �̻��� ��� ��ȸ

SELECT *
  FROM v_employees
 WHERE pay > 10000;

--gogak���� �� ������ ���� ����, ���̸� view�� �����
--v_gogak_info

CREATE OR REPLACE VIEW v_gogak_info
AS
    SELECT GNO,
           GNAME,
           JUMIN,
           POINT,
           CASE
               WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
               ELSE '����'
           END    gender,
             EXTRACT (YEAR FROM SYSDATE)
           - (  SUBSTR (jumin, 1, 2)
              + (CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                     ELSE 2000
                 END))
           + 1    age
      FROM gogak;

--�ش� �並 �̿��Ͽ� 20��, 30�� ���ڸ� ��ȸ

SELECT *
  FROM v_gogak_info
 WHERE TRUNC (age, -1) IN (20, 30) AND gender = '����';

--inline view �̿�

SELECT *
  FROM (SELECT GNO,
               GNAME,
               JUMIN,
               POINT,
               CASE
                   WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
                   ELSE '����'
               END    gender,
                 EXTRACT (YEAR FROM SYSDATE)
               - (  SUBSTR (jumin, 1, 2)
                  + (CASE
                         WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                         ELSE 2000
                     END))
               + 1    age
          FROM gogak)
 WHERE TRUNC (age, -1) IN (20, 30) AND gender = '����';



/*
    <�並 ���� ������ ����>
    1. �並 ���� ��ȸ�� �����ϰ�, �Է�, ����, ������ ������ => updatable view
    2. ��ȸ�� ������ �䵵 ���� => read only view
*/

--updatable view �����

/*
    create or replace view ���̸�
    as
        select��;
*/

--rede only view �����

/*
    create or replace view ���̸�
    as
        select��
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

-- updatable view�� �Է�, ����, ���� ����

INSERT INTO v_emp (ename, job, hiredate)
     VALUES ('ȫ�浿', 'CLERK', SYSDATE);

--error, cannot insert NULL into ("HR"."EMP"."EMPNO")
--=> �並 ���� �Է��� �ϴ� ���, �信 ���� �÷��� null�� ����ϰų� default���� �־�� ��
--   �׷��� ������ ���� �߻�

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
             'ȫ�浿',
             'CLERK',
             SYSDATE);

-- ���� ������ ����� ���������� �Է� ������

SELECT *
  FROM v_emp_2
 WHERE empno = 9999;

-- �Է��� ���������� ���� ���̹Ƿ� ��ȸ �Ұ���

DELETE FROM v_emp_2
      WHERE empno = 9999;

-- �Է��� ���������� ���� ���̹Ƿ� ������ �Ұ���

/*
    �⺻������ �並 ���鶧 ���� ������ ����� ������ �����͸� ������ �� ������
    �̸� ������� �ʰ��� �Ҷ��� with check option�� ���
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

--���� ������ ����� �����δ� ������ ���� �Ұ�

INSERT INTO v_emp_3 (empno,
                     ename,
                     job,
                     hiredate)
     VALUES (9998,
             'ȫ�浿',
             'CLERK',
             SYSDATE);

-- error, with check option ����, view WITH CHECK OPTION where-clause violation

SELECT * FROM v_emp_3;

SELECT * FROM user_views;