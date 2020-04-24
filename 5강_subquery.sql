/* Formatted on 2020/04/24 ���� 10:43:08 (QP5 v5.360) */
--5��_subquery.sql
--[2020-04-22 ������]

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
 WHERE ename = 'SCOTT';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 -- 3000

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


 --[2020-04-23 �����]

 /*
 <exists ������>
 - Ư�� �÷����� �����ϴ��� ���θ� üũ
 - ���������� ��ȯ�ϴ� ����� ���� �������� ����� �����͵��� �����ϱ⸸ �ϸ� ������ ����
 - ���ɸ鿡�� in���� ������ �����
 
 �� in, exists��
 1) in - � ���� ���ԵǴ��� ���θ� üũ
        in�� ()�� ���� ���� �ü��� �ְ�, ���������� �� ���� �ִ�.
 2) exists - Ư�� �÷����� �����ϴ��� ���θ� üũ
            exists�� ���� ���������� �� �� �ִ�.
 */

 --�μ� ���̺��� pdept ���� null�� �ƴ� �μ��� ���ϴ� ��� ����

SELECT *
  FROM dept2
 WHERE pdept IS NOT NULL;

 --0001�� ������ ��� �μ�

 --in �̿�

SELECT *
  FROM emp2
 WHERE deptno IN (SELECT dcode
                    FROM dept2
                   WHERE pdept IS NOT NULL);

 --exists �̿�

SELECT *
  FROM emp2 e
 WHERE EXISTS
           (SELECT 1
              FROM dept2 d
             WHERE d.pdept IS NOT NULL AND e.DEPTNO = d.DCODE);

-- cf. join

SELECT e.*, d.*
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE AND d.pdept IS NOT NULL;

-- ��� ���翡 ���ϴ� ������� ���� ��ȸ
--in

SELECT *
  FROM dept2
 WHERE area = '�������';

SELECT *
  FROM emp2
 WHERE DEPTNO IN (SELECT dcode
                    FROM dept2
                   WHERE area = '�������');

--exists

SELECT *
  FROM emp2 e
 WHERE EXISTS
           (SELECT 1
              FROM dept2 d
             WHERE e.DEPTNO = d.DCODE AND area = '�������');

--cf. join

SELECT *
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE AND area = '�������';

--������ 3000�޷� �̻��� ����� ���� �μ��� ��ȸ emp, dept �̿�
-- in

SELECT *
  FROM dept
 WHERE DEPTNO IN (SELECT deptno
                    FROM emp
                   WHERE SAL >= 3000);

-- exists

SELECT *
  FROM dept d
 WHERE EXISTS
           (SELECT 1
              FROM emp e
             WHERE d.DEPTNO = e.DEPTNO AND sal >= 3000);

--join

SELECT DISTINCT d.*
  FROM dept d JOIN emp e ON d.DEPTNO = e.DEPTNO AND sal >= 3000;

/*
�� �������� ��ġ�� �̸�
- ���������� ���� ��ġ�� ���� �� �̸��� �ٸ�
[1] scalar sub query
    - select ���� ���� ���������� �ѹ��� ����� 1�྿ ��ȯ��
[2] inline view
    - from ���� ���� ��������
[3] sub query
    - where ���� ���� �������� 
*/

-- ����) emp2 ���̺�� dept2 ���̺��� ��ȸ�Ͽ� ������� �̸��� �μ��̸� �� ����Ͻÿ�
--join

SELECT e.NAME, d.DNAME
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE;

--outer join

SELECT e.NAME, d.DNAME
  FROM emp2 e LEFT JOIN dept2 d ON e.DEPTNO = d.DCODE;

--scalar sub query

SELECT name,
       (SELECT dname
          FROM dept2 d
         WHERE d.DCODE = e.deptno)    �μ���
  FROM emp2 e;

--=> select������ ����Ϸ��� ���� �������� �߿��� �������̸鼭 ���� �÷��� ��츸 ������
--(������ ���ڳ� ���ڷ� �ν��� �� �ִ� ��������) 

--employees, departments - �������, �μ��� ��ȸ
--scalar sumquery

  SELECT e.*,
         (SELECT d.DEPARTMENT_NAME
            FROM departments d
           WHERE e.department_id = d.DEPARTMENT_ID)    �μ���
    FROM employees e
ORDER BY e.department_id DESC;

--join

  SELECT e.*, d.DEPARTMENT_NAME �μ���
    FROM employees e JOIN departments d ON e.department_id = d.DEPARTMENT_ID
ORDER BY e.department_id DESC;

