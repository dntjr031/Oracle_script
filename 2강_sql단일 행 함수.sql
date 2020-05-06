/* Formatted on 2020/05/06 ���� 10:44:40 (QP5 v5.360) */
--2��_���� �� �Լ�.sql 
--2020.04.17 �ݿ���

/*
������ �Լ� - �ԷµǴ� �������� ������ ����
[1] �����Լ� - �ԷµǴ� ��(�Ű�����)�� ������ �Լ�
[2] �����Լ�
[3] ��¥�Լ�
[4] ����ȯ �Լ�
[5] �Ϲ��Լ�
*/

-- [1] �����Լ�
-- initcap() - ���� ù���ڸ� �빮�ڷ� �ٲ۴�.

SELECT id, INITCAP (id) FROM student;

SELECT 'pretty girl', INITCAP ('pretty girl') FROM DUAL;

-- ���� ���� ���ڵ� �빮�ڷ� �ٲ���

--upper() - �빮�ڷ� ��ȯ
--lower() - �ҹ��ڷ� ��ȯ

SELECT id, INITCAP (id), UPPER (id), LOWER (id) FROM student;

SELECT LOWER ('JAVA') FROM DUAL;

SELECT *
  FROM emp
 WHERE ename = 'SCOTT';

SELECT *
  FROM emp
 WHERE LOWER (ename) = 'scott';

--length(), lengthb() - ���ڿ��� ���̸� �������ִ� �Լ�
--lengthb() - ���ڿ��� ����Ʈ���� ����(�ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ�� ó��)
--express ������ 3����Ʈ�� ó��

SELECT name,
       id,
       LENGTH (name)      "�̸��� ����",
       LENGTHB (name)     "�̸� ����Ʈ��",
       LENGTH (id)        "id ����",
       LENGTHB (id)       "id�� ����Ʈ��"
  FROM student;

--concat(���ڿ�, ���ڿ�) - �� ���ڿ��� ������ �ִ� �Լ�
-- 3�� �̻��� ���ڿ��� �����Ϸ��� || ������ �̿�

SELECT name || position            AS "���� �̸�",
       CONCAT (name, position)     AS "concat�̿�",
       name || ' ' || position     AS "|| ������ �̿�"
  FROM professor;

--select concat(naem,' ', position) from professor; -- error

--substr() - ���ڿ����� Ư�� ������ ���ڿ��� ������ �� ���

/*
substr(���ڿ�, ������ġ, ������ ���ڼ�)
-������ġ�� -(����)�� �ϸ� �ڿ������� �ڸ����� �����
*/

SELECT SUBSTR ('abcdefghi', 2, 3),
       SUBSTR ('abcdefghi', 6),
       SUBSTR ('abcdefghi', -5, 2)
  FROM DUAL;

--bcd, fghi, ef
--2��° ��ġ���� 3�� ����
-- 6��° ��ġ���� ������ ����
-- �ڿ��� 5��° ��ġ���� 2�� ����

SELECT SUBSTR ('java����Ŭ', 5, 2),
       SUBSTR ('java����Ŭ', 3, 3),
       SUBSTR ('java����Ŭ', 6),
       SUBSTR ('java����Ŭ', -3, 1)
  FROM DUAL;

--����, va��, ��Ŭ, ��

--ĳ���ͼ� Ȯ��

SELECT parameter, VALUE
  FROM nls_database_parameters
 WHERE parameter LIKE '%CHAR%';

--student ���̺��� JUMIN Į���� ����Ͽ� 1������ 101 ���� �л����� �̸��� ��������� ��� 

SELECT name, SUBSTR (jumin, 1, 6) �������
  FROM student
 WHERE deptno1 = 101;

-- student ���̺��� JUMIN Į���� ����Ͽ� �¾ ���� 8���� ����� �̸��� ��������� ��� 

SELECT name, SUBSTR (jumin, 1, 6) �������
  FROM student
 WHERE SUBSTR (jumin, 3, 2) = 8;

--substrb()

SELECT name, SUBSTR (name, 1, 2), SUBSTRB (name, 1, 3) FROM student;

--instr()- �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
--instr(���ڿ�, ã�� ����)
--instr(���ڿ�, ã�� ����, ������ġ, ���°����)
--���°�� �⺻���� 1

SELECT 'A*B*C*',
       INSTR ('A*B*C*', '*'),
       INSTR ('A*B*C*', '*', 3),
       INSTR ('A*B*C*',
              '*',
              3,
              2)
  FROM DUAL;

--2,4,6
--�տ������� ���� ó�� ������ *�� ��ġ(����Ŭ������ ��ġ���� 1���� ����)
--3��° ��ġ ���Ŀ� ó�� ������ *�� ��ġ
--3��° ��ġ ���Ŀ� 2��°�� ������ *�� ��ġ

