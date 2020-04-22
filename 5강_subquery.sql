/* Formatted on 2020/04/22 ���� 6:45:58 (QP5 v5.360) */
--5��_subquery.sql
--2020-04-22 ������

/*
�������� - �����ȿ� �� �ٸ� ������ ��� �ִ� ��

select * from ���̺� -- main query
where ���� ������(select �÷� from ���̺� where ����); --subquery

()�ȿ� ���������� �ִ´�
*/
--��)emp���̺��� scott ���� �޿��� ���� �޴� ����� �̸��� �޿� ���
--1) ���� scott�� �޿��� ���Ѵ�

SELECT sal
  FROM emp
 WHERE ename = 'SCOTT';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    -- 3000

--2) 3000���� ���� �޴� ���� ��ȸ

SELECT ename, sal
  FROM emp
 WHERE sal > 3000;

--subquery �̿�

SELECT ename, sal
  FROM emp
 WHERE sal > (SELECT sal
                FROM emp
               WHERE ename = 'SCOTT');

--subquery �κ��� where���� ������ �����ʿ� ��ġ�ؾ� �ϸ� �ݵ�� ��ȣ�� ���� �־�� ��

/*
=> ������ �������� - ���������� ����� �ϳ��� ���� ���
              ���������� ������ ����� 1�Ǹ� ������, �� ����� main query�� �����ؼ�
              main query�� �����ϰ� ��
������ ���������� ��� where������ ���Ǵ� ������
( =, !=, >, <, >=, <= )

�� ���������� ����
1) ������ �������� - ���������� ����� 1���� ���� ���
2) ������ �������� - ���������� ����� 2���� �� �̻��� ���
3) �����÷� �������� - ���������� ����� �����÷��� ���
4) ������ �ִ� ��������(������� ��������) - ���� ������ ���������� ���� �����Ǿ� �ִ� ���
*/

--����) student ���̺�� department ���̺��� ����Ͽ� ������ �л� �� 1����(deptno1)�� 
--������ �л����� �̸��� 1���� �̸��� ����Ͻÿ�

SELECT * FROM student;

SELECT * FROM department;

SELECT s.name �̸�, d.dname ������
  FROM student  s
       JOIN department d
           ON     s.deptno1 = d.deptno
              AND deptno1 = (SELECT deptno1
                               FROM student
                              WHERE name = '������');

-- �ǽ�) Professor ���̺��� �� ������ �۵��� �������� ���߿� �Ի��� ����� �̸��� �Ի���, �а����� ����Ͻÿ�.
-- professor, department���̺� �̿�

SELECT p.NAME, p.HIREDATE, d.DNAME
  FROM professor  p
       JOIN department d
           ON     p.DEPTNO = d.DEPTNO
              AND p.hiredate > (SELECT hiredate
                                  FROM professor
                                 WHERE name = '�۵���');

-- �ǽ�) student ���̺��� 1�� ��(deptno1)�� 101���� �а��� ��� �����Ժ��� �����԰� ���� �л����� 
-- �̸��� �����Ը� ��� �Ͻÿ�

SELECT name, weight
  FROM student
 WHERE weight > (SELECT AVG (NVL (weight, 0))
                   FROM student
                  WHERE deptno1 = 101);

--����) Professor ���̺��� �ɽ� ������ ���� �Ի��Ͽ� �Ի��� ���� �߿��� ������ �������� 
--������ ���� �޴� ������ �̸��� �޿�, �Ի����� ����Ͻÿ�
--1)�ɽ��� �Ի���

SELECT HIREDATE
  FROM professor
 WHERE name = '�ɽ�';

 --1981/10/23

--2) �������� ����

SELECT PAY
  FROM professor
 WHERE name = '������';

 -- 550

--3) subquery

SELECT *
  FROM professor
 WHERE     HIREDATE = (SELECT HIREDATE
                         FROM professor
                        WHERE name = '�ɽ�')
       AND pay < (SELECT PAY
                    FROM professor
                   WHERE name = '������');

-- emp2���� ������ ���� ���� ��� ��ȸ 
--1) pay�� �ִ밪

SELECT MAX (pay) FROM emp2;

--2) subquery