-- outer join

  SELECT e.*, d.DEPARTMENT_NAME �μ���
    FROM employees e
         LEFT JOIN departments d ON e.department_id = d.DEPARTMENT_ID
ORDER BY e.department_id DESC;

--scalar subquery�� outer join �� ����
--��������� ��� ����ϰ�, �μ���ȣ�� ���� ��� scalar subquery�� ��ȸ�� �μ����� null���� ��

--�� �μ��� �ش��ϴ� ����� ���ϱ�

SELECT * FROM dept;

SELECT * FROM emp;

SELECT dname,
       d.LOC,
       (SELECT COUNT (*)
          FROM emp e
         WHERE e.DEPTNO = d.deptno)    �����
  FROM dept d;

-- �а��� ������ �ο���, ����� ���ϱ�

SELECT COUNT (*) FROM professor;

  SELECT deptno,
         COUNT (*)                                                         �ο���,
         ROUND (COUNT (*) / (SELECT COUNT (*) FROM professor) * 100, 1)    "�����"
    FROM professor
GROUP BY deptno
ORDER BY deptno;

SELECT d.*,
       (SELECT COUNT (*)
          FROM professor p
         WHERE p.DEPTNO = d.deptno)    "������ �ο���",
          ROUND (  (SELECT COUNT (*)
                      FROM professor p
                     WHERE p.DEPTNO = d.deptno)
                 / (SELECT COUNT (*) FROM professor)
                 * 100,
                 1)
       || '%'                          "�����"
  FROM department d;

--employees ���� job_id�� �޿��� �հ谡 ��ü �ݾ׿��� �����ϴ� ���� ���ϱ�

  SELECT job_id,
         SUM (SALARY)    "�޿��� �հ�",
            ROUND (SUM (SALARY) / (SELECT SUM (salary) FROM employees) * 100,
                   2)
         || '%'          "����"
    FROM employees
GROUP BY ROLLUP (job_id)
ORDER BY job_id;

--case �̿�, scalar subquery �̿�
--employees���� ���� ����̸�, �޿� ���� ���ϱ�
--����� ���� ��� �������� ǥ��, 
--salary�� 5000�̸��̸� ��, 5000~10000 ��, 10001~20000 ��, �� �̻� Ư��

  SELECT FIRST_NAME || '-' || LAST_NAME    �̸�,
         NVL ((SELECT b.FIRST_NAME
                 FROM employees b
                WHERE b.EMPLOYEE_ID = e.MANAGER_ID),
              '����')                    "���ӻ�� �̸�",
         e.SALARY,
         CASE
             WHEN salary < 5000 THEN '��'
             WHEN salary BETWEEN 5000 AND 10000 THEN '��'
             WHEN salary BETWEEN 10001 AND 20000 THEN '��'
             ELSE 'Ư��'
         END                               "�޿� ����"
    FROM employees e
ORDER BY salary DESC;


  SELECT FIRST_NAME || '-' || LAST_NAME    �̸�,
         CASE
             WHEN e.MANAGER_ID IS NULL
             THEN
                 '����'
             ELSE
                 (SELECT b.FIRST_NAME
                    FROM employees b
                   WHERE b.EMPLOYEE_ID = e.MANAGER_ID)
         END                               "���ӻ�� �̸�",
         e.SALARY,
         CASE
             WHEN salary < 5000 THEN '��'
             WHEN salary BETWEEN 5000 AND 10000 THEN '��'
             WHEN salary BETWEEN 10001 AND 20000 THEN '��'
             ELSE 'Ư��'
         END                               "�޿� ����"
    FROM employees e
ORDER BY salary DESC;

/*
<�ǻ��÷�(pseudocolumn) - ����, ���� �÷�>
- ���̺� �ִ� �Ϲ����� �÷�ó�� �ൿ�ϱ�� ������, ������ ���̺� ����Ǿ� ���� ���� �÷�

[1] rownum : ������ ����� ������ ������ row�鿡 ���� �������� ����Ű�� �ǻ��÷�
- �ַ� Ư�� ������ �� ������ row�� ������ �� ����

[2] rowid : ���̺� ����� ������ row���� ����� �ּҰ��� ���� �ǻ��÷�
- ��� ���̺��� ��� row���� ���� �ڽŸ��� ������ rowid���� ������ �ִ�
*/

SELECT ROWNUM, empno, ename, sal, ROWID AS "ROW_ID" FROM emp;

-- emp���̺� ��ü���� ���� 5���� ������ ��ȸ

SELECT ROWNUM,
       empno,
       ename,
       sal,
       ROWID     AS "ROW_ID"
  FROM emp
 WHERE ROWNUM <= 5;

