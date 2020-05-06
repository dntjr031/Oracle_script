/* Formatted on 2020/05/06 ���� 10:44:43 (QP5 v5.360) */
--1��_select�⺻.sql
--[2020-04-14 ȭ]

--���� �ּ�

/*
������ �ּ�
*/

SELECT * FROM tab;                   -- �ش� ������ ���̺� ����� ��ȸ

DESC countries;                -- �ش� ���̺� � �÷��� �ִ� �� ���̺� ������ Ȯ���� �� �ִ�.

/*
sqlplus �� ���� �ش� ������ �����ϴ� ���
[1] sqlplus ���̵�/��й�ȣ
��) sqlplus hr /hr123
sqlplus sys/a123$ as sysdba
sqlplus / as sysdba

[2] sqlplus �� ��
conn ���̵�/��й�ȣ
��) conn hr/hr123
conn sys/a123$ as sysdba
conn / as sysdba

* ����Ŭ ��ġ �� ����� sample ������ ������ lock�� Ǯ�� ����ؾ� ��
sys�������� ������ ��

- hr �������� lockǮ��
alter user hr account unlock;

- hr ������ ��й�ȣ �����ϱ�
alter user hr identified by hr123;
=> hr ������ ��й�ȣ�� hr123���� �����Ѵ�

* sqlplus���� ������ ������ Ȯ���Ϸ���
show user
*/
--table ���� ���� Ȯ��

SELECT * FROM employees;                         -- �ڽ�

SELECT * FROM jobs;                    -- �θ�

SELECT * FROM employees;                         -- �ڽ�

SELECT * FROM departments;                           --�θ�

SELECT * FROM locations;                         --  �θ�

SELECT * FROM departments;                           -- �ڽ�

SELECT * FROM locations;                         -- �ڽ�

SELECT * FROM countries;                         --�θ�

SELECT * FROM countries;                         -- �ڽ�

SELECT * FROM regions;                       --�θ�

SELECT * FROM JOB_HISTORY;                           -- �ڽ�

SELECT * FROM employees;                         -- �θ�

SELECT * FROM jobs;                    --�θ�

SELECT * FROM JOB_HISTORY;                          --�ڽ�

SELECT * FROM JOB_HISTORY;                          --�ڽ�

SELECT * FROM departments;                           --�θ�

-------------------------20.04.16�����

--������ ��ȸ�ϱ�
-- SELECT �÷���1,�÷���2 FROM ���̺��;

--1. ��� �÷� ��ȸ�ϱ�
-- SELECT * FROM ���̺��;

--EMPLOYEES ���̺��� ��� �÷� ��ȸ�ϱ�

SELECT * FROM EMPLOYEES;                         -- ��ҹ��� ���� ����
-- ��, �����ʹ� ��ҹ��� ������

--2. �Ϻ� �÷��� ��ȸ�ϱ�
-- SELECT �÷�1, �÷�2 FROM ���̺��;

--employees ���̺��� ������̵�, �̸�, �Ի���, �޿� ��ȸ�ϱ�

SELECT employee_id, first_name, last_name, hire_date, salary FROM employees;

--3. ǥ������ ����Ͽ� ����ϱ�

SELECT first_name, '�� ȯ���մϴ�.' FROM employees;

/*
ǥ����(literal ���, ����)
- �÷� �̸� �ܿ� ����ϱ⸦ ���ϴ� ������ �ǹ�
SELECT ���� �ڿ� '(Ȭ����ǥ)�� ��� ���
*/

--4. �÷� ��Ī ����Ͽ� ����ϱ�

/*
�÷��� �ڿ� as "��Ī" (�����̳� �Ϻ� Ư����ȣ�� ������ �ݵ�� ""�� ������� ��
�Ǵ� �÷��� �ڿ� "��Ī"
�Ǵ� �÷��� �ڿ� ��Ī

- ���� ���̺��� �÷����� ����Ǵ� ���� �ƴ϶� ��µɶ� �ӽ÷� �ٲپ �����ִ� ��
*/

SELECT first_name, '�� ȯ���մϴ�' AS "�λ縻" FROM EMPLOYEES;

SELECT employee_id      AS "������̵�",
       first_name       �̸�,
       last_name        ��,
       phone_number     "��ȭ��ȣ",
       salary           "�޿�!"
  FROM employees;

-- 5. distinct �ߺ��� ���� �����ϰ� ����ϱ�

SELECT * FROM emp;

SELECT deptno FROM emp;

SELECT DISTINCT deptno
  FROM emp;                                 -- �ߺ��� �����Ͱ� ���ŵ�

  SELECT deptno, job
    FROM emp
ORDER BY deptno, job;

  SELECT DISTINCT deptno, job
    FROM emp
ORDER BY deptno, job;

-- distinct Ű����� 1���� �÷����� ��� ��� �÷��� �����

--6. ���� ������ ||

SELECT * FROM professor;

SELECT name, position FROM professor;

SELECT name || ' ' || position AS "���� �̸�" FROM professor;

--7. ��� ������ ����ϱ� +,-,*,/

SELECT ename,
       sal,
       comm,
       sal + 100,
       sal + comm,
       sal + 100 / 2,
       (sal + 100) / 2
  FROM emp;

SELECT first_name,
       salary,
       commission_pct,
       salary + salary * commission_pct
  FROM employees;

SELECT 100 * 0.3, 200 - 60, 100 + NULL, 20 * NULL FROM DUAL;

--����Ŭ�� select ���� from���� �ʼ�����
--from �� ���� �Ұ�, from �ڿ� ���� ���̺��� dual�� ���ش�

--null : �������� �ʴٴ� ��,
--null�� ������ �ϴ��� ����� null

SELECT * FROM DUAL;

DESC dual;

SELECT dcode "�μ�#", dname �μ���, area ��ġ FROM dept2;

SELECT    name
       || '�� Ű�� '
       || HEIGHT
       || ' cm, �����Դ� '
       || WEIGHT
       || 'kg �Դϴ�.'    AS "�л��� Ű�� ������"
  FROM student;

-- where ���� Ȱ���Ͽ� ���ϴ� ���Ǹ� ��ȸ�ϱ� 
--select [Į���� �Ǵ� ǥ����]  from [���̺��, ���] where ���ϴ� ����; 

-- emp ���̺��� 10�� �μ��� �ٹ��ϴ� ����� �̸��� �� ��, �μ���ȣ�� ��� 

SELECT ename, sal, deptno
  FROM emp
 WHERE deptno = 10;

-- emp ���̺��� �޿�(sal)�� 4000���� ū ����� �̸��� �޿��� ��� 

SELECT ename, sal
  FROM emp
 WHERE sal > 4000;

-- emp ���̺��� �̸��� scott�� ����� �̸��� �����ȣ, �޿��� ���
-- select ename, empno, sal from emp where ename = 'scott'; -- �����Ͱ� ��ȸX

SELECT ename, empno, sal
  FROM emp
 WHERE ename = 'SCOTT';

-- ����Ŭ�� ��ҹ��ڸ� �������� ������, �����ʹ� ��ҹ��ڸ� ������

--���ڿ��� ��¥�� '(Ȭ����ȿ)�� �����־�� ��
--professor���̺��� �Ի����� 1987-01-30�� ���ڵ� ��ȸ

SELECT *
  FROM professor
 WHERE HIREDATE = '1987-01-30';

--�Ǵ�

SELECT *
  FROM professor
 WHERE HIREDATE = '1987/01/30';

--���ǿ��� �پ��� ������ �̿�

/*
�� : =, !=, <, >, <=, >=
�� : and, or, not
���� : between A and B
��� : in(A,B,C)
Ư�� ���� : like
*/

--�� �����ڸ� ����Ͽ� student ���̺��� Ű(height)�� 180cm �� �� ũ�ų� ���� ��� ��� 

SELECT *
  FROM student
 WHERE height >= 180;

SELECT *
  FROM student
 WHERE NOT (height < 180);

--Between �����ڸ� ����Ͽ� student ���̺��� ������(weight)�� 60~80kg �� 
--����� �̸��� ü�� ��� 

SELECT *
  FROM student
 WHERE weight BETWEEN 60 AND 80;

SELECT *
  FROM student
 WHERE weight >= 60 AND weight <= 80;

-- �����԰� 60~80�� �ƴ� ���

SELECT *
  FROM student
 WHERE weight < 60 OR weight > 80;

SELECT *
  FROM student
 WHERE NOT (weight BETWEEN 60 AND 80);

SELECT *
  FROM student
 WHERE weight NOT BETWEEN 60 AND 80;

-- ����, ��¥�� between�� �̿��� �������� ���� �� �ִ�.
--ename�� B~G ������ ��� ��ȸ