SELECT 'A*B*C*',
       INSTR ('A*B*C*', '*', -1),
       INSTR ('A*B*C*', '*', -2),
       INSTR ('A*B*C*',
              '*',
              -2,
              2),
       INSTR ('A*B*C*',
              '*',
              -3,
              2),
       INSTR ('A*B*C*',
              '*',
              -3,
              4)
  FROM DUAL;

--6,4,2,2,0
--�ڿ��� ù��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� �� ��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� �� ��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� �� ��°�� ������ *�� ��ġ => ������ 0����

--student ���̺��� TEL Į���� ����Ͽ� �л��� �̸��� ��ȭ��ȣ, ')'�� ������ ��ġ�� ��� 

SELECT name, tel, INSTR (tel, ')') FROM student;

-- student ���̺��� �����ؼ� 1������ 101���� �л��� �̸��� �� ȭ��ȣ�� ������ȣ�� ���. 
--��, ������ȣ�� ���ڸ� ���;� �� 

SELECT name, tel, SUBSTR (tel, 1, INSTR (tel, ')') - 1) ������ȣ
  FROM STUDENT
 WHERE deptno1 = 101;

--���ϸ� �����ϱ�

CREATE TABLE test_file
(
    no          NUMBER,
    filepath    VARCHAR2 (100)
);

INSERT INTO test_file
     VALUES (1, 'c:\test\js\example.txt');

INSERT INTO test_file
     VALUES (2, 'd:\css\sample\temp\abc.java');

SELECT * FROM test_file;

-- ���ϸ� ����

SELECT no, SUBSTR (filepath, INSTR (filepath, '\', -1) + 1) ���ϸ�
  FROM test_file;

-- Ȯ���ڸ� ����

SELECT no, SUBSTR (filepath, INSTR (filepath, '.', -1) + 1) Ȯ����
  FROM test_file;

--���� ���ϸ� ����

SELECT no,
       SUBSTR (filepath,
               INSTR (filepath, '\', -1) + 1,
               INSTR (filepath, '.', -1) - INSTR (filepath, '\', -1) - 1)    "���� ���ϸ�"
  FROM test_file;

--lpad(���ڿ� �Ǵ� �÷���, �ڸ���, ä�﹮��)
--���ڿ��� ���� �ڸ����� ä�� ���ڷ� ä���. ���ʺ��� ä����
--RPAD() - �����ʺ��� ä����

--student ���̺��� 1������ 101���� �а� �л����� ID�� �� 10�ڸ� �� ����ϵ� 
--���� �� �ڸ��� '$'��ȣ�� ä�켼�� 

SELECT name, id, LPAD (id, 10, '$')
  FROM student
 WHERE deptno1 = 101;

-- �ǽ�) DEPT2 ���̺��� ����Ͽ� DNAME�� ���� ����� �������� �� �� �ۼ��ϱ� ? 
--dname�� �� 10����Ʈ�� ����ϵ� ���� dname�� ������ ������ �� �ڸ��� �ش� �� ���� ���ڰ� ������ ��. 
--��, ������� �̸��� �� 6����Ʈ�̹Ƿ� ���ڰ� 1234���� �� ��

SELECT dname, LPAD (dname, 10, '1234567890') FROM dept2;

--student ���̺��� ID�� 12�ڸ��� ����ϵ� ������ �� �ڸ����� '*'�� ȣ�� ä�켼�� 

SELECT name, id, RPAD (id, 12, '*') FROM student;

--ltrim(���ڿ��̳� �÷���, ������ ����)
--���ʿ��� �ش� ���ڸ� �����Ѵ�
--������ ���ڸ� �����ϸ� ������ ������

--rtrim() - �����ʿ��� �ش� ���ڸ� ������

SELECT LTRIM ('javaoracle', 'j'),
       LTRIM ('javaoracle', 'abcdefghijvw'),
       LTRIM ('javaoracle', 'java'),
       RTRIM ('javaoracle', 'oracle'),
       RTRIM ('javaoracle', 'abcelmnopqr'),
       '|' || LTRIM ('   javaoracle'),
       RTRIM ('java oracle   ') || '|'
  FROM DUAL;

 --DEPT2 ���̺��� DNAME�� ����ϵ� ���ʿ� '��'�̶� ���ڸ� ��� �����ϰ� ��� 

SELECT dname, LTRIM (dname, '��') FROM dept2;

 --DEPT2 ���̺��� DNAME�� ����ϵ� ������ ���� '��'��� ���ڴ� �����ϰ� ��� 

SELECT dname, RTRIM (dname, '��') FROM dept2;

--reverse()
--� ���ڿ��� �Ųٷ� �����ִ� ��

SELECT 'oracle', reverse ('oracle')                 --reverse('���ѹα�') --�ѱ��� ����
                                    FROM DUAL;

--replace(���ڿ��̳� �÷���, ����1, ����2)
--���ڿ����� ����1�� ������ ���� 2�� �ٲپ� ����ϴ� �Լ�

SELECT REPLACE ('javajsp', 'j', 'J'), REPLACE ('javajsp', 'jsp', 'oracle')
  FROM DUAL;

--student ���̺��� �л����� �̸��� ����ϵ� �� �κ��� '#'���� ǥ �õǰ� ��� 

SELECT name, REPLACE (name, SUBSTR (name, 1, 1), '#') FROM student;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� ����� �� 
--��� ���ڸ� '#'���� ǥ�õǰ� ��� 

SELECT name, REPLACE (name, SUBSTR (name, 2, 1), '#') �̸�
  FROM student
 WHERE deptno1 = 101;



--[2] ���� �Լ�
--round(����, ���ϴ� �ڸ���) - �ݿø�

SELECT 12345.457,
       ROUND (12345.457),
       ROUND (12345.457, 1),
       ROUND (12345.457, 2),
       ROUND (12345.457, -1),
       ROUND (12345.457, -2),
       ROUND (12345.457, -3)
  FROM DUAL;

--12345, 12345.5, 12345.46, 12350, 12300, 12000

/*
������ �ݿø�(�Ҽ� ���� ù° �ڸ����� �ݿø�)
1: �Ҽ����� 1�ڸ��� �����(�Ҽ����� ��° �ڸ����� �ݿø�)
2: �Ҽ����� 2�ڸ��� �����
-1: 1���ڸ����� �ݿø�(�ڸ����� ������ ��쿡�� �Ҽ� �̻󿡼� ó��)
-2: 10���ڸ����� �ݿø�
-3: 100���ڸ����� �ݿø�
*/

--trunc(����, ���ϴ� �ڸ���) - ����

SELECT 12345.457,
       TRUNC (12345.457),
       TRUNC (12345.457, 1),
       TRUNC (12345.457, 2),
       TRUNC (12345.457, -1),
       TRUNC (12345.457, -2),
       TRUNC (12345.457, -3)
  FROM DUAL;

--12345, 12345.4, 12345.45, 12340, 12300, 12000

SELECT first_name,
       salary,
       ROUND (salary, -3),
       TRUNC (salary, -3)                                 -- 100�� �ڸ����� �ݿø�, ����
  FROM employees;

--mod(����, ������ ��) - �������� ���ϴ� �Լ�
--ceil(�Ҽ����� �ִ� �Ǽ�) - �ø�(�־��� ���ڿ� ���� ������ ū ���� ���)
--floor(�Ҽ����� �ִ� �Ǽ�) - ����(���� ������ ���� ����)
--power(����1, ����2) - ����1�� ����2��

SELECT MOD (13, 3), CEIL (12.3), FLOOR (17.87), POWER (3, 4) FROM DUAL;

--[3] ��¥ �Լ�
--1) ��ĥ ��, ��ĥ ��

/*
���ú��� 100�� ��, 100�� ��
2020-04-17 + 100 => ��¥
2020-04-17 - 100 => ��¥
=> ���ϰ� ���� ������ �ϼ�
*/

--sysdate : �������ڸ� �����ϴ� �Լ�

SELECT SYSDATE FROM DUAL;

SELECT SYSDATE           AS ��������,
       SYSDATE + 100     AS "100�� ��",
       SYSDATE - 100     AS "100�� ��",
       SYSDATE + 1       �Ϸ���,
       SYSDATE - 1       �Ϸ���
  FROM DUAL;

--2�� 1�ð� 5�� 10�� �� ��¥ ���ϱ�

SELECT SYSDATE                                                       ��������,
       SYSDATE + 2 + 1 / 24 + 5 / (24 * 60) + 10 / (24 * 60 * 60)    "2�� 1�ð� 5�� 10�� ��"
  FROM DUAL;

--3���� �� ��¥, 3������ ��¥
--add_months(��¥, ������) : �ش糯¥�κ��� ������ ��ŭ ���ϰų� �� ��¥�� ���Ѵ�
--=> �� ���� ��, �� ���� ���� �ش��ϴ� ��¥�� ���� �� �ִ�

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 3)      AS "3���� ��",
       ADD_MONTHS (SYSDATE, -3)     "3���� ��"
  FROM DUAL;

--1�� ��, 1�� �� ��¥

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 12)      AS "1�� ��",
       ADD_MONTHS (SYSDATE, -12)     AS "1�� ��"
  FROM DUAL;

-- 2�� 4���� 1�� 3�ð� 10�� 20�� ���� ��¥ ���ϱ�

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 2 * 12 + 4)
           "2�� 4���� ��",
         ADD_MONTHS (SYSDATE, 2 * 12 + 4)
       + 1
       + 3 / 24
       + 10 / (24 * 60)
       + 20 / (24 * 60 * 60)
  FROM DUAL;

--to_yminterval()
--to_dsinterval()

