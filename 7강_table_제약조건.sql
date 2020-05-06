/* Formatted on 2020/05/06 ���� 10:44:34 (QP5 v5.360) */
--7��_table_��������.sql
--[2020-04-27 ������]

/*
    DDL - �����ͺ��̽� ������Ʈ���� ����, ����, ����, �����ϴ� ��ɾ�
    [1] create - ������Ʈ ���� ��ɾ�
               - create ������ƮŸ�� ������Ʈ��...
                 ��) create table ���̺��...
    [2] drop - �������� ����(���� �Ҹ�)
             - drop ������ƮŸ�� ������Ʈ��;
               ��) drop table ���̺��;
    [3] alter - ������Ʈ ���� ����  
              - alter ������ƮŸ�� ������Ʈ��..
                ��) alter table dept5
                    add loc varchar2(20);
    [4] truncate
        - truncate table - ���̺��� ������ ����
          ��) truncate table ���̺��;
          
    �� drop, truncate, delete ��
    1) delete - �޸𸮻��� �����͸� ����, rollback���� �ǵ��� �� �ִ�.
    2) truncate - �޸𸮻��� �����Ϳ� ���������ϱ��� ����, �ڵ� Ŀ�Ե�
                - delete���� ����ӵ��� ����
        => delete, truncate�� �����͸� ����, ���̺� ������ ����ִ�.
    3) drop - ���̺��� �������� ������ �Ҹ��Ŵ
*/

/*
    �� ���̺� �����
    create table ���̺��
    (
        �÷���1 ������Ÿ��,
        �÷���2 ������Ÿ��,
        �÷���3 ������Ÿ��,
        ...
    );
    
    �� ������ Ÿ��
    ������, ������, ��¥��
    [1] ������
    char(ũ��) - �������� ������, �ִ� 2000byte���� ����
    varchar2(ũ��) - �������� ������, �ִ� 4000byte���� ����
    clob Ÿ��(Character large Object)
    - ũ�Ⱑ ū ���ڿ��̳� ������ ������ ����
    - longŸ���� Ȯ��� ����, 4GB���� ����
*/
--char, varchar2 ��

CREATE TABLE char_exam1
(
    names1    CHAR (3),
    -- �������� 3����Ʈ
    names2    VARCHAR2 (3)
-- �������� 3����Ʈ
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
    --�����ϸ� byte
    names2    VARCHAR2 (3),
    names3    CHAR (6 BYTE),
    names4    CHAR (6 CHAR),
    names5    CHAR (6),
    names6    CLOB
-- 4GB���� ����
);

INSERT INTO char_exam1
     VALUES ('AAA',
             '��',
             'ABCDEF',
             'ABCDEFG',
             'AB',
             NULL);

-- error, names4�� 6�� ���ڸ� �Է� �����ϹǷ� ����

INSERT INTO char_exam1
     VALUES ('AAA',
             '��',
             'ABCDEF',
             '�����ٶ󸶹�',
             '����',
             NULL);

--���ڵ��� ���� �ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ
--UTF8 : �ѱ� 1���ڰ� 3����Ʈ

INSERT INTO char_exam1
     VALUES ('AAA',
             '��',
             'ABCDEF',
             '�����ٶ󸶹�',
             '������',
             NULL);

--names5�� 6����Ʈ�̹Ƿ� �ѱ� 2���ڸ� �Է� ����

SELECT *
  FROM nls_session_parameters
 WHERE parameter = 'NLS_LENGTH_SEMANTICS';

--=> char, varchar2���� �����ϸ� byte

INSERT INTO char_exam1 (names1, names3, names6)
     VALUES ('AAC', 'ABCDEF', 'abcdEFGH������ clob ����');

SELECT * FROM char_exam1;

/*
    [2] ������
    number
    number(��ü �ڸ���)
    number(��ü �ڸ���, �Ҽ����� �ڸ���)
*/