SELECT *
  FROM emp
 WHERE ename >= 'B' AND ename <= 'G';

SELECT *
  FROM emp
 WHERE ename BETWEEN 'B' AND 'G';

--ename �� B~G�� �ƴ� ��� ��ȸ

SELECT *
  FROM emp
 WHERE ename NOT BETWEEN 'B' AND 'G';

SELECT *
  FROM emp
 WHERE NOT (ename BETWEEN 'B' AND 'G');

SELECT *
  FROM emp
 WHERE ename < 'B' OR ename > 'G';

-- employees���� �Ի����� 2005-2006�� ������ ��� ��ȸ

SELECT *
  FROM employees
 WHERE hire_date >= '2005-01-01' AND hire_date <= '2006-12-31';

SELECT *
  FROM employees
 WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2006-12-31';

--student���� 4�г��� �ƴ� �л��� ��ȸ

SELECT *
  FROM student
 WHERE grade != 4;

SELECT *
  FROM student
 WHERE grade <> 4;

SELECT *
  FROM student
 WHERE grade ^= 4;

--In �����ڸ� ����Ͽ� student ���̺��� 101�� �а� �л��� 102�� �а� �л����� ��� ���  

SELECT *
  FROM student
 WHERE DEPTNO1 IN (101, 102);

SELECT *
  FROM student
 WHERE deptno1 = 101 OR deptno1 = 102;

--�а��� 101,102�� �ƴ� �л�

SELECT *
  FROM student
 WHERE deptno1 NOT IN (101, 102);

--Like �����ڸ� ����Ͽ� student ���̺��� ���� "��"���� ����� ��ȸ

SELECT *
  FROM student
 WHERE NAME LIKE '��%';

-- �̸��� ���� ������ ��� ��ȸ

SELECT *
  FROM student
 WHERE name LIKE '%��';

-- �̸��� �簡 ���Ե� ��� ��ȸ

SELECT *
  FROM student
 WHERE name LIKE '%��%';

/*
like�� �Բ� ����� �� �ִ� wild card : %, _
1) % : ���ڼ� ���� ���� � ���ڰ� �͵� ��, ���ڰ� �� �͵� ��
2) _ : ���ڼ��� �� ���ڸ� �� �� �ְ�, � ���ڰ� �͵� ��
        �ݵ�� �� ���ڰ� �;� ��

*/

SELECT *
  FROM student
 WHERE id LIKE '%in%';                                            -- in�� ���Ե� ��

SELECT *
  FROM student
 WHERE id LIKE '_in__';                                             -- in �տ� �ѱ���, �ڿ� 2���� �;��ϴ� ��

SELECT *
  FROM employees
 WHERE job_id LIKE '%PR_%';                                                   --PR�ڿ� �ѱ��ڰ� ���;���

SELECT *
  FROM employees
 WHERE job_id LIKE '%PR\_%' ESCAPE '\';                                                               -- PR_(�����) ����

--job_id�� SA_�� �����ϰ� �ڿ� 3���ڰ� ������ �� ��ȸ

SELECT *
  FROM employees
 WHERE job_id LIKE 'SA\____' ESCAPE '\';

--�̸��� ������� ��� ��ȸ

SELECT *
  FROM student
 WHERE name = '�����';

-- ���� �躸�� ũ�ų� ���� ����� ��ȸ

SELECT *
  FROM student
 WHERE name >= '��';

/*
null : ����Ŭ�� ������ ���� �� �� ������ � ������ �𸥴ٴ� �ǹ�
        �����Ͱ� ������ �ǹ���, ���� ���ǵ��� ���� ������ ��
null ���� � ������ �����ص� ������� �׻� null �� ����

null ���� = ������ ����� �� ����
=> is null, is not null ���
*/
--professor ���̺��� bonus�� null�� ������ ��ȸ

SELECT *
  FROM professor
 WHERE bonus IS NULL;

SELECT *
  FROM professor
 WHERE bonus IS NOT NULL;

--�˻� ������ 2�� �̻��� ���
--�� ������ �켱 ���� () > not > and > or

-- student ���̺��� ����Ͽ� 4�г� �߿��� Ű�� 170cm �̻��� ��� �� �̸��� �г�, Ű�� ��ȸ

SELECT * FROM student;

SELECT name, grade, height
  FROM student
 WHERE grade = 4 AND height >= 170;