SELECT SYSDATE,
       SYSDATE + TO_YMINTERVAL ('02-04')
           "2�� 4���� ��",
       SYSDATE + TO_DSINTERVAL ('1 03:10:20')
           "1�� 3�ð� 10�� 20�� ��",
       SYSDATE + TO_YMINTERVAL ('02-04') + TO_DSINTERVAL ('1 03:10:20')
           AS "2-4-1 3:10:20��"
  FROM DUAL;

--2)�� ��¥ ������ ����� �ð�(�ϼ�)
--���� 1/1 ���� ��ĥ ����Ǿ�����
--2020-04-17 - 2020-01-01 => ����

SELECT '2020-04-17' - '2020-01-01' FROM DUAL;                                                                                                                                                                                     --error

SELECT TO_DATE ('2020-04-17') - TO_DATE ('2020-01-01') FROM DUAL;

--to_date(����) => ���ڸ� ��¥���·� ��ȯ���ִ� �Լ�

--�������� ���ñ��� ����� �ϼ�, ���ú��� ���ϱ��� ���� �ϼ�

SELECT TO_DATE ('2020-04-17') - TO_DATE ('2020-04-16')     "��������",
       TO_DATE ('2020-04-18') - TO_DATE ('2020-04-17')     "���ϱ���"
  FROM DUAL;

SELECT SYSDATE,
       SYSDATE - TO_DATE ('2020-04-16')     "��������",
       TO_DATE ('2020-04-18') - SYSDATE     "���ϱ���"
  FROM DUAL;                                               -- �������ڴ� �ð��� ���ԵǼ� ����� ����� �ٸ�

--�ð��� ������ �� ��¥ ������ �ϼ��� ���ϴ� ���

SELECT SYSDATE,
       TRUNC (SYSDATE),
       TO_DATE ('2020-04-18') - TRUNC (SYSDATE)     "���ϱ���"
  FROM DUAL;                                               -- �������ڴ� �ð��� ����
-- trunc(��¥) : �ش� ��¥�� ������(�ð� ����)
-- round(��¥) : �ش� ��¥�� �ݿø��ؼ� ����(���� ����)

--�� ��¥ ������ ���� ��
--months_between() - �� ��¥ ������ �������� ������

SELECT MONTHS_BETWEEN ('2020-04-17', '2020-02-17'),
       MONTHS_BETWEEN ('2020-04-17', '2020-02-01'),
       MONTHS_BETWEEN ('2020-04-17', '2020-02-23')
  FROM DUAL;

--next_day()

/*
�־��� ��¥�� �������� ���ƿ��� ���� �ֱ� ������ ��¥�� ��ȯ�� �ִ� �Լ�
���ϸ� ��� ���ڸ� �Է��� ���� �ִ�.
1:�� 2:�� ... 7:��
*/

SELECT SYSDATE,
       NEXT_DAY (SYSDATE, '��'),
       NEXT_DAY (SYSDATE, 'ȭ����'),
       NEXT_DAY (SYSDATE, 1),
       NEXT_DAY ('2020-05-01', 4)
  FROM DUAL;

--last_day()
--�־��� ��¥�� ���� ���� ���� ������ ���� ������ִ� �Լ�

SELECT SYSDATE,
       LAST_DAY (SYSDATE),
       LAST_DAY ('2020-02-10'),
       LAST_DAY ('2020-08-05'),
       LAST_DAY ('2019-02-03')
  FROM DUAL;

-- trunc(��¥) : �ش� ��¥�� ������(�ð� ����)
-- round(��¥) : �ش� ��¥�� �ݿø��ؼ� ����(���� ����)
-- => �Ѵ� �ð��� ���ܵ�

SELECT SYSDATE, ROUND (SYSDATE), TRUNC (SYSDATE) FROM DUAL;

--����� �Ի��� 50�� ���� ��¥ ���ϱ�

SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       HIRE_DATE + 50     "50�� ��"
  FROM employees;

--�Ի��� 3���� ���� ��¥ ���ϱ�

SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       ADD_MONTHS (HIRE_DATE, 3)     "3���� ��"
  FROM employees;

--�����ϱ��� ���� �ϼ�

SELECT TO_DATE ('2020-08-19') - TRUNC (SYSDATE) || '��'    "�����ϱ���"
  FROM DUAL;

--�����ϱ��� ���� ������

SELECT    MONTHS_BETWEEN (LAST_DAY ('2020-08-19'), LAST_DAY (SYSDATE))
       || '����'    "�����ϱ���"
  FROM DUAL;

--[4] ����ȯ �Լ�

/*
<����Ŭ�� �ڷ���>
���� - char(����������), varchar2(�⺯ ������)
���� - number
��¥ - date

<����ȯ>
1) �ڵ� ����ȯ
2) ����� ����ȯ
to_char() - ����, ��¥�� ���ڷ�
to_number() - ���ڸ� ���ڷ�
to_date() - ���ڸ� ��¥��
*/

--�ڵ� ����ȯ

SELECT 1 + '2', 2 + '003' FROM DUAL;