SELECT *
  FROM emp2
 WHERE pay = (SELECT MAX (pay) FROM emp2);

 --dept2���� �μ��� ��ȸ

SELECT e.*, d.DNAME
  FROM emp2  e
       JOIN dept2 d
           ON e.DEPTNO = d.DCODE AND pay = (SELECT MAX (pay) FROM emp2);

--employees ���̺��� ������ ���� ���� ��� ���� ��ȸ(Department ���̺�� �����ؼ� �μ��� ��ȸ�� ��)

SELECT e.*, d.DEPARTMENT_NAME �μ���
  FROM employees  e
       JOIN departments d
           ON     e.DEPARTMENT_ID = d.DEPARTMENT_ID
              AND SALARY = (SELECT MIN (NVL (salary, 0)) FROM employees);

/*
<������ ��������>
- ���������� ����� 2�� �̻� ��µǴ� ���
- ���������� ����� ���� �� ��µǱ� ������ ������ �����ڸ� ����� �� ����

�� ���� �� �������� ������
in - ���� ���� ã�´�(������ ��)
<ani - �ִ밪�� ��ȯ 
>ani - �ּҰ��� ��ȯ
<all - �ּҰ��� ��ȯ
>all - �ִ밪�� ��ȯ

any - ���� �� �� �ƹ��ų� �ϳ��� ������ �����ص� �ȴٴ� �ǹ�
all - ������������ ��ȯ�Ǵ� ��� row���� �����ؾ� ���� �ǹ�
*/
--����) emp2 ���̺�� dept2 �� �̺��� �����Ͽ� �ٹ����� (dept2 ���̺��� area Į��)�� �� �� ������ 
--��� ������� ����� �̸�, �μ���ȣ�� ����Ͻÿ�

SELECT EMPNO, NAME, DEPTNO
  FROM emp2
 WHERE DEPTNO IN (SELECT dcode
                    FROM dept2
                   WHERE area = '��������');

--����) emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ּ� �����ں��� ������ ���� ����� �̸��� ����, 
--������ ����Ͻÿ�. ��, ���� ��������� õ ���� ���� ��ȣ�� �� ǥ�ø� �Ͻÿ�.

SELECT * FROM emp2;

SELECT MIN (pay)
  FROM emp2
 WHERE position = '����';

 --49000000

SELECT TO_CHAR (pay, '999,999,999') || '��'     ����
  FROM emp2
 WHERE position = '����';

 --50000000,56000000,51000000,49000000

SELECT *
  FROM emp2
 WHERE pay > ANY (50000000,
                  56000000,
                  51000000,
                  49000000);

SELECT *
  FROM emp2
 WHERE pay > 50000000 OR pay > 56000000 OR pay > 51000000 OR pay > 49000000;

--������ subquery

SELECT *
  FROM emp2
 WHERE pay > (SELECT MIN (pay)
                FROM emp2
               WHERE position = '����');

--������ subquery

SELECT *
  FROM emp2
 WHERE pay > ANY (SELECT pay
                    FROM emp2
                   WHERE position = '����');

--����) emp2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ִ� ������ ���� ������ ���� ����� 
--�̸��� ����, ������ ����Ͻÿ�.

SELECT *
  FROM emp2
 WHERE pay > (SELECT MAX (NVL (pay, 0))
                FROM emp2
               WHERE position = '����');

SELECT *
  FROM emp2
 WHERE PAY > ALL (SELECT pay
                    FROM emp2
                   WHERE position = '����');

--�ٹ������� ������簡 �ƴ� ��� ����� ��ȸ 
-- ������

SELECT *
  FROM emp2
 WHERE deptno NOT IN (SELECT dcode
                        FROM dept2
                       WHERE area = '�������');

--�μ��� ��ȸ

SELECT e.*, d.area
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE
 WHERE deptno NOT IN (SELECT dcode
                        FROM dept2
                       WHERE area = '�������');

--loc�� DALLAS �� �ƴ� ��� ��� ��ȸ 
--������

SELECT *
  FROM emp
 WHERE deptno != (SELECT deptno
                    FROM dept
                   WHERE loc = 'DALLAS');

--join �μ���

SELECT e.*, d.loc
  FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
 WHERE e.deptno != (SELECT deptno
                      FROM dept
                     WHERE loc = 'DALLAS');

--������ �������������� != ������ �̿�
--������ �������������� not in ������ �̿�

/*
������ ���������� ������       ������ ���������� ������
    =                      in
    !=                   not in
    >,<            <ani, >ani, <all, >all
*/

--�ǽ�)student ���̺��� ��ȸ�Ͽ� ��ü �л� �߿��� ü���� 4�г� �л� ���� ü�߿��� 
--���� ���� ������ �л����� �����԰� ���� �л��� �̸� �� �����Ը� ����Ͻÿ�.

SELECT *
  FROM student
 WHERE weight < (SELECT MIN (NVL (weight, 0))
                   FROM student
                  WHERE grade = 4);

SELECT *
  FROM student
 WHERE weight < ALL (SELECT weight
                       FROM student
                      WHERE grade = 4);

--����) emp2 ���̺��� ��ȸ�Ͽ� �� �μ��� ��� ������ �� �ϰ� �� �߿��� ��� ������ 
--���� ���� �μ��� ��� �������� ���� �޴� �������� �μ���,������, ������ ����Ͻÿ�.
--1)�μ��� ��� ����

  SELECT AVG (NVL (pay, 0))
    FROM emp2
GROUP BY DEPTNO;

--2) ������ subquery

SELECT *
  FROM emp2
 WHERE PAY < (  SELECT MIN (AVG (NVL (pay, 0)))
                  FROM emp2
              GROUP BY DEPTNO);

--3) ������ subquery

SELECT *
  FROM emp2
 WHERE PAY < ALL (  SELECT AVG (NVL (pay, 0))
                      FROM emp2
                  GROUP BY DEPTNO);

--employees ���� job_id�� salary �հ� �ݾ��� 30000�̻��� job_id�� ���ϴ� ��� ��ȸ

SELECT *
  FROM employees
 WHERE job_id IN (  SELECT job_id
                      FROM employees
                  GROUP BY job_id
                    HAVING SUM (NVL (salary, 0)) >= 30000);

/*
<����Į�� ��������> - pairwise subquery
- Sub query�� ����� ���� Į���� ���
*/
--����) student ���̺��� ��ȸ�Ͽ� �� �г⺰�� �ִ� Ű�� ���� �л��� �� �г�� �̸��� Ű�� ����Ͻÿ�.
--�г⺰ �ִ�Ű ���ϱ�

  SELECT grade, MAX (NVL (height, 0))
    FROM student
GROUP BY grade;

--����Į�� ��������

  SELECT grade, name, height
    FROM student
   WHERE (grade, height) IN (  SELECT grade, MAX (NVL (height, 0))
                                 FROM student
                             GROUP BY grade)
ORDER BY grade;

--����) professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ���� �� ������ 
--������ȣ�� �̸�, �Ի���, �а����� ����Ͻÿ�. �� �а��̸������� �������� �����Ͻÿ�.
--group by

  SELECT DEPTNO, MIN (HIREDATE)
    FROM professor
GROUP BY DEPTNO;

-- �����÷� ��������

  SELECT p.*, d.DNAME
    FROM professor p JOIN DEPARTMENT d ON p.DEPTNO = d.DEPTNO
   WHERE (p.DEPTNO, HIREDATE) IN (  SELECT DEPTNO, MIN (HIREDATE)
                                      FROM professor
                                  GROUP BY DEPTNO)
ORDER BY d.DNAME;

--�ǽ�) emp2 ���̺��� ��ȸ�Ͽ� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸��� ����, ������ ����Ͻÿ� . 
--��, ���������� �������� �����Ͻÿ�

  SELECT name �����, position ����, pay ����
    FROM emp2
   WHERE (POSITION, PAY) IN (  SELECT position, MAX (pay)
                                 FROM emp2
                             GROUP BY position)
ORDER BY pay;


-- position�� null�� ��쵵 ��ȸ

  SELECT name �����, NVL (position, '����') ����, pay ����
    FROM emp2
   WHERE (NVL (POSITION, '����'), PAY) IN
             (  SELECT NVL (position, '����'), MAX (pay)
                  FROM emp2
              GROUP BY position)