CREATE TABLE num_exam1
(
    n1    NUMBER,
    n2    NUMBER (9),
    --��ü 9�ڸ��� ǥ������
    --�Ҽ����� �ڸ����� ǥ������ ����
    n3    NUMBER (9, 2),
    --��ü 9�ڸ��� ���� �Ҽ����� 2�ڸ����� ǥ�� ����
    --�Ҽ����� 3°�ڸ����� �ݿø�
    n4    NUMBER (9, 1),
    --��ü 9�ڸ��� ���� �Ҽ����� 1�ڸ����� ǥ�� ����
    --�Ҽ����� 2°�ڸ����� �ݿø�
    n5    NUMBER (7),
    --��ü 7�ڸ��� ǥ������
    n6    NUMBER (7, -2),
    --��ü 7�ڸ��� �� ǥ��, �����ڸ����� �ݿø�
    n7    NUMBER (6),
    --��ü 7�ڸ��� ǥ������
    n8    NUMBER (3, 5)
--1���� ���� �Ǽ� ǥ��, �Ҽ����� 5�ڸ� �� 0�� �ΰ�(5-3) �ٴ´�
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

             -- error, n7�� ��ü �ڸ��� 6���� ����, ���� 7���̹Ƿ� ����

SELECT * FROM num_exam1;

/*
    n8 number(3,5)
    - ��ü �ڸ����� �Ҽ����� �ڸ������� ���� ���
    - 1���� ���� �Ǽ� ǥ��
    - ��ü �ڸ��� 3��, �Ҽ����� �ڸ��� 5��
    => 5-3 => �Ҽ����� �ڸ����� 2���� 0�� �ٰ� ��
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
    [3] ��¥��
    date - ����� �ú��ʱ��� ǥ��
    timestamp - �и��ʱ����� ǥ��
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

--���̺� ����� ���� : tbl_test1

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
     VALUES ('ȫ�浿',
             '970930-2296312',
             'ȫ�浿 �ƹ����Դϴ�.',
             'M',
             25,
             '2020-04-27');

SELECT * FROM tbl_test1;

/*
    <������ ��������>
    ������ ���Ἲ
    - ����Ŭ �������� �����͸� �� ���� �����ǰ� ���� �ִ� ��
    - ����� �� �����͵��� �ùٸ��� ����� �� �ֵ��� �ϱ� ���� 
      �����ͺ��̽� ������ �����ϴ� ��ɵ� => ���Ἲ ��������
    - ���Ἲ�� ��Ű�� ���� ���� ���ǵ��� ������
    - �������ǵ��� ���̺��� �÷��� �����
    
    �� ������ ���� ����(Integrity Constraints)
    [1] null / not null
    [2] unique
    [3] primary key
    [4] foreign key
    [5] check
    [6] default
*/

/*
    [1] null(not null => C)
    - �����Ͱ� ������ �ǹ�
    - �÷��� �Ӽ��� �ϳ��� �ش� �÷��� null���� ����ϴ��� ������� �ʴ��� ����
    - ������ Ÿ�� ������ ����ؾ� ��
    - null�� ����ϸ� null, ������� ������ not null�� ���
    - ������� ������ default���� null�� ����
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

--���� : col1�� not null�̹Ƿ� ���� �Է��ؾ� �� 

INSERT INTO null_exam1 (col1, col2, col3)
     VALUES ('TT1', '', NULL);

-- null�� ���� �Է��ϴ� ��� : null, '' �Է�

INSERT INTO null_exam1 (col1, col3)
     VALUES ('TT2', ' ');

-- ' ' �� null�ƴ�

SELECT *
  FROM null_exam1
 WHERE col3 IS NULL;

SELECT *
  FROM null_exam1
 WHERE col3 IS NOT NULL;

--=> �ʼ� �Է��׸񿡴� not null ���������� �����ؾ� ��

/*
    [2] unique (U)
    - �� ���ڵ带 �����ϰ� �Ǻ��� �� �ִ� �Ӽ�
    - ����Ű�� unique ������������ ����� �� �ִ�
    - �� ���̺� ���� ���� unique ���������� �� �� �ִ�
    - null�� �����
*/

CREATE TABLE unique_exam1
(
    col1    VARCHAR2 (10) UNIQUE NOT NULL,
    col2    VARCHAR2 (10) UNIQUE,
    col3    VARCHAR2 (10) NOT NULL,
    col4    VARCHAR2 (10) NOT NULL,
    CONSTRAINTS uni_tmp_uk UNIQUE (col3, col4)
--���� unique Ű(outline ���� ����)

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

             --error : col1�� �ߺ�

INSERT INTO unique_exam1 (col1, col3, col4)
     VALUES ('A4', 'C1', 'D1');

             --error : col3, col4 �� ����Ű�� unique�ؾ� �ϹǷ�

INSERT INTO unique_exam1 (col1, col3, col4)
     VALUES ('A5', 'C5', 'D5');

             -- col2�� unique������, null����ϹǷ� �Է°��� 

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

--����(unique Ű�� �ɸ� Į���� ������ �� 'A1'�� �ٽ� �Է��Ͽ� �������ǿ� ����)

SELECT * FROM unique_exam1;

/*
    null�� ����� unique���� ���� �Է����� ���� �� �ֵ�.
    col2�� ���� null�� ���ڵ尡 ���� �� 
    => unique��󿡼� ���ܵ�
    
    unique �������ǿ��� not null�� �����ϴ� ���� �Ϲ�����
*/
--�������� ��ȸ
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
    - �� ���ڵ带 �����ϰ� �ĺ��� �� �ִ� �Ӽ�
    - ���̺�� �ϳ��� �� �� �ִ�.
    - not null + unique index
    - ����Ű�� ����
*/

CREATE TABLE pk_exam1
(
    col1    CHAR (3) PRIMARY KEY,
    -- inline ��������
    --col2    char(3) primary key,
    -- error, primart key�� �ϳ��� ���� ����
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

--error, primary key�� not null�̹Ƿ� null�� ������� ����


INSERT INTO pk_exam1 (col1)
     VALUES ('A02');

SELECT * FROM pk_exam1;

CREATE TABLE pk_exam2
(
    col1    CHAR (3),
    col2    VARCHAR (4),
    col3    NUMBER,
    CONSTRAINT pk_col1_col2 PRIMARY KEY (col1, col2)
-- outline ��������, ����Ű
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
    [4] foreign key (R) �ܷ�Ű ��������
    - �ٸ� ���̺��� �����ϱ� ���Ͽ� ���Ǵ� �Ӽ���
    - ���̺� ���� ���踦 ������ �� ���Ǵ� Ű
    - �θ� ���̺��� primary key �� unique�� �ڽ� ���̺��� foreign key�� ���̵ȴ�
    
    - �Է½� �θ� ���̺��� ���� insert�ϰ�, �� �Ŀ� �ڽ� ���̺��� insert�ؾ� ��
    - �θ� ���̺� �ִ� ���� �÷��� ���� �ڽ� ���̺��� ����� �� �ִ�
     (�θ� ���̺� ���� ���� �ڽ� ���̺��� ����ϴ� ���� �Ұ���)
    
    - ������ �ڽ� ���̺��� ���� �����ϰ�, �� �Ŀ� �θ� ���̺��� �����ؾ� ��
    - foreign key������ on delete cascade �ɼ��� �ָ�
     �θ� ���̺��� ���ڵ带 �����ϸ� �ڽ� ���̺��� �ش� ����ũ�� �Բ� ������
*/

/*
    [5] check ���� ����(C)
    - �ԷµǴ� ���� üũ�Ͽ� ������ ���ǿ� �ش�Ǵ� ���� �Էµ� �� �ְ� �ϴ� ���� ����
     ��) ����(gender) �÷� => ����, ���ڸ� �Էµǰ� �ٸ� ���� �Էµ� �� ������
*/

CREATE TABLE check_exam1
(
    no        NUMBER PRIMARY KEY,
    name      VARCHAR2 (30) NOT NULL,
    gender    CHAR (6) CHECK (gender IN ('����', '����')),
    -- inline ���� ����
    pay       NUMBER (10),
    age       NUMBER (3),
    CONSTRAINT ck_check_exam1_pay CHECK (pay >= 0),
    CONSTRAINT ck_check_exam1_age CHECK (age BETWEEN 0 AND 120)
);

INSERT INTO check_exam1 (no, name)
     VALUES (1, 'ȫ�浿');

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (2,
             '��浿',
             '����',
             5000000,
             35);

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (3,
             '�̱��',
             '��',
             5000000,
             36);

--error, gender check �������� ����

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (4,
             '�����',
             '����',
             -5000000,
             37);

--error, pay check �������� ����

INSERT INTO check_exam1 (no,
                         name,
                         gender,
                         pay,
                         age)
     VALUES (5,
             '��浿',
             '����',
             5000000,
             135);

--error, age check �������� ����

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
    - �⺻��
    - �÷��� Ư������ default������ �����ϸ� ���̺� �����͸� �Է��� ��
     �ش� �÷��� ���� �Է����� ���� ���, default�� ������ ���� �ڵ����� �Էµ�
    - �÷� Ÿ�� ������ 'default ����Ʈ��' �� ���
    - �ݵ�� ������ Ÿ�� ������, null�̳� not null �տ� ��ġ���Ѿ� ��  
*/

CREATE TABLE default_exam1
(
    no          NUMBER PRIMARY KEY,
    name        VARCHAR2 (30),
    gender      CHAR (3) DEFAULT '��' CHECK (gender IN ('��', '��')),
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
             'ȫ�漱',
             '��',
             DEFAULT,
             90);

INSERT INTO default_exam1
     VALUES (4,
             '��浿',
             DEFAULT,
             DEFAULT,
             DEFAULT);

SELECT * FROM default_exam1;

--���������� �̿��Ͽ� ���̺� �����
--1) �μ� ���̺� �����
--�μ�(�θ�) <=> ���(�ڽ�)
DROP TABLE depart CASCADE CONSTRAINT;

/*
    => �ڽ� ���̺��� �����ϰ� �ִ� �θ� ���̺��� drop�� �� ������
      ���� ���� ���Ǳ��� �����ϰ� ������ drop�� cascade constraint�ɼ��� �ش�
*/

CREATE TABLE depart
(
    dept_cd      CHAR (3) PRIMARY KEY,
    dept_name    VARCHAR2 (50) NOT NULL,
    loc          VARCHAR2 (100)
);

--2) ��� ���̺� �����
--���(�θ�) <=> �������(�ڽ�)

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

--drop�� cascade constraint�ɼ��� �̿��Ͽ� EMPLOYEE�� �ܷ�Ű�� ���������Ƿ�
--�ٽ� depart ���̺� create�ϰ�, �ܷ�Ű�� �߰��� �ش�.

ALTER TABLE employee
    ADD CONSTRAINT fk_employee_dcode FOREIGN KEY (dcode)
            REFERENCES depart (dept_cd);

--3) ������� ���̺� �����

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
--�θ� ���̺� ���� �����͸� �Է�
--1) �μ� ���̺� insert

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('A01', '�λ��', '����');

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('B01', '������', '�λ�');