-- =>���� ������ ���ڸ� �����ϸ� �ش� ���ڸ� ���ڷ� �ڵ�����ȯ�� �� ������

SELECT '004', 1 + TO_NUMBER ('2'), 2 + TO_NUMBER ('003') FROM DUAL;

--(1-1) to_char(��¥, ����) - ��¥�� ���ڷ� ��ȯ�Ѵ�

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'yyyy'),
       TO_CHAR (SYSDATE, 'mm'),
       TO_CHAR (SYSDATE, 'dd'),
       TO_CHAR (SYSDATE, 'd')     ����
  FROM DUAL;

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'year'),
       TO_CHAR (SYSDATE, 'mon'),
       TO_CHAR (SYSDATE, 'month'),
       TO_CHAR (SYSDATE, 'day'),                            -- ����(������,ȭ����,...)
       TO_CHAR (SYSDATE, 'dy'),                                -- ����(��, ȭ,...)
       TO_CHAR (SYSDATE, 'q'),                                           -- �б�
       TO_CHAR (SYSDATE, 'ddd')                                  -- 1�� �� ��ĥ°����
  FROM DUAL;

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'yyyy-mm-dd'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24:mi:ss'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss am'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss pm day')
  FROM DUAL;

--Ư�� ��¥���� �⵵�� ����, ���� ����, �ϸ� ����

SELECT EXTRACT (YEAR FROM SYSDATE)      �⵵,
       EXTRACT (MONTH FROM SYSDATE)     ��,
       EXTRACT (DAY FROM SYSDATE)       ��
  FROM DUAL;

--�ǽ�) STUDENT ���̺��� birthday Į���� �����Ͽ� ���� �� 3���� �л��� �̸��� birthday�� ��� 

SELECT name, birthday
  FROM student
 WHERE EXTRACT (MONTH FROM birthday) = 3;

SELECT name, birthday
  FROM student
 WHERE TO_CHAR (birthday, 'mm') = 3;

--(1-2) to_char(����, ����) - ���ڸ� ������ ����� ���ڷ� ��ȯ

/*
9 : �����ڸ��� �������� ä��
0 : �����ڸ��� 0���� ä��
*/

SELECT 1234,
       TO_CHAR (1234, '99999'),
       TO_CHAR (1234, '099999'),
       TO_CHAR (1234, '$99999'),
       TO_CHAR (1234, 'L99999'),
       TO_CHAR (1234.56, '9999.9'),
       TO_CHAR (1234, '$99,999'),
       TO_CHAR (123456789, '999,999,999'),
       TO_CHAR (1234.56, '9999')
  FROM DUAL;

--Professor ���̺��� �����Ͽ� 101�� �а� ������ �� �̸��� ������ ����Ͻÿ�. 
--�� ������ (pay*12)+bonus �� ����ϰ� õ ���� ���б�ȣ�� ǥ���Ͻÿ�

SELECT NAME �̸�, TO_CHAR ((pay * 12) + bonus, '99,999') ����
  FROM professor
 WHERE DEPTNO = 101;

--(2) to_date(����, ����) - ���ڸ� ��¥�� ��ȯ

SELECT TO_DATE ('2020-05-09'),
       TO_DATE ('2020-05-09', 'yyyy-mm-dd'),
       TO_DATE ('2020/05/09', 'yyyy/mm/dd'),
       TO_DATE ('2020-05-09 16:20:35', 'yyyy-mm-dd hh24:mi:ss')
  FROM DUAL;

SELECT *
  FROM professor
 WHERE hiredate >= '1995-01-01';

SELECT '2020-04-03' - '2020-01-01' FROM DUAL;                                                                                                                                                                                     --error

SELECT TO_DATE ('2020-04-03') - TO_DATE ('2020-01-01') FROM DUAL;

--2020-03-07 ~ 2020-04-16������ ������ ��ȸ

SELECT *
  FROM pd
 WHERE regdate BETWEEN '2020-03-07'
                   AND TO_DATE ('2020-04-16 23:59:59',
                                'yyyy-mm-dd hh24:mi:ss');

--������� �� �ð��� �������� ��ȸ

SELECT PDNAME, PRICE, REGDATE, (SYSDATE - regdate) * 24 ����ð� FROM pd;


--2020-04-20������

--(3) to_number(����) - ���ڸ� ���ڷ� ��ȯ

SELECT '10'                       AS ����,
       10                         AS ����1,
       TO_NUMBER ('10')           AS ����2,
       TO_NUMBER ('003') + 20     AS ����3,
       '005' + 30                 AS ����4
  FROM DUAL;

--[�ǽ�]Professor ���̺��� ����Ͽ� 1990�� ������ �Ի��� ������� �Ի���, 
--���� ������ 10% �λ� �� ������ ����Ͻÿ�.      
--������ �󿩱�(bonus)�� ������ (pay*12)�� ����ϰ� ������ �λ� �� ������ 
--õ ���� ���� ��ȣ�� �߰��Ͽ� ����Ͻÿ�. 

