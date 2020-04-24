/* Formatted on 2020/04/24 ���� 6:26:26 (QP5 v5.360) */
--6��_insert.sql
--[2020-04-24 �ݿ���]

/*
<1. insert��> - �����͸� �Է��ϴ� DML
[1] ������ �Է��ϱ�
insert into ���̺��(Į��1,Į��2,...) velues(��1,��2,...)
*/
--��1) dept2 ���̺� �Ʒ��� ���ο� �μ� ������ �Է��Ͻÿ� ? 
--�μ���ȣ : 9000, �μ���: Ư��1�� ? 
--�����μ� : 1006 (������), ���� : �ӽ����� 

SELECT * FROM dept2;

INSERT INTO dept2 (DCODE,
                   DNAME,
                   PDEPT,
                   AREA)
     VALUES (9000,
             'Ư��1��',
             1006,
             '�ӽ�����');

INSERT INTO dept2 (DCODE,
                   DNAME,
                   AREA,
                   PDEPT)
     VALUES (9001,
             'Ư��2��',
             '�ӽ�����',
             1006);

--��� �÷��� �����͸� �Է��ϴ� ��� => �÷��� ���� ����

INSERT INTO dept2
     VALUES (9002,
             'Ư��3��',
             1006,
             '�ӽ�����');

 -- �Ϻ� �÷��� �Է��ϴ� ��� - not null�� �÷��� �ݵ�� ���� �Է��ؾ� ��

DESC dept2;

INSERT INTO dept2 (DCODE, DNAME)
     VALUES (9004, 'Ư��4��');

INSERT INTO dept2 (DCODE, PDEPT)
     VALUES (9004, 1006);

     -- ORA-01400: cannot insert NULL into ("HR"."DEPT2"."DNAME")

--null �Է��ϱ�

/*
1) �����͸� �Է����� ������ null�� �Էµ�
2) ���� null�� �Է��ص� null�� �Էµ�
*/

SELECT * FROM dept2;

INSERT INTO dept2 (dcode, dname, pdept)
     VALUES (9005, 'Ư��5��', NULL);

-- ��¥ ������ �Է��ϱ�

/*
? �Ʒ� ������ professor ���̺� �Է��Ͻÿ� ? 
������ȣ : 5001, �����̸�: �輳�� ? 
ID : kimsh, Position : ������ ? 
Pay : 510, �Ի��� : 2013�� 2�� 19�� 
*/

SELECT * FROM professor;

INSERT INTO professor
     VALUES (5001,
             '�輳��',
             'kimsh',
             '������',
             510,
             '2013-02-19',
             NULL,
             NULL,
             NULL,
             NULL);

--[2] ���� �� �Է��ϱ�

/*
insert into ���̺��()
select��

=> select���� �÷��� ������ ������ Ÿ���� ��ġ�ؾ� �Է� ������
*/

  SELECT *
    FROM pd
ORDER BY no DESC;

SELECT * FROM product;

INSERT INTO pd (no,
                pdname,
                price,
                regdate)
    SELECT p_code,
           p_name,
           p_price,
           SYSDATE
      FROM product
     WHERE p_code IN (102, 103, 104);

--[3] ���̺��� �����ϸ鼭 ������ �Է��ϱ�

/*
creat table �ű����̺��
as
select �����÷�, �����÷�2, ... from ���� ���̺��;

- �ű� ���̺��� ����� ���ÿ� �ٸ� ���̺��� select�� �÷��� ��� �����͸� insert��Ŵ
- select���� ���̺�� �÷��� ���������� �������� �ʱ� ������ �ű� ���̺� ���� 
  ���̺�� �÷� ���� ������ �����ؾ� ��
  * pk(primary key)���� �������� ����
*/

CREATE TABLE professor2
AS
    SELECT * FROM professor;

SELECT * FROM professor2;

--employees, departments ���̺��� ������ ����� imsi_tbl�� ����鼭 �Է�

CREATE TABLE imsi_tbl
AS
    SELECT e.EMPLOYEE_ID,
           e.FIRST_NAME || '-' || e.LAST_NAME    name,
           e.HIRE_DATE,
           NVL2 (e.COMMISSION_PCT,
                 e.SALARY + e.SALARY * e.COMMISSION_PCT,
                 salary)                         pay,
           e.DEPARTMENT_ID,
           d.DEPARTMENT_NAME,
           d.LOCATION_ID,
           d.MANAGER_ID
      FROM employees  e
           JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT * FROM imsi_tbl;

