/* Formatted on 2020/05/06 ���� 10:44:18 (QP5 v5.360) */
--3��_sql�׷��Լ�.sql
--20-04-20 ��

--�������Լ�(�׷��Լ�)

SELECT SUM (pay) FROM professor;

SELECT * FROM professor;

--count() : �ԷµǴ� �������� �Ǽ��� ����
--�׷��Լ��� null�� �����ϰ� �����

SELECT COUNT (*), COUNT (bonus), COUNT (hpage), COUNT (name) FROM professor;                                                                                                                                                                        --=> bonus, hpage�� �Ǽ��� null�� ���ܵ� �Ǽ�

--sum() : �հ踦 ���ϴ� �Լ�

/*
����, ��¥�� sum, avg() �Լ��� ����� �� ����(����Ұ�)
count�Լ��� ��� ��� ����
*/

SELECT SUM (pay),
       SUM (bonus),
       COUNT (pay),
       COUNT (bonus),
       COUNT (*)
  FROM professor;

--select sum(name) from professor; => error

--avg() : ����� ���ϴ� �Լ�

SELECT AVG (pay),
       SUM (pay),
       COUNT (pay),
       COUNT (*),
       AVG (bonus),
       SUM (bonus),
       COUNT (bonus),
       COUNT (*),
       SUM (bonus) / COUNT (bonus),
       SUM (bonus) / COUNT (*),
       AVG (NVL (bonus, 0))
  FROM professor;

/*
�׷��Լ��� null�� �����ϰ� �����ϹǷ�, avg()�� �������� ������� ������ ����
=> nvl() �Լ��� �̿��Ͽ� ó��
=> avg(nvl(�÷�,0))
*/

--max() : �ִ밪
--min() : �ּҰ�

SELECT MAX (pay), MIN (pay), MAX (bonus), MIN (bonus) FROM professor;

--����, ��¥�� �ִ밪, �ּҰ��� ���� �� �ִ�.(��� �񱳰� �����ϹǷ�)

SELECT MAX (name), MIN (name), MAX (hiredate), MIN (hiredate) FROM professor;

--�ߺ����� ������ �Ǽ� : count(distinct �÷���)

SELECT COUNT (grade), COUNT (*), COUNT (DISTINCT grade) FROM student;

/*
sum(distinct �÷���) - �ߺ����� ������ �հ�
avg(distinct �÷���) - �ߺ����� ������ ���
max(distinct �÷���) - �ߺ����� ������ �ִ밪
min(distinct �÷���) - �ߺ����� ������ �ּҰ�
*/

--�׷캰 ����
--�а����� �������� ��ձ޿��� ���ϱ�

SELECT AVG (pay) FROM professor;                                                                                                --��ü �������� ��ձ޿�

  SELECT deptno, pay
    FROM professor
ORDER BY deptno;                                                                                   -- �а����� ����

  SELECT deptno, AVG (pay)
    FROM professor
GROUP BY deptno
ORDER BY deptno;

/*
group by
- ���̺� ��ü�� ���� ���踦 ���ϴ� ���� �ƴ�, Ư�� ���������� ���� �����͸� ����
*/
-- �а���, ���޺� �޿��� ��� ���ϱ�

  SELECT deptno, position, AVG (NVL (pay, 0))
    FROM professor
GROUP BY deptno, position
ORDER BY deptno, position;

--=> group by ���� �ִ� �÷��� �׷��Լ��� select���� �� �� �ִ�.

--group by�������� ��Ī ��� �Ұ�

  SELECT deptno dno, position ����, AVG (NVL (pay, 0)) "��ձ޿�"
    FROM professor
GROUP BY dno, position                                                -- error
ORDER BY deptno, position;

--�а��� ��� �޿��� ���� ��, ��� �޿��� 450�ʰ��� �μ��� �μ���ȣ�� ��ձ޿����ϱ�

  SELECT deptno, AVG (NVL (pay, 0))
    FROM professor
--where avg(nvl(pay,0)) > 400=>error : group function is not allowed here
GROUP BY deptno
  HAVING AVG (NVL (pay, 0)) > 450;

/*
having
- group by�� ��� ������ Ư�� ������ �����ϴ� ���� ���Ϸ��� having�� �̿�
- group by���� ���� ��µ� ����� ���� ������ ����
- group by�� ����� �����ϰ��� �� �� ���

group by Į��
having ����
*/

--Student ���̺��� grade���� weight, height�� ���, �ִ밪 ���ϱ� 

  SELECT grade,
         AVG (NVL (weight, 0))     "���� ���",
         AVG (NVL (height, 0))     "Ű ���",
         MAX (weight)              "���� �ִ밪",
         MAX (height)              "Ű �ִ밪"
    FROM student