SELECT NAME,
       HIREDATE,
       TO_CHAR (PAY * 12, '9,999')           ����,
       TO_CHAR (pay * 1.1 * 12, '9,999')     "�λ� �� ����"
  FROM professor;

--[5]�Ϲ� �Լ�
--nvl(�÷�, ġȯ�� ��) - �ش� �÷��� null�̸� ġȯ�� ������ �ٲٴ� �Լ�

SELECT name,
       bonus,
       NVL (bonus, 0),
       hpage,
       NVL (hpage, 'Ȩ������ ����')
  FROM professor;

--Professor ���̺��� 101�� �а� �������� �̸��� �޿�, bonus, ������ ����Ͻÿ�. 
--��, ������ (pay*12+bonus)�� ��� �ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�. 

SELECT NAME                                 �̸�,
       pay                                  �޿�,
       NVL (BONUS, 0)                       bonus,
       NVL (PAY * 12 + bonus, PAY * 12)     ����
  FROM professor;

--nvl2(col1, col2, col3) : col1�� ���� null�� �ƴϸ� col2��, null�̸� col3�� ���

--nvl2 �̿�
--Professor ���̺��� 101�� �а� �������� �̸��� �޿�, bonus, ������ ����Ͻÿ�. 
--��, ������ (pay*12+bonus)�� ��� �ϰ� bonus�� ���� ������ 0���� ����Ͻÿ�. 

SELECT NAME                                         �̸�,
       pay                                          �޿�,
       NVL (BONUS, 0)                               bonus,
       NVL2 (bonus, PAY * 12 + bonus, PAY * 12)     ����
  FROM professor;

--employees
--�̸�(first_name - last_name), �Ի���, salary(�⺻��), �����ۼ�Ʈ(commission_pct),
-- ����(�⺻��+�⺻��*�����ۼ�Ʈ)*12(�����ۼ�Ʈ�� null�̸� ������ �⺻��*12)

SELECT FIRST_NAME || '-' || LAST_NAME                            �̸�,
       HIRE_DATE                                                 �Ի���,
       SALARY                                                    �⺻��,
       NVL (COMMISSION_PCT, 0)                                   �����ۼ�Ʈ,
       NVL (salary * (1 + commission_pct) * 12, salary * 12)     ����
  FROM employees;

SELECT FIRST_NAME || '-' || LAST_NAME    �̸�,
       HIRE_DATE                         �Ի���,
       SALARY                            �⺻��,
       NVL (COMMISSION_PCT, 0)           �����ۼ�Ʈ,
       TO_CHAR (
           NVL2 (commission_pct,
                 salary * (1 + commission_pct) * 12,
                 salary * 12),
           '$999,999')                   ����
  FROM employees;

--decode() �Լ� : if���� ����ϴ� �Լ�

/*
    decode(A, B, ��, ����)
    => A�� B�� ������ ���� �ϰ�, �׷��� ������ ������ ó���Ѵ�.
*/
--student���� grade�� 1�̸� 1�г�, 2�̸� 2�г�, 3�̸� 3�г�, 4�̸� 4�г��� ���

SELECT grade,
       DECODE (grade,
               1, '1�г�',
               2, '2�г�',
               3, '3�г�',
               4, '4�г�')    "�г�"
  FROM student;

--Professor ���̺��� ������, �а���ȣ, �а����� ����ϵ� deptno�� 101�� �� ������ 
--��ǻ�� ���а��� ����ϰ� 101���� �ƴ� �������� �а��� �ƹ��� �� ������� ������. 

SELECT NAME, DEPTNO, DECODE (deptno, 101, '��ǻ�� ���а�') "�а���"
  FROM professor;

-- Professor ���̺��� ������, �а���ȣ , �а����� ����ϵ� 
--deptno�� 101���� ������ ��ǻ�� ���а��� ����ϰ� 101 ���� �ƴ� �������� �а��� ����Ÿ�а� ���� ����ϼ���. 

SELECT name,
       deptno,
       DECODE (deptno, 101, '��ǻ�� ���а�', '��Ÿ�а�')    "�а���"
  FROM professor;

-- Professor ���̺��� ������, �а����� ����ϵ� deptno�� 101���̸� ����ǻ�� ���а���, 
--102���̸� ����Ƽ�̵�� ���а� ��, 103���̸� ������Ʈ���� ���а���, ���� ���� ����Ÿ�а����� ����ϼ���. 

SELECT name,
       deptno,
       DECODE (deptno,
               101, '��ǻ�� ���а�',
               102, '��Ƽ�̵�� ���а�',
               103, '����Ʈ���� ���а�',
               '��Ÿ�а�')    "�а���"
  FROM professor;

-- Professor ���̺��� ������, �μ���ȣ �� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� ������ ���� �ĺ������ ����ϼ���. �������� null �� ���. 