-- student ���̺��� ����Ͽ� 1�г��̰ų� �Ǵ� �����԰� 80kg �̻��� �л����� �̸��� �г�, Ű, �����Ը� ��ȸ 

SELECT name, grade, weight
  FROM student
 WHERE grade = 1 OR weight >= 80;

-- student ���̺��� ����Ͽ� 2�г� �߿��� Ű�� 180cm ���� ũ�鼭 
-- �����԰� 70kg ���� ū �л����� �̸��� �г�, Ű�� �����Ը� ��ȸ 

SELECT name,
       grade,
       height,
       weight
  FROM student
 WHERE grade = 2 AND weight > 70 AND height > 180;

-- student ���̺��� ����Ͽ� 2�г� �л� �߿��� Ű�� 180cm ���� ũ�ų� 
-- �Ǵ� �����԰� 70kg ���� ū �л����� �̸��� �г�, Ű, �����Ը� ��ȸ

SELECT name,
       grade,
       height,
       weight
  FROM student
 WHERE grade = 2 AND (height > 180 OR weight > 80);

--�ǽ�> professor ���̺��� �������� �̸��� ��ȸ�Ͽ� �� �κп� '��'�� ���Ե� ����� ����� ��� 

SELECT * FROM professor;

SELECT name
  FROM professor
 WHERE name >= '��' AND name < '��';

SELECT name
  FROM professor
 WHERE name BETWEEN '��' AND '��';

--10. order by ���� ����Ͽ� ��� ��� �����ϱ�

/*
�������� ����(�⺻��) asc
�������� ���� desc
SQL������ ���� �������� ����� ��

order by �÷���;       --��������
order by �÷��� asc;   --��������
order by �÷��� desc;  --��������
*/
-- student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű�� ���. ��, Ű�� ���� ������� ��� 

  SELECT name, height
    FROM student
ORDER BY height;

  SELECT name "�̸�", height
    FROM student
ORDER BY "�̸�";                                                     -- ��Ī���ε� ����

-- student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű, �����Ը� ���. 
-- ��, Ű�� ���� ������� ����ϰ� �����Դ� ���� ������� ��� 

  SELECT name, height, weight
    FROM student
ORDER BY height, weight DESC;

-- Ű�� ���� ��쿡�� �ι�° ���� �÷��� ������ ������������ ������

  SELECT name, height, weight
    FROM student
ORDER BY 2, 3 DESC;

-- ���ڸ� �̿��ϸ� �ι�° �÷�, 3��° �÷����� �����Ѵٴ� ��

-- student ���̺��� ����Ͽ� 1�г� �л��� �̸���  ����, Ű, �����Ը� ���. 
-- ��, ������ ���� ��� ������� ���� 

  SELECT name,
         BIRTHDAY,
         height,
         weight
    FROM student
ORDER BY birthday;

-- student ���̺��� ����Ͽ� 1�г� �л��� �̸��� Ű�� ���. ��, �̸� �� ������������ ���� 

  SELECT name, height
    FROM student
   WHERE grade = 1
ORDER BY name;

SELECT * FROM employees;

-- [�ǽ�]employees ���̺��� ������̵�, �̸� - ��(�� : Steven-King), �Ի���, �⺻��(salary), 
-- ����(salary*commission_pct), �޿�(salary+����) ��ȸ�ϱ�(����÷��� ��Ī ���)

SELECT EMPLOYEE_ID                          "��� ���̵�",
       FIRST_NAME || '-' || LAST_NAME       �̸�,
       HIRE_DATE                            �Ի���,
       SALARY                               �⺻��,
       SALARY * COMMISSION_PCT              ����,
       SALARY + SALARY * COMMISSION_PCT     �޿�
  FROM employees;

--

SELECT * FROM set1;                    -- 1:AAA, 1:AAA, 2:BBB

SELECT * FROM set2;                    -- 2:BBB:20, 3:CCC:15, 3:CCC:23

/*
���� ������

union - �� ������ ���ؼ� ����� ���(������), �ߺ�����, ��������
union all - �� ������ ���ؼ� ����� ���(������), �ߺ��������� �ʰ�, ���������� ����
intersect - �� ������ ������ ����� ���, ��������
minus - �� ������ ������ ����� ���, ��������

=> ���� ������ ���� ���ǻ���
1) �÷��� ������ ��ġ�ؾ� ��
2) �÷��� �ڷ����� ��ġ�ؾ� ��(�÷����� �޶� ��� ����)
*/
--set1�� set2 ���̺� union