GROUP BY grade;

--2���� ������� Ű�� ����� 170 ������ ��� ���ϱ�

  SELECT grade,
         AVG (NVL (weight, 0))     "���� ���",
         AVG (NVL (height, 0))     "Ű ���",
         MAX (weight)              "���� �ִ밪",
         MAX (height)              "Ű �ִ밪"
    FROM student
GROUP BY grade
  HAVING AVG (NVL (height, 0)) <= 170;

--emp2 ���� position �� pay�� �հ�, ��� ���ϱ�
--�� ������� ����� 5000���� �̻��� ��� ���ϱ�

  SELECT position,
         SUM (NVL (pay, 0))     "pay �հ�",
         AVG (NVL (pay, 0))     "pay ���"
    FROM emp2
GROUP BY position
  HAVING AVG (NVL (pay, 0)) >= 50000000;

/*
�� select sql�� ���� ����
5. select �÷�
1. from ���̺� 
2. where ����
3. group by �÷�
4. having ����
6. order by �÷� (desc)
*/

--rollup, cube : group by�� �԰� ���
--[1] rollup() : �־��� �����͵��� �Ұ踦 ������
--group by���� �־��� �������� �Ұ谪�� ������

--�а��� ��� �޿�

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "��� �޿�"
    FROM professor
GROUP BY deptno
ORDER BY deptno;

--rollup()�̿�

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "��� �޿�"
    FROM professor
GROUP BY ROLLUP (deptno)
ORDER BY deptno;

--cube()�̿�

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "��� �޿�"
    FROM professor
GROUP BY CUBE (deptno)
ORDER BY deptno;

--group by�� �÷��� 2���� ���
--�а���, ���޺� ��� �޿�

  SELECT deptno, position, AVG (NVL (pay, 0)) "��� �޿�"
    FROM professor
GROUP BY deptno, position
ORDER BY deptno, position;

--rollup()

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 1) "��� �޿�"
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--=> �а���, ��ü �Ұ谡 �߰���

--cube()

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 1) "��� �޿�"
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--=> �а���, ���޺�, ��ü �Ұ谡 �߰���

-- group by�� �÷��� 3���� ���
--������, �μ���, ������ ��� �޿� ���ϱ�

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "�ο���",
         AVG (NVL (SALARY, 0))       "��� �޿�"
    FROM emp_details_view
GROUP BY CITY, DEPARTMENT_name, JOB_ID
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--rollup()

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "�ο���",
         AVG (NVL (SALARY, 0))       "��� �޿�"
    FROM emp_details_view
GROUP BY ROLLUP (CITY, DEPARTMENT_name, JOB_ID)
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--=> �÷��� ����+1���� �Ұ谡 �������
--��) rollup(a,b,c) => (a),(a,b),(a,b,c),() => 3+1 => 4���� �Ұ谡 �������

--cube() 

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "�ο���",
         AVG (NVL (SALARY, 0))       "��� �޿�"
    FROM emp_details_view
GROUP BY CUBE (CITY, DEPARTMENT_name, JOB_ID)
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--=> 2�� �÷��� ���� �Ұ谡 �������
--��) rollup(a,b,c) => (a),(b),...,(a,b,c),() => 2�� 3�� => 8���� �Ұ谡 �������

--2020-04-21 ȭ����

/*
grouping �Լ�
- rollup�Լ��� cube �Լ��� �Բ� ���Ǵ� �Լ��� � Į���� �ش� grouping�۾���
  ��� �Ǿ����� �ƴ����� �������ִ� ������ ��
- � Į���� grouping �۾��� ���Ǿ����� 0�� ��ȯ�ϰ�, ������ �ʾ����� 1�� ��ȯ
- �Ұ迡 ���� ��� ������ �� �� ���
*/

--group by�� �÷��� 1���� ���
--rollup

  SELECT deptno                            �а�,
         ROUND (AVG (NVL (pay, 0)), 1)     "��ձ޿�",
         GROUPING (deptno)
    FROM professor
GROUP BY ROLLUP (deptno)
ORDER BY deptno;

-- cube

  SELECT deptno                            �а�,
         ROUND (AVG (NVL (pay, 0)), 1)     "��ձ޿�",
         GROUPING (deptno)
    FROM professor
GROUP BY CUBE (deptno)
ORDER BY deptno;

--group by �� �÷��� 2���� ���
--rollup

  SELECT deptno                            �а�,
         position                          ����,
         ROUND (AVG (NVL (pay, 0)), 1)     "��ձ޿�",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--cube

  SELECT deptno                            �а�,
         position                          ����,
         ROUND (AVG (NVL (pay, 0)), 1)     "��ձ޿�",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