SELECT NAME,
       DEPTNO,
       DECODE (deptno,
               101, DECODE (name, '������', '���� ���� �ĺ�'))    "���"
  FROM professor;

--Professor ���̺��� ������, �μ���ȣ �� ����ϰ�, deptno�� 101���� �μ� �߿��� 
--�̸��� �������� �������� ��� ���� �����±��� �ĺ������ ����ϼ���. 101�� �а��� ������ ���� �ܿ��� 
--��� ���� ���ĺ��ƴԡ��� ����ϰ� 101�� ���� �� �ƴ� ���� ������ ������ �ǵ��� 

SELECT NAME,
       DEPTNO,
       DECODE (
           deptno,
           101, DECODE (name,
                        '������', '���� ���� �ĺ�',
                        '�ĺ��ƴ�'))    "���"
  FROM professor;

--���� ���

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'd'),
       DECODE (TO_CHAR (SYSDATE, 'd'),
               '1', '��',
               '2', '��',
               '3', 'ȭ',
               '4', '��',
               '5', '��',
               '6', '��',
               '7', '��')    "����"
  FROM DUAL;

--Student ���̺��� ����Ͽ� �� 1����(deptno1)�� 101���� �а� �л����� �� ��(name)�� �ֹι�ȣ(jumin), 
--������ ����ϵ� ������ �ֹι�ȣ Į���� �̿� �Ͽ� 7��° ���ڰ� 1�� ��� �����ڡ�, 2�� ��� �����ڡ��� ����ϼ��� 

SELECT name,
       jumin,
       DECODE (SUBSTR (jumin, 7, 1),  '1', '����',  '2', '����')    ����
  FROM student
 WHERE deptno1 = 101;

--Student ���̺��� �� 1����(deptno1)�� 101���� �л����� �̸�(name)�� ��ȭ��ȣ(tel), �������� 
--����ϼ���. �������� ������ȣ�� 02�� ����, 031�� ���, 051�� �λ�,052�� ���, 055�� �泲���� ����ϼ��� 

SELECT name,
       tel,
       DECODE (SUBSTR (tel, 1, INSTR (tel, ')') - 1),
               '02', '����',
               '031', '���',
               '051', '�λ�',
               '052', '���',
               '055', '�泲')    "������"
  FROM student
 WHERE deptno1 = 101;

--case ǥ���� : if���� ����ϴ� �Լ�, ������ �������� ���� ���� ��� ����

/*
[1]���ϰ� �񱳽� (=�� �񱳵Ǵ� ���)
    case ���� when ���1 then ���1
            when ���2 then ���2
            else ���3
    end "��Ī"
[2]������ �񱳽�
    case when ����1 then ���1
        when ����2 then ���2
        else ���3
    end "��Ī"
*/
--�г� ����ϱ�

SELECT name,
       grade,
       CASE grade
           WHEN 1 THEN '1�г�'
           WHEN 2 THEN '2�г�'
           WHEN 3 THEN '3�г�'
           WHEN 4 THEN '4�г�'
       END                   "�г�1",
       CASE grade
           WHEN 1 THEN '1�г�'
           WHEN 2 THEN '2�г�'
           WHEN 3 THEN '3�г�'
           ELSE '4�г�'
       END                   "�г�2",
       DECODE (grade,
               1, '1�г�',
               2, '2�г�',
               3, '3�г�',
               '4�г�')    "�г�3"
  FROM student;

--professor���� pay�� 400�ʰ�, 300~400����, 300�̸����� ����

SELECT name,
       pay,
       CASE
           WHEN pay > 400 THEN '400�ʰ�'
           WHEN pay BETWEEN 300 AND 400 THEN '300~400����'
           WHEN pay < 300 THEN '300�̸�'
       END    "�޿� ����"
  FROM professor;

--������ȣ, ������

SELECT name,
       tel,
       SUBSTR (tel, 1, INSTR (tel, ')') - 1)    "������ȣ",
       CASE SUBSTR (tel, 1, INSTR (tel, ')') - 1)
           WHEN '02' THEN '����'
           WHEN '031' THEN '��⵵'
           WHEN '051' THEN '�λ�'
           WHEN '052' THEN '���'
           WHEN '053' THEN '�뱸'
           WHEN '055' THEN '�泲'
       END                                      "����"
  FROM student;

-- Student ���̺��� JUMIN Į���� �����Ͽ� �л����� �̸��� �¾ ��, �б⸦ �� ���ϼ���. �¾ ���� 
--01~03���� 1/4�б�, 04~06���� 2/4�б�, 07~09���� 3/4 �б�, 10~12���� 4/4�б�� ����ϼ���

SELECT name,
       jumin,
       SUBSTR (jumin, 3, 2)    "�¾ ��",
       CASE
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4�б�'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4�б�'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '06' AND '09' THEN '3/4�б�'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4�б�'
       END                     �б�
  FROM student;