INSERT INTO depart (dept_cd, dept_name, loc)
     VALUES ('C01', '�ѹ���', '����');

SELECT * FROM depart;

--2) ������̺� insert
--�θ��� �μ� ���̺��� ���ڵ尡 ������ �ڽ� ��� ���̺��� insert�� �� ����

INSERT INTO employee
     VALUES (1001,
             'ȫ�浿',
             'A01',
             5000000,
             'h@nate.com',
             DEFAULT);

INSERT INTO employee
     VALUES (1002,
             'ȫ�浿2',
             'F01',
             5000000,
             'h2@nate.com',
             DEFAULT);

-- error, Oparent key not found

INSERT INTO employee
     VALUES (1003,
             'ȫ�浿3',
             'A01',
             -5000000,
             'h3@nate.com',
             DEFAULT);

--error, sal check���� ���� ����

INSERT INTO employee
     VALUES (1004,
             'ȫ�浿4',
             'A01',
             5000000,
             'h@nate.com',
             DEFAULT);

--error, email unique �������� ����

INSERT INTO employee
     VALUES (1002,
             '��浿',
             'B01',
             2000000,
             'k@nate.com',
             DEFAULT);

INSERT INTO employee
     VALUES (1003,
             '�̱浿',
             'C01',
             3000000,
             'l@nate.com',
             DEFAULT);