-- decode �̿�

  SELECT deptno
             �а�,
         DECODE (GROUPING (position), 0, position, '�а��� �Ұ�')
             ����,
         ROUND (AVG (NVL (pay, 0)), 1)
             "��ձ޿�",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

  SELECT DECODE (GROUPING (deptno), 1, '[��ü]', deptno)
             �а�,
         DECODE (
             GROUPING (position),
             0, position,
             DECODE (GROUPING (deptno), 0, '�а��� �Ұ�', '[�� �հ�]'))
             ����,
         ROUND (AVG (NVL (pay, 0)), 1)
             "��ձ޿�",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--cube

  SELECT DECODE (
             GROUPING (deptno),
             1, DECODE (GROUPING (position),
                        0, '[���޺� �Ұ�]',
                        '[��ü]'),
             deptno)                      �а�,
         DECODE (
             GROUPING (position),
             1, DECODE (GROUPING (deptno),
                        0, '[�а��� �Ұ�]',
                        '[�� �հ�]'),
             position)                    ����,
         ROUND (AVG (NVL (pay, 0)), 1)    "��ձ޿�",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--grouping sets
--���ϴ� ���踸 ������ �� �ִ�.
--�׷��� ������ ���� ���� ��� �����ϰ� ���

--��) STUDENT ���̺��� �г⺰�� �л����� �ο��� �հ�� �а����� �� ������ �հ踦 ���ؾ� �ϴ� ��쿡 
--�������� �г⺰�� �ο��� �հ踦 ���� �� ������ �а����� �ο��� �հ踦 ���� �� UNION ������ ���� 

  SELECT grade, COUNT (*)
    FROM student
GROUP BY grade
UNION
  SELECT deptno1, COUNT (*)
    FROM student
GROUP BY deptno1;

--grouping sets �̿�
--���� �׷�

  SELECT grade, deptno1, COUNT (*)
    FROM student
GROUP BY grade, deptno1
ORDER BY grade, deptno1;

--grouping sets

  SELECT grade, deptno1, COUNT (*)
    FROM student
GROUP BY GROUPING SETS ((grade), (deptno1), (  ))
ORDER BY grade, deptno1;

--rollup

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) �޿�
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--grouping sets�� �̿��� rollup�� ������ ��Ȳ

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) �޿�
    FROM professor
GROUP BY GROUPING SETS ((deptno, position), (deptno), (  ))
ORDER BY deptno, position;

--cube

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) �޿�
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--grouping sets�� �̿��� cube�� ������ ��Ȳ

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) �޿�
    FROM professor
GROUP BY GROUPING SETS ((deptno, position),
                        (deptno),
                        (position),
                        (  ))
ORDER BY deptno, position;

--grouping sets�� �̿��� ���� ���ϴµ��� ���

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) �޿�
    FROM professor
GROUP BY GROUPING SETS ((deptno, position), (position))
ORDER BY deptno, position;

--panmae ���̺��� ����(p_qty)�� 3�� �̻��� �� ���Ϳ� ���� �Ǹ���(p_date)��, �Ǹ���(p_store) ���� 
--�Ǹűݾ�(p_total)�� �հ� ���ϱ� ? 

  SELECT p_qty                      ����,
         p_date                     �Ǹ���,
         p_store                    �Ǹ���,
         SUM (NVL (p_total, 0))     �Ǹűݾ�
    FROM panmae
   WHERE p_qty >= 3
GROUP BY p_qty, p_date, p_store
ORDER BY p_qty, p_date, p_store;

--rollup, cube�̿��Ͽ� �Ұ� ��� ? 

  SELECT p_qty                      ����,
         p_date                     �Ǹ���,
         p_store                    �Ǹ���,
         SUM (NVL (p_total, 0))     �Ǹűݾ�
    FROM panmae
   WHERE p_qty >= 3
GROUP BY ROLLUP (p_qty, p_date, p_store)
ORDER BY p_qty, p_date, p_store;

  SELECT p_qty                      ����,
         p_date                     �Ǹ���,
         p_store                    �Ǹ���,
         SUM (NVL (p_total, 0))     �Ǹűݾ�
    FROM panmae
   WHERE p_qty >= 3
GROUP BY CUBE (p_qty, p_date, p_store)
ORDER BY p_qty, p_date, p_store;