--total�� �̿��ؼ� ���� ���ϱ�
--90�̻� A, 80�̻� B, 70�̻� C, 60�̻� D, ������ F

SELECT studno,
       total,
       TRUNC (total / 10),
       TRUNC (total, -1),
       CASE
           WHEN total >= 90 THEN 'A'
           WHEN total >= 80 THEN 'B'
           WHEN total >= 70 THEN 'C'
           WHEN total >= 60 THEN 'D'
           ELSE 'F'
       END             ����1,
       DECODE (TRUNC (total / 10),
               10, 'A',
               9, 'A',
               8, 'B',
               7, 'C',
               6, 'D',
               'F')    ����2,
       CASE TRUNC (total, -1)
           WHEN 100 THEN 'A'
           WHEN 90 THEN 'A'
           WHEN 80 THEN 'B'
           WHEN 70 THEN 'C'
           WHEN 60 THEN 'D'
           ELSE 'F'
       END             ����3
  FROM EXAM_01;

--����, gogak

SELECT gno,
       gname,
       jumin,
       point,
       CASE SUBSTR (jumin, 7, 1)
           WHEN '1' THEN '��'
           WHEN '3' THEN '��'
           ELSE '��'
       END                                                                       ����,
       CASE WHEN SUBSTR (jumin, 7, 1) IN ('1', '3') THEN '��' ELSE '��' END    ����2
  FROM gogak;

--���̱��ϱ�

  SELECT gno,
         gname,
         jumin,
         point,
         TO_CHAR (SYSDATE, 'yyyy')    ���翬��,
           TO_CHAR (SYSDATE, 'yyyy')
         - (  SUBSTR (jumin, 1, 2)
            + CASE
                  WHEN SUBSTR (jumin, 7, 1) IN ('1', '2') THEN 1900
                  ELSE 2000
              END)
         + 1                          ����
    FROM gogak
ORDER BY ����;

-- �ų� ������ ���޳�, ��,���ϰ�� �� �ݿ��Ͽ� ����
-- ���޳�¥ ���ϱ� ���糯¥, 5��, 10��
--[1] ������ ����

SELECT SYSDATE,
       LAST_DAY (SYSDATE),
       TO_CHAR (LAST_DAY (SYSDATE), 'd'),
       DECODE (TO_CHAR (LAST_DAY (SYSDATE), 'd'),
               '1', '��',
               '2', '��',
               '3', '��',
               '4', '��',
               '5', '��',
               '6', '��',
               '7', '��')    ����
  FROM DUAL;

--[2] ������ ��~, ��~ �̸�

SELECT SYSDATE,
       TO_CHAR (LAST_DAY (SYSDATE), 'd'),
       DECODE (TO_CHAR (LAST_DAY (SYSDATE), 'd'),
               '7', LAST_DAY (SYSDATE) - 1,
               '1', LAST_DAY (SYSDATE) - 2,
               LAST_DAY (SYSDATE))    ���޳�
  FROM DUAL;

SELECT '2020-05-05',
       TO_CHAR (LAST_DAY ('2020-05-05'), 'd'),
       DECODE (TO_CHAR (LAST_DAY ('2020-05-05'), 'd'),
               '7', LAST_DAY ('2020-05-05') - 1,
               '1', LAST_DAY ('2020-05-05') - 2,
               LAST_DAY ('2020-05-05'))    ���޳�
  FROM DUAL;

SELECT '2020-10-24',
       TO_CHAR (LAST_DAY ('2020-10-24'), 'dy')    ����,
       DECODE (TO_CHAR (LAST_DAY ('2020-10-24'), 'd'),
               '7', LAST_DAY ('2020-10-24') - 1,
               '1', LAST_DAY ('2020-10-24') - 2,
               LAST_DAY ('2020-10-24'))           ���޳�
  FROM DUAL;

--�ǽ� ? Professor ���̺��� ��ȸ�Ͽ� ������ �޿��׼�(pay)�� ������ �� 200 �̸��� 4��, 
--201~300�� 3��, 301~400�� 2��, 401 �̻��� 1 ������ ǥ���Ͽ� ������ ��ȣ(profno), 
--�����̸�(name), �޿�(pay), ����� ����ϼ���. ��, pay Į���� ������������ �����ϼ���. 

  SELECT profno,
         name,
         pay,
         CASE
             WHEN pay <= 200 THEN '4��'
             WHEN pay BETWEEN 201 AND 300 THEN '3��'
             WHEN pay BETWEEN 301 AND 400 THEN '2��'
             ELSE '1��'
         END    ��
    FROM professor
ORDER BY pay DESC;

--emp ���̺��� sal �� 2000 ���� ũ�� ���ʽ��� 1000, 1000���� ũ�� 500, 
--�������� 0 ���� ǥ���ϼ��� 

SELECT ename,
       sal,
       CASE WHEN sal > 2000 THEN 1000 WHEN sal > 1000 THEN 500 ELSE 0 END    ���ʽ�
  FROM emp;