/*
=> insert ���� �÷� ����Ʈ�� ���� ���¿��� select�� �÷� ����Ʈ�� �Լ��� ����ƴٸ�
  ��Ī�� �Ἥ insert�Ǵ� �������� �÷����� �����ؾ� ��
  �׷��� ������ ����
*/

CREATE TABLE imsi_tbl2
(
    emp_id,
    name,
    pay,
    deptno,
    dname
)
AS
    SELECT e.employee_id,
           e.first_name || ' ' || e.last_name,
           NVL2 (e.commission_pct,
                 e.salary + e.salary * e.commission_pct,
                 e.salary),
           d.department_id,
           d.department_name
      FROM employees  e
           LEFT JOIN departments d ON e.department_id = d.department_id;

/*
=> create table���� �÷����� �����ϸ� �ű� ���̺� �÷� ����Ʈ�� ���ǵǸ鼭
  select ���� ���� �ʿ��� �����Ͱ� insert��
*/

SELECT * FROM imsi_tbl2;

/*
<update> 
- ���� �����͸� �ٸ� �����ͷ� ������ �� ���

update ���̺��
set �÷�1 = value1, �÷�2=value2, ...
where ����;
*/

--��1) Professor ���̺��� ������ �������� �������� bonus�� 100���� ���� �λ��Ͻÿ�.

SELECT *
  FROM professor
 WHERE position = '������';

UPDATE professor
   SET bonus = 100
 WHERE position = '������';

--��2) student ���̺���  4�г� '�����' �л��� 2����(deptno2) �� 101�� �����Ͻÿ�. 

UPDATE student
   SET deptno2 = 101
 WHERE grade = 4 AND name = '�����';

SELECT *
  FROM student
 WHERE grade = 4 AND name = '�����';

--��3) Professor ���̺���  ����ö������ ���ް� ������ ������ ���� ������ �� ���� �޿��� 
--250������ �� �Ǵ� �������� �޿��� 15% �λ��Ͻÿ�.

SELECT *
  FROM professor
 WHERE position = (SELECT position
                     FROM professor
                    WHERE name = '����ö');

UPDATE (SELECT *
          FROM professor
         WHERE position = (SELECT position
                             FROM professor
                            WHERE name = '����ö'))
   SET pay = pay * (1.15)
 WHERE pay < 250;

UPDATE professor
   SET pay = pay * (1.15)
 WHERE     pay < 250
       AND position = (SELECT position
                         FROM professor
                        WHERE name = '����ö');

--���� ���� update - ���������� �̿��� update

/*
���������� ����ϸ� �� ���� update ������� ���� ���� �÷��� ������ �� �ִ�.
���� �÷��� ���������� ����� update�ϸ� �ȴ�.

���߰��� update�� �ϱ� ���ؼ��� �⺻���� update���� ���� ����ϰ�
subquery�� ������ �����͸� setting�Ϸ��� �÷��� �����Ͱ����� �����
*/

--1) EMP01 ���̺��� �����ȣ�� 7844�� ����� �μ���ȣ�� ����(JOB)��          
--�����ȣ�� 7782�� ����� ���� ������ ���� �μ��� �����϶�  

SELECT job, deptno
  FROM emp
 WHERE empno = 7782;

--MANAGER	10

SELECT *
  FROM emp
 WHERE empno = 7844;

/*
update emp
set job='MANAGER', deptno=10
where empno=7844;
*/

--cf. ���� �÷� ��������
--�г⺰ �ִ�Ű�� ���� �л��� ������ ��ȸ

SELECT *
  FROM student
 WHERE (grade, height) IN (  SELECT grade, MAX (height)
                               FROM student
                           GROUP BY grade);

--

UPDATE emp
   SET (job, deptno) =
           (SELECT job, deptno
              FROM emp
             WHERE empno = 7782)
 WHERE empno = 7844;

--[3] exists�� �̿��� ���߰��� update

/*
- ���������� �÷����� �����ϴ� ���θ� üũ
- ���翩�θ� üũ�ϱ� ������ �����ϸ� true, �������� ������ false�� ����
- true�� ������Ʈ, false�� ������Ʈ �������� ����
*/

--������ �ڵ尡 panmae ���̺� �ִٸ� �� �ڵ�� update�ϱ�

SELECT * FROM product;

SELECT * FROM panmae;

SELECT *
  FROM panmae a
 WHERE EXISTS
           (SELECT 1
              FROM product b
             WHERE a.P_CODE = b.P_CODE AND del_yn = 'Y');

--

UPDATE panmae a
   SET p_code =
           (SELECT P_CODE_NEW
              FROM product b
             WHERE a.P_CODE = b.P_CODE)
 WHERE EXISTS
           (SELECT 1
              FROM product b
             WHERE a.P_CODE = b.P_CODE AND del_yn = 'Y');