-- order by �̿�, emp���̺��� ename ������ ������ ���¿��� ���� 5�� ��ȸ

  SELECT ROWNUM,
         empno,
         ename,
         sal
    FROM emp
ORDER BY ename;

-- rownum ������ �ڹٲ�

--inline view �̿�

SELECT ROWNUM,
       empno,
       ename,
       sal
  FROM (  SELECT empno, ename, sal
            FROM emp
        ORDER BY ename)
 WHERE ROWNUM <= 5;

--student���� height ������� ���� 7���� �л� ��ȸ

  SELECT *
    FROM student
ORDER BY height DESC;

SELECT ROWNUM, name, height
  FROM (  SELECT *
            FROM student
        ORDER BY height DESC)
 WHERE ROWNUM <= 7;

--employees���� salary�� �������� �����ؼ� ���� 6�Ǹ� ��ȸ

SELECT ROWNUM, FIRST_NAME, SALARY
  FROM (  SELECT FIRST_NAME, SALARY
            FROM employees
        ORDER BY salary DESC)
 WHERE ROWNUM <= 6;

 --�������� 2~4 ������ ��� ��ȸ

SELECT ROWNUM, FIRST_NAME, SALARY
  FROM (  SELECT FIRST_NAME, SALARY
            FROM employees
        ORDER BY salary DESC)
 WHERE ROWNUM BETWEEN 2 AND 4;

 --��� �ȳ���, 1�� �ݵ�� ���ԵǾ�� ��(���ԾȵǸ� 0�� ���)

 -- ��Ī�� ����Ͽ� 1���� ���(inline view �ι� ���)

SELECT rnum, FIRST_NAME, SALARY
  FROM (SELECT ROWNUM rnum, FIRST_NAME, SALARY
          FROM (  SELECT FIRST_NAME, SALARY
                    FROM employees
                ORDER BY salary DESC))
 WHERE rnum BETWEEN 2 AND 4;

 --inline view 
-- employees���� ��������� ��ȸ�ϰ�, job_id�� ��� �޿��� ��ȸ

SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY FROM employees;

  SELECT job_id, AVG (NVL (salary, 0))
    FROM employees
GROUP BY job_id;

SELECT a.EMPLOYEE_ID,
       a.FIRST_NAME,
       a.JOB_ID,
       a.SALARY,
       b.���
  FROM employees  a
       JOIN (  SELECT job_id, AVG (NVL (salary, 0)) ���
                 FROM employees
             GROUP BY job_id) b
           ON a.JOB_ID = b.JOB_ID;

--�α��� ó��

SELECT * FROM MEMBER;

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = 'simson' AND passwd = 'a1234')
           WHEN 1 THEN '�α��� ����'
           ELSE '�α��� ����'
       END    �α���
  FROM DUAL;

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = 'simson' AND passwd = 'a1234')
           WHEN 1
           THEN
               '�α��� ����'
           ELSE
               CASE (SELECT COUNT (*)
                       FROM MEMBER
                      WHERE id = 'simson')
                   WHEN 1 THEN '��й�ȣ�� Ʋ�Ƚ��ϴ�.'
                   ELSE '���̵� �����ϴ�.'
               END
       END    �α���
  FROM DUAL;

-- ����ڷκ��� �Է°� �޾ƿͼ� ó���ϱ�

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = :id AND passwd = :pwd)
           WHEN 1
           THEN
               '�α��� ����'
           ELSE
               CASE (SELECT COUNT (*)
                       FROM MEMBER
                      WHERE id = :id)
                   WHEN 1 THEN '��й�ȣ�� Ʋ�Ƚ��ϴ�.'
                   ELSE '���̵� �����ϴ�.'
               END
       END    �α���
  FROM DUAL;

--decode �̿�

SELECT DECODE ((SELECT COUNT (*)
                  FROM MEMBER
                 WHERE id = :id AND passwd = :pwd),
               1, '�α��� ����',
               DECODE ((SELECT COUNT (*)
                          FROM MEMBER
                         WHERE id = :id),
                       1, '��й�ȣ�� Ʋ�Ƚ��ϴ�.',
                       '���̵� �����ϴ�.'))    �α���
  FROM DUAL;

--gogak���� 10��, 30�� ���� ��ȸ - inline view�̿�

/*
10,14,19 => 10
20,22,27 => 20
*/

SELECT * FROM gogak;

SELECT gname,
       jumin,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
           ELSE '����'
       END    ����,
         EXTRACT (YEAR FROM SYSDATE)
       - (  SUBSTR (jumin, 1, 2)
          + CASE WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900 ELSE 2000 END)
       + 1    ����
  FROM gogak;