ORDER BY pay;

--�μ���ȣ���� �⺻���� �ִ��� ����� �⺻���� �ּ��� ��� ��ȸ�ϱ�
--employees �̿�
--�μ��� null�� ��쵵 ��ȸ�ǵ���
--1)�ִ�

  SELECT NVL (DEPARTMENT_ID, '0'), MAX (SALARY)
    FROM employees
GROUP BY DEPARTMENT_ID;

--2)�ּ�

  SELECT NVL (DEPARTMENT_ID, '0'), MIN (SALARY)
    FROM employees
GROUP BY DEPARTMENT_ID;

--3)�����÷� ��������

  SELECT FIRST_NAME, NVL (DEPARTMENT_ID, '-10') �μ���ȣ, SALARY
    FROM employees
   WHERE    (NVL (DEPARTMENT_ID, '-10'), SALARY) IN
                (  SELECT NVL (DEPARTMENT_ID, '-10'), MAX (SALARY)
                     FROM employees
                 GROUP BY DEPARTMENT_ID)
         OR (NVL (DEPARTMENT_ID, '-10'), SALARY) IN
                (  SELECT NVL (DEPARTMENT_ID, '-10'), MIN (SALARY)
                     FROM employees
                 GROUP BY DEPARTMENT_ID)
ORDER BY �μ���ȣ;

/*
<��ȣ ���� ���� ����(������ �ִ� ������, ������� ��������)>
- ���������� ���� ������ ���������� �ʰ�, �������� �� ������ ���� ����Ǿ� �ִ� ������ ����
- ���������� �������� ���̿��� ������ ���
- ���������� �÷��� ���������� where �������� ����

- �������� ���� ���������� �ְ� ���������� ������ ��, �� ����� �ٽ� ���� ������ ��ȯ�ؼ� �����ϴ� ���� ����
*/
--����) emp2 ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� ������ ��� �� ���� ���ų� ���� �޴� ������� 
--�̸�, ����, ���翬���� ����Ͻÿ�.

  SELECT name, position, pay
    FROM emp2 a
   WHERE pay >= (SELECT AVG (pay)
                   FROM emp2 b
                  WHERE a.POSITION = b.POSITION)
ORDER BY position;

-- professor ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� �а��� ��� �޿����� ���� �޴� ������� 
--�̸�, �μ�, ����޿��� ����Ͻÿ�

  SELECT *
    FROM professor a
   WHERE pay > (SELECT AVG (NVL (pay, 0))
                  FROM professor b
                 WHERE a.DEPTNO = b.DEPTNO)
ORDER BY DEPTNO;

--emp���� ����� �߿� �ڽ��� job�� ��� �������� ���ų� ���� �޴� ����� ��ȸ

SELECT *
  FROM emp a
 WHERE SAL <= (SELECT AVG (NVL (sal, 0))
                 FROM emp b
                WHERE a.JOB = b.JOB);

-----�ǽ�------

--1.job�� MANAGER�� ����� ��ȸ(emp)

SELECT *
  FROM emp
 WHERE empno IN (SELECT empno
                   FROM emp
                  WHERE job = 'MANAGER');

-- 2. job�� Manager�� ��� ����麸�� �Ի����� ����(����) ��� ���� �� ��ȸ => all �̿� (emp) ? 

SELECT *
  FROM emp
 WHERE hiredate < ALL (SELECT hiredate
                         FROM emp
                        WHERE job = 'MANAGER');

--3. ALL���� ����� ��� <= MIN�Լ��� �Ἥ

SELECT *
  FROM emp
 WHERE hiredate < (SELECT MIN (hiredate)
                     FROM emp
                    WHERE job = 'MANAGER');

--4. sales�μ��� �ٹ��ϴ� ��� ������ ��ȸ(emp, dept) ? 

SELECT *
  FROM emp
 WHERE DEPTNO IN (SELECT DEPTNO
                    FROM dept
                   WHERE DNAME = 'SALES');

--5. ��ձ޿����� �޿��� ���� �޴� ��� ������ ��������(emp)

SELECT *
  FROM emp
 WHERE sal > (SELECT AVG (NVL (sal, 0)) FROM emp);