SELECT * FROM employee;

--3) ������� ���̺� insert

INSERT INTO family (empno, name, relation)
     VALUES (1005, '�ڱ��', '��');

--error, parent key not found

INSERT INTO family (empno, name, relation)
     VALUES (1001, 'ȫ�ƺ�', '��');

INSERT INTO family (empno, name, relation)
     VALUES (1001, '�����', '��');

INSERT INTO family (empno, name, relation)
     VALUES (1001, 'ȫ�ƺ�', '��');

--error, unique�������� ����

INSERT INTO family (empno, name, relation)
     VALUES (1002, '��ƹ���', '��');

INSERT INTO family (empno, name, relation)
     VALUES (1002, '�ھ�Ӵ�', '��');

INSERT INTO family (empno, name, relation)
     VALUES (1002, '����', '��');

SELECT * FROM family;

SELECT f.*, e.*
  FROM family f JOIN employee e ON f.EMPNO = e.EMPNO;

--delete
--�ڽ��� �����ϰ� �ִ� �θ� ���̺��� ���ڵ带 �����ϴ� ���
--1) on delete cascade �ɼ��� ���� ���� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� ���� �߻�

DELETE FROM depart
      WHERE dept_cd = 'A01';

--error, foreign key �������� ����
--=> ������ �ݵ�� �ؾ� �ȴٸ�, �ڽ� ���ڵ带 ���� ������ �� �θ� ���ڵ带 �����Ѵ�

--2) on delete cascade �ɼ��� �� ���
--=> �θ� ���̺��� ���ڵ带 �����ϸ� �ش� ���ڵ带 �����ϴ� �ڽ� ���̺� ���� ������

DELETE FROM employee
      WHERE empno = 1001;

--family���� �����ϰ� �ִ� ���ڵ� ����
--=> �θ��� employee�� 1001�� ���ڵ尡 �����Ǹ鼭 �ڽ��� family�� 101�� ���ڵ嵵 ���� ������

--ȸ�� ���̺� �����-member2 
--no - ��ȣ, �⺻Ű 
--userid ���̵�, unique, �ݵ�� �� �Էµǵ��� 
--name �̸�, �ݵ�� �� �Էµǵ��� 
--pwd ��й�ȣ , �ݵ�� �� �Էµǵ��� 
--email �̸���, hp �޴�����ȣ, zipcode �����ȣ, address  �ּ�(�õ�, ����, ��),
-- addressDetail ���ּ�, 
--regdate ������, �⺻��:�������� 
--mileage  ���ϸ���, �⺻�� :0, 0~1000000 ������ ���� ������

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

--[2020-04-28 ȭ����]

/*
1) ���̺� ���� �� �������� �߰�
 alter table ���̺��
 add constraint ���������̸� ������������(�÷�);
 ex) alter table emp
     add constraint pk_empno primary key(empno);
     
2) ���̺��� ����鼭 �ƿ����� �������� ����
 - �÷����� ��� ������ ���Ŀ�
 , constraint ���������̸� �������� ����(�÷�)
 ex) , constraint pk_empno primary key(empno);
 
3) �ζ��� �������� ����
 - �÷��� ������Ÿ�� �ڿ� �������� ����
 ex) empno number primary key
*/
--���̺� ���� �� �������� �߰��ϱ�

CREATE TABLE employee2
(
    empno       NUMBER,
    name        VARCHAR2 (30) NOT NULL,
    dcode       CHAR (3) NOT NULL,
    sal         NUMBER (10) DEFAULT 0,
    email       VARCHAR2 (50),
    hiredate    DATE DEFAULT SYSDATE
);

--�������� �߰��ϱ�
--primary key �������� �߰�

ALTER TABLE employee2
    ADD CONSTRAINT pk_employee2_empno PRIMARY KEY (empno);

SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEE2';

--default�� ��ȸ

SELECT column_name, data_default
  FROM user_tab_columns
 WHERE table_name = 'EMPLOYEE2';

--foreign key �������� �߰�

ALTER TABLE employee2
    ADD CONSTRAINT fk_employee2_empno FOREIGN KEY (dcode)
            REFERENCES depart (dept_cd);

--check �������� �߰�

ALTER TABLE employee2
    ADD CONSTRAINT check_employee2_sal CHECK (sal >= 0);

--unique �������� �߰�

ALTER TABLE employee2
    ADD CONSTRAINT check_employee2_email UNIQUE (email);

--not null, default �������� �����ϱ�

ALTER TABLE employee2
    MODIFY name NULL;

--name �÷��� not null �̾��µ� null�� ����

ALTER TABLE employee2
    MODIFY name NOT NULL;

--name �÷��� null �̾��µ� not null�� ����

ALTER TABLE employee2
    MODIFY sal DEFAULT 1000;

-- sal �÷��� default���� 0�̾��µ� 1000���� ����

--�������� �̸� �����ϱ�

ALTER TABLE employee2
    RENAME CONSTRAINT fk_employee2_empno TO fk_employee2_dcode;

--�������� �����ϱ�

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
    select ��
    
    �� �̿��ؼ� ���̺��� �����, null, not null�� ������ ���������� ������� ����
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

--������ ���̺� primary key �߰�

ALTER TABLE depart_temp1
    ADD CONSTRAINT pk_depart_temp1_dept_cd PRIMARY KEY (dept_cd);

-- not null���� ���������̸� �ֱ�

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



--���̺� �����ϱ�(alter table �̿�)

--1) ���ο� �÷� �߰�

SELECT * FROM depart;

ALTER TABLE depart
    ADD pdept CHAR (3);

--�߰��� �� ���� null�� ��

ALTER TABLE depart
    ADD country VARCHAR2 (50) DEFAULT '�ѱ�';

--�߰��� �� ���� default���� ��

--2) �÷��� ������ ũ�� �����ϱ�
--country �÷��� ������ Ÿ�� ����, varchar2(50) => varchar2(100)

ALTER TABLE depart
    MODIFY country VARCHAR2 (100);

DESC depart;

--3) �÷� �̸� ����
--loc => area �� ����

ALTER TABLE depart
    RENAME COLUMN loc TO area;

SELECT * FROM depart;

--cf. ���̺� �̸� �����ϱ�

SELECT * FROM depart_temp1;

RENAME depart_temp1 TO depart_temp10;

SELECT * FROM depart_temp10;

--�÷� �����ϱ�

ALTER TABLE depart_temp10
    DROP COLUMN loc;

CREATE TABLE depart_temp2
AS
    SELECT *
      FROM depart
     WHERE 1 = 0;

SELECT * FROM depart_temp2;