SELECT gname,
       jumin,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
           ELSE '����'
       END        ����,
         EXTRACT (YEAR FROM SYSDATE)
       - (  SUBSTR (jumin, 1, 2)
          + CASE WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900 ELSE 2000 END)
       + 1        ����,
       TRUNC (
           (  EXTRACT (YEAR FROM SYSDATE)
            - (  SUBSTR (jumin, 1, 2)
               + CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                     ELSE 2000
                 END)
            + 1),
           -1)    ���ɴ�
  FROM gogak;

SELECT a.*
  FROM (SELECT gname,
               jumin,
               CASE
                   WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
                   ELSE '����'
               END        ����,
                 EXTRACT (YEAR FROM SYSDATE)
               - (  SUBSTR (jumin, 1, 2)
                  + CASE
                        WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                        ELSE 2000
                    END)
               + 1        ����,
               TRUNC (
                   (  EXTRACT (YEAR FROM SYSDATE)
                    - (  SUBSTR (jumin, 1, 2)
                       + CASE
                             WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                             ELSE 2000
                         END)
                    + 1),
                   -1)    ���ɴ�
          FROM gogak) a
 WHERE a.���ɴ� IN (10, 30) AND a.���� = '����';

--�г⺰, ���� �ο���, �����
--student

SELECT name,
       jumin,
       grade,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
           ELSE '����'
       END    ����
  FROM student;

  SELECT grade,
         ����,
         COUNT (*)                                                    �ο���,
         COUNT (*) / (SELECT COUNT (*) FROM student) * 100 || '%'     �����
    FROM (SELECT name,
                 jumin,
                 grade,
                 CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '����'
                     ELSE '����'
                 END    ����
            FROM student) a
GROUP BY ROLLUP (grade, ����);

--job_history�� ������ ��ȸ�ϵ�, job_id�� �ش��ϴ� job_title,
--department_id�� �ش��ϴ� �μ��� ��ȸ
--scalar subquery �̿�

SELECT * FROM job_history;

SELECT * FROM jobs;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT a.*,
       (SELECT job_title
          FROM jobs b
         WHERE a.JOB_ID = b.job_id)                  job_title,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTs c
         WHERE a.department_id = c.DEPARTMENT_ID)    �μ���
  FROM job_history a;

-- ��� ������ ��ȸ

SELECT a.EMPLOYEE_ID,
       a.START_DATE,
       a.END_DATE,
       a.JOB_ID,
       a.DEPARTMENT_ID,
       e.FIRST_NAME,
       e.HIRE_DATE,
       e.SALARY,
       (SELECT job_title
          FROM jobs b
         WHERE a.JOB_ID = b.job_id)                  job_title,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTs c
         WHERE a.department_id = c.DEPARTMENT_ID)    �μ���
  FROM job_history a RIGHT JOIN employees e ON a.EMPLOYEE_ID = e.EMPLOYEE_ID;

-- �� �μ��� ���ϴ� ��������� ��ȸ�ϰ� , �μ��� ��ձ޿��� ����Ͻÿ� 
--[1] �� �μ��� ���ϴ� ��������� ��ȸ�ϴ� ������ ����

SELECT d.DEPARTMENT_ID                        �μ���ȣ,
       d.DEPARTMENT_NAME                      �μ���,
       e.EMPLOYEE_ID                          �����ȣ,
       e.FIRST_NAME || '-' || e.LAST_NAME     �����,
       e.HIRE_DATE                            �Ի���,
       e.SALARY                               �޿�
  FROM DEPARTMENTS  d
       RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--[2] �μ��� ��ձ޿�

  SELECT �μ���, ROUND (AVG (NVL (�޿�, 0))) "��� �޿�"
    FROM (SELECT d.DEPARTMENT_ID                        �μ���ȣ,
                 d.DEPARTMENT_NAME                      �μ���,
                 e.EMPLOYEE_ID                          �����ȣ,
                 e.FIRST_NAME || '-' || e.LAST_NAME     �����,
                 e.HIRE_DATE                            �Ի���,
                 e.SALARY                               �޿�
            FROM DEPARTMENTS d
                 RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) a
GROUP BY �μ���;

--[3] �� ���� �����͸� ����

SELECT A.*, B."��� �޿�"
  FROM (SELECT d.DEPARTMENT_ID                        �μ���ȣ,
               d.DEPARTMENT_NAME                      �μ���,
               e.EMPLOYEE_ID                          �����ȣ,
               e.FIRST_NAME || '-' || e.LAST_NAME     �����,
               e.HIRE_DATE                            �Ի���,
               e.SALARY                               �޿�
          FROM DEPARTMENTS  d
               RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) A
       LEFT JOIN
       (  SELECT �μ���, ROUND (AVG (NVL (�޿�, 0))) "��� �޿�"
            FROM (SELECT d.DEPARTMENT_ID                        �μ���ȣ,
                         d.DEPARTMENT_NAME                      �μ���,
                         e.EMPLOYEE_ID                          �����ȣ,
                         e.FIRST_NAME || '-' || e.LAST_NAME     �����,
                         e.HIRE_DATE                            �Ի���,
                         e.SALARY                               �޿�
                    FROM DEPARTMENTS d
                         RIGHT JOIN EMPLOYEES e
                             ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) a
        GROUP BY �μ���) B
           ON A."�μ���" = B."�μ���";

-- emp ���̺��� ��ȸ�Ͽ� ������ �߿��� �ڽ��� job�� ��� ����(sal)���� ���� �� ���� �޴� ������� ��ȸ�Ͻÿ�.

SELECT AVG (NVL (sal, 0)) FROM emp;

  SELECT a.*
    FROM emp a
   WHERE sal <= (SELECT AVG (NVL (sal, 0))
                   FROM emp b
                  WHERE b.JOB = a.job)
ORDER BY a.job;

-- �� �а��� �ش��ϴ� ������ �� ���ϱ� ?
-- �� �а��� �ش��ϴ� �л��� ���ϱ� ?
-- department , student ���̺�

  SELECT DEPTNO, COUNT (*)
    FROM professor
GROUP BY DEPTNO;

SELECT deptno,
       dname,
       (SELECT COUNT (*)
          FROM professor b
         WHERE a.deptno = b.DEPTNO)    "������ ��"
  FROM department a;

--�а��� ������ ��

SELECT deptno,
       dname,
       (SELECT COUNT (*)
          FROM student b
         WHERE a.deptno = b.DEPTNO1)    "�л��� ��"
  FROM department a;

--�а��� �л� ��

--Professor ���̺��� ������ ���� �޴� ���� ������ 10�� ��ȸ�ϱ� ? 

SELECT r,
       PROFNO,
       NAME,
       PAY
  FROM (SELECT ROWNUM     r,
               PROFNO,
               NAME,
               PAY
          FROM (  SELECT PROFNO, NAME, PAY
                    FROM professor
                ORDER BY pay DESC))
 WHERE r <= 10;

--Student, exam_01 ���̺��� ������ 90�̻��� �л����� ���� ��ȸ

SELECT s.*
  FROM student s
 WHERE TRUNC (  (SELECT TOTAL
                   FROM exam_01 e
                  WHERE e.STUDNO = s.STUDNO)
              / 10) IN (10, 9);

SELECT *
  FROM student
 WHERE studno IN (SELECT studno
                    FROM exam_01
                   WHERE total >= 90);

SELECT *
  FROM student s
 WHERE EXISTS
           (SELECT studno
              FROM exam_01 e
             WHERE s.STUDNO = e.STUDNO AND total >= 90);


--[2020-04-24 �ݿ���]
--departments, employees �����ؼ� �μ��� �ش��ϴ� ����� ���� ��ȸ

  SELECT d.DEPARTMENT_ID,
         d.DEPARTMENT_NAME,
         e.EMPLOYEE_ID,
         e.FIRST_NAME,
         e.SALARY
    FROM departments d
         FULL JOIN employees e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

--�μ��� �� �˰�ʹ�

SELECT a.DEPARTMENT_ID       "�μ� ��ȣ",
       a.DEPARTMENT_NAME     "�μ� �̸�",
       a.MANAGER_ID          "�μ��� ��ȣ",
       b.FIRST_NAME          "�μ��� ��"
  FROM departments a LEFT JOIN employees b ON a.MANAGER_ID = b.EMPLOYEE_ID;

  SELECT A.*,
         e.EMPLOYEE_ID     "��� ��ȣ",
         e.FIRST_NAME      "��� �̸�",
         e.SALARY          "����"
    FROM (SELECT a.DEPARTMENT_ID       "�μ� ��ȣ",
                 a.DEPARTMENT_NAME     "�μ� �̸�",
                 a.MANAGER_ID          "�μ��� ��ȣ",
                 b.FIRST_NAME          "�μ��� ��"
            FROM departments a JOIN employees b ON a.MANAGER_ID = b.EMPLOYEE_ID)
         A
         FULL JOIN employees e ON A."�μ� ��ȣ" = e.DEPARTMENT_ID
ORDER BY "�μ� ��ȣ";