--emp���� comm�� ���������� 100�λ��ϰ�,
--sal�� job�� CLERK�̸� 2��, MANAGER�̸� 3��, �������� 4��� �����Ͻÿ�

SELECT * FROM emp;

/*
UPDATE emp
   SET comm = comm + 100,
       sal =
           CASE job
               WHEN 'CLERK' THEN sal * 2
               WHEN 'MANAGER' THEN sal * 3
               ELSE sal * 4
           END;
*/


--update �߰�
--1) employees ���� �����ȣ�� 100�� ������ job_id �� IT_PROG �� ����

UPDATE employees
   SET job_id = 'IT_PROG'
 WHERE EMPLOYEE_ID = 100;

--2) employees ���� �����ȣ�� 100�� ������ job_id �� �����ȣ�� 101�� job_id �� ����

UPDATE employees
   SET job_id =
           (SELECT job_id
              FROM employees
             WHERE EMPLOYEE_ID = 101)
 WHERE EMPLOYEE_ID = 100;

SELECT * FROM employees;

/*
<[3] delete��>
- �����͸� �����ϴ� ����

delete from ���̺�
where ����
*/

--��1) dept2 ���̺��� �μ���ȣ(dcode)�� 9000������ 9100�� ������ ������� �����Ͻÿ� 

SELECT *
  FROM dept2
 WHERE dcode BETWEEN 9000 AND 9100;

DELETE FROM dept2
      WHERE dcode BETWEEN 9000 AND 9100;

--delete������ �������� �̿�
--������ ��������
--departments���� 10�� �μ��� �μ����� employees���� ����

SELECT *
  FROM employees
 WHERE EMPLOYEE_ID = 200;

SELECT *
  FROM departments
 WHERE DEPARTMENT_ID = 10;

SELECT *
  FROM employees
 WHERE EMPLOYEE_ID = (SELECT MANAGER_ID
                        FROM departments
                       WHERE DEPARTMENT_ID = 10);

DELETE FROM employees e
      WHERE e.EMPLOYEE_ID = (SELECT MANAGER_ID
                               FROM departments d
                              WHERE d.DEPARTMENT_ID = 10);

-- �θ��ڽİ� ���������� �ɷ��վ ���� ����
-- ���� ���� ���� ����

CREATE TABLE new_employees
AS
    SELECT * FROM employees;

SELECT * FROM new_employees;

DELETE FROM new_employees e
      WHERE e.EMPLOYEE_ID = (SELECT MANAGER_ID
                               FROM departments d
                              WHERE d.DEPARTMENT_ID = 10);

-- departments ���� location_id �� 1700 �� ������� employees ���� ����

DELETE FROM new_employees
      WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                FROM departments
                               WHERE location_id = 1700);

DELETE FROM
    new_employees e
      WHERE EXISTS
                (SELECT 1
                   FROM departments d
                  WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID
                        AND location_id = 1700);

SELECT * FROM new_employees;

-- �����÷� ��������
--employees���� ������ �ִ� �޿��� �޴� ��� ����

DELETE new_employees
 WHERE (JOB_ID, SALARY) IN (  SELECT JOB_ID, MAX (SALARY)
                                FROM new_employees
                            GROUP BY JOB_ID);

-- ������� ��������
-- new_employees ���� �ڽ��� job_id�� ��� �޿����� ���� �޴� ��� ����

SELECT *
  FROM new_employees a
 WHERE salary > (  SELECT AVG (NVL (SALARY, 0))
                     FROM new_employees b
                    WHERE a.JOB_ID = b.JOB_ID
                 GROUP BY JOB_ID);

DELETE FROM new_employees a
      WHERE salary > (  SELECT AVG (NVL (SALARY, 0))
                          FROM new_employees b
                         WHERE a.JOB_ID = b.JOB_ID
                      GROUP BY JOB_ID);

-- commit, rollback

--insert all�� �̿��� ���� ���̺� ���� �� �Է��ϱ�
-- ��1) �ٸ� ���̺� �Ѳ����� ������ �Է��ϱ� 

INSERT ALL
  INTO p_01
VALUES (1, 'AA')
  INTO p_02
VALUES (2, 'BB')
    SELECT * FROM DUAL;

SELECT * FROM p_01;

SELECT * FROM p_02;