--������ ��� grouping�Լ��� �̿��ؼ� ������� ����� ��(decode()�� �̿�)

  SELECT DECODE (
             GROUPING (p_qty),
             1, DECODE (
                    GROUPING (p_date),
                    1, DECODE (GROUPING (p_store),
                               1, '[3�� �̻�]',
                               '[�Ǹ�����]'),
                    '[�Ǹ��Ϻ�]'),
             p_qty)                ����,
         DECODE (
             GROUPING (p_date),
             1, DECODE (
                    GROUPING (p_store),
                    1, DECODE (GROUPING (p_qty),
                               1, '[�Ǹűݾ�]',
                               '[������]'),
                    '[�Ǹ����� �� ��]'),
             p_date)               �Ǹ���,
         DECODE (
             GROUPING (p_store),
             1, DECODE (GROUPING (p_date),
                        1, '[�� ��]',
                        '[�Ǹ����� �� ��]'),
             p_store)              �Ǹ���,
         SUM (NVL (p_total, 0))    �Ǹűݾ�,
         GROUPING (p_qty),
         GROUPING (p_date),
         GROUPING (p_store)
    FROM panmae
   WHERE p_qty >= 3
GROUP BY GROUPING SETS ((p_qty, p_date, p_store),
                        (p_qty, p_date),
                        (p_qty, p_store),
                        (p_date, p_store),
                        (p_qty),
                        (p_date),
                        (p_store),
                        (  ))
ORDER BY p_qty, p_date, p_store;

--emp ���̺��� �μ����� �� ���޺� sal�� �հ谡 ���� �� ����ؼ� ����ϱ�
--[1] group by �̿�, ���� ���(���� ���)

  SELECT DEPTNO, JOB, SUM (NVL (sal, 0))
    FROM emp
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--[2] job�� ���η� ����ϱ�
--job�� sal�� �հ�

  SELECT job, SUM (sal), COUNT (*)
    FROM emp
GROUP BY job
ORDER BY job;

--job�� ���η� ����

  SELECT SUM (DECODE (job, 'ANALYST', sal))       ANALYST,
         SUM (DECODE (job, 'CLERK', sal))         CLERK,
         SUM (DECODE (job, 'MANAGER', sal))       MANAGER,
         SUM (DECODE (job, 'PRESIDENT', sal))     PRESIDENT,
         SUM (DECODE (job, 'SALESMAN', sal))      SALESMAN,
         SUM (sal)                                "�� �հ�"
    FROM emp
ORDER BY deptno;

--deptno���� group by�ϰ�, job�� ���η� ���

  SELECT deptno,
         SUM (DECODE (job, 'ANALYST', sal))       ANALYST,
         SUM (DECODE (job, 'CLERK', sal))         CLERK,
         SUM (DECODE (job, 'MANAGER', sal))       MANAGER,
         SUM (DECODE (job, 'PRESIDENT', sal))     PRESIDENT,
         SUM (DECODE (job, 'SALESMAN', sal))      SALESMAN,
         SUM (sal)                                "�μ��� �հ�"
    FROM emp
GROUP BY deptno
ORDER BY deptno;

--���� ����(������ price�� �հ� ���ϱ�)
--[1] group by

  SELECT EXTRACT (MONTH FROM REGDATE) ��, SUM (price)
    FROM pd
GROUP BY EXTRACT (MONTH FROM REGDATE)
ORDER BY EXTRACT (MONTH FROM REGDATE);

  SELECT TO_CHAR (REGDATE, 'mm') ��, SUM (price)
    FROM pd
GROUP BY TO_CHAR (REGDATE, 'mm')
ORDER BY TO_CHAR (REGDATE, 'mm');

--[2] ���� ���η� ���

SELECT SUM (DECODE (EXTRACT (MONTH FROM REGDATE), 3, price))     "3��",
       SUM (DECODE (EXTRACT (MONTH FROM REGDATE), 4, price))     "4��"
  FROM pd;

SELECT SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '01', price))     "1��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '02', price))     "2��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '03', price))     "3��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '04', price))     "4��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '05', price))     "5��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '06', price))     "6��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '07', price))     "7��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '08', price))     "8��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '09', price))     "9��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '10', price))     "10��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '11', price))     "11��",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '12', price))     "12��"
  FROM pd;

-- student ���̺��� deptno1(�а�)��, grade(�г�)�� Ű (height)�� ��ձ��ϱ� ? 
--[1] group by �̿� ? 

  SELECT deptno1, grade, AVG (NVL (height, 0)) ���Ű
    FROM student
GROUP BY deptno1, grade
ORDER BY deptno1, grade;

--[2] group by, decode �̿�-����, ���� �ٲ㼭

  SELECT deptno1,
         AVG (DECODE (grade, 1, NVL (height, 0)))     "1�г�",
         AVG (DECODE (grade, 2, NVL (height, 0)))     "2�г�",
         AVG (DECODE (grade, 3, NVL (height, 0)))     "3�г�",
         AVG (DECODE (grade, 4, NVL (height, 0)))     "4�г�"
    FROM student
GROUP BY deptno1
ORDER BY deptno1;