SELECT id1, name1 FROM set1
UNION
SELECT id2, name2 FROM set2;                             -- AAA,BBB,CCC => �ߺ����ŵ�

-- union all

SELECT id1, name1 FROM set1
UNION ALL
SELECT id2, name2 FROM set2;                             -- AAA,AAA,BBB,BBB,CCC,CCC => �ߺ����žȵ�

--�а��� 101�� ������ �л� ��� ��ȸ

SELECT '[����]'     AS "����",
       profno         ��ȣ,
       name,
       id,
       hiredate,
       deptno
  FROM professor
 WHERE deptno = 101
UNION
SELECT '[�л�]'     AS "����",
       studno         ��ȣ,
       name,
       id,
       birthday,
       deptno2
  FROM student
 WHERE deptno1 = 101;

-- intersect

SELECT id1, name1 FROM set1
INTERSECT
SELECT id2, name2 FROM set2;                             -- BBB <= ������, �ߺ����ŵ�

-- minus

SELECT id1, name1 FROM set1
MINUS
SELECT id2, name2 FROM set2;                             -- AAA <= ������, �ߺ����ŵ�

SELECT id2, name1 FROM set2
MINUS
SELECT id1, name2 FROM set1;                             -- CCC <= ������, �ߺ����ŵ�

--product ���̺��� ��� �÷� �������� ? 

SELECT * FROM product;

--dept  ���̺��� ��� �÷� �������� ? 

SELECT * FROM dept;

--student ���̺��� �Ϻ� �÷��� �������� 

SELECT id, name "�л� �̸�", birthday FROM student;

-- professor ���̺��� ��� �÷��� ��ȸ�ϴµ�, name �� ���������� ��ȸ�ϱ� ? 
--���� : position �� ���������� �� �͸� ��ȸ ? 

  SELECT *
    FROM professor
   WHERE position = '������'
ORDER BY name DESC;

--2. department ���̺��� deptno, dname, build �÷��� ��ȸ ? 
--���� : �а�(dname)�� �����С��̶�� �ܾ �� �а����� ��ȸ �ϱ� ? 
--���� : dname ������ ������������ ���� ? 

  SELECT deptno, dname, build
    FROM department
   WHERE dname LIKE '%����%'
ORDER BY dname;

--3. emp2 ���̺��� name, emp_type, tel, pay, position �÷��� ��ȸ�ϵ�, 
--position �÷��� �÷������� ���������� ��Ÿ���� ?
-- ���� : pay�� 3000�������� 5000������ �͵鸸 ��ȸ�ϱ� 

SELECT name,
       emp_type,
       tel,
       pay,
       position     ����
  FROM emp2
 WHERE pay BETWEEN 30000000 AND 50000000;

-- 4. emp2 ���̺��� name, emp_type, tel, birthday �÷��� ��ȸ�ϵ�, 
--���� ���ǿ� �´� �����͸� ��ȸ ? 
--���� : ����(birthday)�� 1980�⵵ �� �͵鸸 ��ȸ�ϱ�(between �̿�) 

SELECT name,
       emp_type,
       tel,
       birthday
  FROM emp2
 WHERE birthday BETWEEN '1980-01-01' AND '1980-12-31';

--5. gift ���̺��� ��� �÷��� ��ȸ�ϵ� ? 
--���� : gname�� ����Ʈ����� �ܾ �� ���ڵ常 ��ȸ�ϱ� 

SELECT *
  FROM gift
 WHERE gname LIKE '%��Ʈ%';

--6. emp2 ���̺��� name, position, hobby, birthday �÷��� ��ȸ�ϵ� ? 
--���� : position �� null �� �ƴ� �͸� ��ȸ ? ����(birthday) ������ ������������ ���� 

  SELECT name,
         position,
         hobby,
         birthday
    FROM emp2
   WHERE position IS NOT NULL
ORDER BY birthday;

--7. emp2 ���̺��� ��� �÷��� ��ȸ�ϵ� ? 
--���� ? emp_type�� �����������̰ų� ����������� �͸� ��ȸ(in �̿�) 

SELECT *
  FROM emp2
 WHERE emp_type IN ('������', '�����');

--8. emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ� ? 
-- �ߺ��� ��(���ڵ�)�� ���� 

SELECT DISTINCT emp_type, position
  FROM emp2;

-----------------------------------20.04.17�ݿ���