-- ��2) �ٸ� ���̺��� �����͸� �����ͼ� �Է��ϱ� ? 
--Professor ���̺��� ������ȣ�� 1000������ 1999�������� ������ ��ȣ�� �����̸��� p_01 ���̺� �Է��ϰ�, 
--������ȣ�� 2000������ 2999�������� ������ ��ȣ�� �����̸��� p_02 ���̺� �Է��Ͻÿ�.

  INSERT ALL
    WHEN profno BETWEEN 1000 AND 1999
    THEN
        INTO p_01
          VALUES (profno, name)
    WHEN profno BETWEEN 2000 AND 2999
    THEN
        INTO p_02
          VALUES (profno, name)
    SELECT profno, name FROM professor;

SELECT * FROM p_01;

SELECT * FROM p_02;

--��3) �ٸ� ���̺� ���ÿ� ���� ������ �Է��ϱ� ? 
--Professor ���̺��� ������ȣ�� 3000������ 3999�������� �������� ��ȣ�� �����̸��� 
--p_01 ���̺�� p_02 ���̺� ���ÿ� �Է��Ͻÿ�. 

INSERT ALL
  INTO p_01
VALUES (profno, name)
  INTO p_02
VALUES (profno, name)
    SELECT profno, name
      FROM professor
     WHERE profno BETWEEN 3000 AND 3999;

SELECT * FROM p_01;

SELECT * FROM p_02;

-- dept => dept01 ���̺� ����� ?
-- emp => emp01 ���̺� ����� ? 

--insert ? 
--1) dept01, emp01 ���̺� ������ �Է��ϱ� ? 
--dept01 ���̺��� ��� Į�� �Է�, emp01 ���̺��� �Ϻ� Į���� �Է� 
 
create table dept01
as
select * from dept;

create table emp01
(EMPNO, ENAME, SAL, job, MGR, HIREDATE, COMM, DEPTNO )
as
select EMPNO, ENAME, SAL, job, MGR, HIREDATE, COMM, DEPTNO from emp;

desc emp01;

--update ? 
--1) DEPT01 ���̺��� �μ���ȣ�� 30�� �μ��� ��ġ(LOC)�� '�λ�'���� ���� ? 
update dept01
set loc ='�λ�'
where DEPTNO =30;
--2) DEPT01 ���̺��� ������ ��� '����'�� ���� ? 
update dept01
set LOC = '����';
--3) emp01 ���̺��� job�� 'MANAGER' �� ����� �޿�(sal)�� 10% �λ� 
update emp01
set sal = sal*(1.1)
where job= 'MANAGER';


--���������� �̿��� update ? 
--1) �����ȣ�� 7934�� ����� �޿���, ������ �����ȣ�� 7654�� ����� ������ �޿� �� ����(emp01 ���̺� �̿�) 
update emp01
set (SAL, JOB) = (select SAL, JOB from emp01 where EMPNO = 7654)
where EMPNO = 7934;

--�ٸ� ���̺��� ������ UPDATE ? 
--1) DEPT01 ���̺��� �μ��̸��� SALES�� �����͸� ã�� �� �μ��� �ش�Ǵ� 
--EMP01 ���̺��� �������(JOB)�� 'SALSEMAN'���� ���� ? 
update emp01
set job = 'SALSEMAN'
where DEPTNO = (select deptno from dept01 where dname='SALES');

--2) DEPT01 ���̺��� ��ġ(loc)��  'DALLAS'�� �����͸� ã�� �� �μ��� �ش��ϴ� 
--EMP01 ���̺��� ������� ����(JOB)�� 'ANALYST'�� ����
update emp01
set job = 'ANALYST'
where DEPTNO = (select deptno from dept01 where loc='DALLAS');


-- DELETE ? 
--1) EMP01���̺��� 7782�� �����ȣ�� ��������� ��� ���� ? 
delete from emp01
where EMPNO = 7782;
--2) EMP01���̺��� ����(JOB)�� 'CLERK'�� ������� ������ ���� ? 
delete from emp01
where job='CLERK';

--3) EMP01���̺��� ��� ������ ���� �� rollback 
delete from emp01;

--���������� �̿��� �������� ���� ? 
--1) 'ACCOUNTING'�μ��� ���� �μ��ڵ带 DEPT01���̺��� �˻��� ��   
--�ش� �μ��ڵ带 ���� ����� ������ EMP01���̺��� ���� ? 
delete from emp01
where DEPTNO = (select deptno from dept01 where dname='ACCOUNTING');

--2) DEPT01���̺��� �μ��� ��ġ�� 'NEW YORK'�� �μ��� ã��   
--EMP01���̺��� �� �μ��� �ش��ϴ� ����� ���� 
delete from emp01
where DEPTNO = (select deptno from dept01 where loc='NEW YORK');