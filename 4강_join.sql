/* Formatted on 2020/04/22 ���� 10:36:48 (QP5 v5.360) */
--4��_join.sql
--20-04-21 ȭ

/*
����(join)
- ������ ���̺� �и��Ǿ� �ִ� ������ �ִ� �����͵��� �����ϰų� �����ϴ� �Ϸ��� �۾���
- ���� ���̺� ����� �ִ� ���� �߿��� ����ڰ� �ʿ��� ������ �����ͼ� ������ ���̺�
 ����� ���� �������� �˻�
 
�� ������ ����
1) ���� ����(inner join)
    - ���� ���̺� ��� �����Ͱ� �����ؾ� ����� ����
2) �ܺ� ����(outer join)
3) self ����
4) cross join(īƼ�� ��)

����Ŭ�� ����
ǥ�� ANSI ����
*/
--[1] inner join(���� ����)
--����) �л� ���̺� (student)�� �а� ���̺� (department)�� ����Ͽ� �л��̸�, 
--1���� �а���ȣ (deptno1), 1���� �а��� ���� ����Ͻÿ�.

SELECT * FROM student;

SELECT * FROM department;

--1) ����Ŭ�� ����

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s, department d
 WHERE s.DEPTNO1 = d.DEPTNO;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -- join ����

--2) ǥ�� ANSI ����

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s INNER JOIN department d ON s.DEPTNO1 = d.DEPTNO;

-- inner ���� ����

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s JOIN department d ON s.DEPTNO1 = d.DEPTNO;

--4�г� �л����� ������ ��ȸ, �а��� ���
--1) ����Ŭ�� ����

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       s.GRADE,
       d.DNAME
  FROM student s, department d
 WHERE s.DEPTNO1 = d.DEPTNO                                           --join����
                            AND s.GRADE = 4;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           -- �˻�����

--2) ANSI

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       s.GRADE,
       d.DNAME
  FROM student s JOIN department d ON s.DEPTNO1 = d.DEPTNO AND s.GRADE = 4;

--����) �л� ���̺�(student)�� ���� ���̺�(professor)�� join�Ͽ� �� ���̸�, 
--�������� ��ȣ, �������� �̸��� ����Ͻÿ�

SELECT *
  FROM student
 WHERE profno IS NULL;

SELECT s.NAME, p.PROFNO, p.NAME
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    -- 15�� student�� profno�� null�� �����ʹ� �� ����
--=> �������� : ���� ���̺� �����Ͱ� �ִ� �͸� ��µ� 

SELECT s.NAME, p.PROFNO, p.NAME
  FROM student s JOIN professor p ON s.profno = p.profno;

-- employees, jobs �� �����ؼ� �������(�̸�, job_id)�� job_title�� ���

SELECT e.FIRST_NAME || '-' || e.LAST_NAME �̸�, e.JOB_ID, j.JOB_TITLE
  FROM employees e, jobs j
 WHERE e.JOB_ID = j.JOB_ID;

SELECT e.FIRST_NAME || '-' || e.LAST_NAME �̸�, e.JOB_ID, j.JOB_TITLE
  FROM employees e JOIN jobs j ON e.JOB_ID = j.JOB_ID;

--����) �л� ���̺�(student)�� �а� ���̺�(department), ���� ���̺� (professor)�� join�Ͽ� 
--�л��̸�, �а� �̸�, �������� �̸��� ����Ͻÿ�

SELECT s.NAME, d.DNAME, p.NAME
  FROM student s, department d, professor p
 WHERE s.PROFNO = p.PROFNO AND s.DEPTNO1 = d.DEPTNO;

SELECT s.NAME, d.DNAME, p.NAME
  FROM student  s
       JOIN department d ON s.DEPTNO1 = d.DEPTNO
       JOIN professor p ON s.PROFNO = p.PROFNO;

-- ����) emp2 ���̺�� �а� p_grade ���̺��� join�Ͽ� ����̸�, �� ��, ���翬��, 
--�ش� ������ ������ ���� �ݾװ� ���� �ݾ��� ����Ͻÿ�

SELECT e.NAME,
       e.POSITION,
       e.PAY       ����,
       p.S_PAY     ����,
       p.E_PAY     ����
  FROM emp2 e, p_grade p
 WHERE e.POSITION = p.POSITION;

SELECT e.NAME,
       e.POSITION,
       e.PAY       ����,
       p.S_PAY     ����,
       p.E_PAY     ����
  FROM emp2 e JOIN p_grade p ON e.POSITION = p.POSITION;

--�μ��� ���

SELECT e.NAME,
       e.POSITION,
       e.PAY       ����,
       p.S_PAY     ����,
       p.E_PAY     ����,
       d.DNAME
  FROM emp2 e, p_grade p, dept2 d
 WHERE e.POSITION = p.POSITION AND e.DEPTNO = d.DCODE;

SELECT e.NAME,
       e.POSITION,
       e.PAY       ����,
       p.S_PAY     ����,
       p.E_PAY     ����,
       d.DNAME
  FROM emp2  e
       JOIN p_grade p ON e.POSITION = p.POSITION
       JOIN dept2 d ON e.DEPTNO = d.DCODE;

-- �������, ����� �μ�����, �μ��� ��������, ������ �������� ��ȸ

SELECT e.*,
       d.DEPARTMENT_NAME,
       l.CITY,
       c.COUNTRY_NAME
  FROM employees    e,
       departments  d,
       locations    l,
       countries    c
 WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID
       AND d.LOCATION_ID = l.LOCATION_ID
       AND l.COUNTRY_ID = c.COUNTRY_ID;

SELECT e.*,
       d.DEPARTMENT_NAME,
       l.CITY,
       c.COUNTRY_NAME
  FROM employees  e
       JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
       JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
       JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID;

-- ����) 1����(depton1)�� 101���� �л����� �л��̸��� �������� �̸��� ����Ͻÿ�.

SELECT s.*, p.NAME
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO AND s.DEPTNO1 = 101;

SELECT s.*, p.NAME
  FROM student s JOIN professor p ON s.PROFNO = p.PROFNO AND s.DEPTNO1 = 101;

--1) emp2, dept2 ���̺��� �̿��ؼ� ����̸�(name), �޿�(pay), ����(position), 
--�μ���(dname)�� ��ȸ�Ͻÿ�

SELECT e.name,
       e.pay,
       e.position,
       d.dname
  FROM emp2 e, dept2 d
 WHERE E.DEPTNO = D.DCODE;

SELECT e.name,
       e.pay,
       e.position,
       d.dname
  FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE;

--2) emp2 - �μ���ȣ�� pay�� ���

  SELECT deptno, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e
GROUP BY DEPTNO;

--emp2, dept2 ���̺��� �μ��̸��� pay�� ��� ���ϱ�

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e, dept2 d
   WHERE E.DEPTNO = D.DCODE
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname;

--[�ǽ�] ���� ������ ������� �μ� �̸��� �������� �����ϴ� �μ��� ��ո� ��ȸ�Ͻÿ�.

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e, dept2 d
   WHERE E.DEPTNO = D.DCODE AND d.dname LIKE '����%'
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE AND d.dname LIKE '����%'
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname
  HAVING d.dname LIKE '����%';

--���� ������� �μ������ 5000���� �̻��� �����͸� ��ȸ

  SELECT d.dname, AVG (NVL (pay, 0)) "pay ���"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname
  HAVING AVG (NVL (pay, 0)) >= 50000000;

--[2]outer join(�ܺ� ����)

/*
inner join���� �ݴ�� ���� ���̺��� �����Ͱ� �ְ�, ���� ���̺� ���� ���
�����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
*/
--����)student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�. 
--��, ���������� �������� ���� �� ���� ��ܵ� �Բ� ����Ͻÿ�. (�л� �����ʹ� ���� ��µǵ���)

--1) inner join - ���ʿ� �����Ͱ� �����ϴ� �͸� ���

SELECT s.name, p.name
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO;

-- => 15��, ���������� ���� �л��� ����

--2) outer join - �л��� ��� ���

SELECT s.name, p.name
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO(+);

-- �����Ͱ� ���� �ʿ� (+) ǥ�ø� �Ѵ�

SELECT s.name, p.name
  FROM student s LEFT OUTER JOIN professor p ON s.PROFNO = p.PROFNO;

-- �����Ͱ� �ִ� �ʿ� ǥ�ø� ��
-- �л� �����ʹ� ���� ����ؾ� �ϹǷ� �л� ���̺��� ���� ǥ��
-- �л� ���̺��� ���ʿ� �����Ƿ� left


--����) student ���̺�� professor ���̺��� �����Ͽ� �� ���̸��� �������� �̸��� ��� �Ͻÿ�. 
--��, �����л��� �������� ���� �� ���� ��ܵ� �Բ� ����Ͻÿ�. (���� �����ʹ� ���� ��µǵ���)
-- ���� ������ 18��

  SELECT s.name, p.name, p.POSITION
    FROM student s, professor p
   WHERE s.PROFNO(+) = p.PROFNO
ORDER BY p.name;                                                                                                                                                                                                                                                                                                                                                                  -- 24��

  SELECT s.name, p.name, p.POSITION
    FROM student s RIGHT OUTER JOIN professor p ON s.PROFNO = p.PROFNO
ORDER BY p.name;

/*
����)student ���̺�� professor ���̺��� �����Ͽ� �л��̸��� �������� �̸��� ����Ͻÿ�. 
��, �����л��� �������� ���� �� ���� ��ܰ� ���������� ���� �� �� �л� ����� �Ѳ����� ����� �ÿ�. ? 
�� ���� outer join�� ����� ���ļ� ������ �� (Oracle outer join������ �������� ����)
=> �� outer join�� ���� ������ �� Union�� ����Ͽ� ����� ���������� ���ļ� ����� ? 
*/

SELECT s.name, p.name ��������, p.POSITION
  FROM student s, professor p
 WHERE s.PROFNO(+) = p.PROFNO
UNION
SELECT s.name, p.name ��������, p.POSITION
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO(+)
ORDER BY ��������;

--Ansi outer join ������ �ξ� ������ ����� ������

  SELECT s.name, p.name, p.POSITION
    FROM student s FULL OUTER JOIN professor p ON s.PROFNO = p.PROFNO
ORDER BY p.name;

--�л� ���� ���, �а���, ���������� ���
--�л� �����ʹ� ���� ��µǵ���

  SELECT s.*, d.DNAME, p.NAME
    FROM student s, professor p, department d
   WHERE s.PROFNO = p.PROFNO(+) AND p.DEPTNO = d.DEPTNO(+)
ORDER BY s.PROFNO;

  SELECT s.*, d.DNAME, p.NAME
    FROM student s
         LEFT OUTER JOIN professor p ON s.PROFNO = p.PROFNO
         LEFT JOIN department d ON p.DEPTNO = d.DEPTNO
ORDER BY s.PROFNO;

--�������, �μ�����, ��������, �������� ��ȸ
--��� ��ü ���(���-�μ���), �μ� ��ü ���(�μ�-������), ������ü ���(����-���� ��)

  SELECT e.*,
         d.DEPARTMENT_NAME     �μ���,
         l.CITY                ������,
         c.COUNTRY_NAME        ��������
    FROM employees  e,
         departments d,
         locations  l,
         countries  c
   WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
         AND d.LOCATION_ID = l.LOCATION_ID(+)
         AND l.COUNTRY_ID = c.COUNTRY_ID(+)
ORDER BY e.DEPARTMENT_ID;

--ANSI

  SELECT e.*,
         d.DEPARTMENT_NAME     �μ���,
         l.CITY                ������,
         c.COUNTRY_NAME        ��������
    FROM employees e
         LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         LEFT JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
         LEFT JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID
ORDER BY e.DEPARTMENT_ID;

--�ǽ�
-- 1. emp2, p_grade ���̺��� name(����̸�),  position(����), ���ۿ��� (s_year), 
--������(e_year)�� ��ȸ ? ��, emp2 ���̺��� �����ʹ� ���� ��µǵ��� �� ��

SELECT e.NAME ����̸�, e.POSITION ����, p.S_YEAR ���ۿ���
  FROM emp2 e, p_grade p
 WHERE e.POSITION = p.POSITION(+);

SELECT e.NAME ����̸�, e.POSITION ����, p.S_YEAR ���ۿ���
  FROM emp2 e LEFT JOIN p_grade p ON e.POSITION = p.POSITION;

--emp, dept ���̺��� �μ���ȣ,�����,����,�μ���,���� ��ȸ ��, ����(job)�� CLERK�� ��� �����͸� ��ȸ

SELECT e.DEPTNO     �μ���ȣ,
       e.ENAME      �����,
       e.JOB        ����,
       d.DNAME      �μ���,
       d.LOC        ����
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO AND e.JOB = 'CLERK';

SELECT e.DEPTNO     �μ���ȣ,
       e.ENAME      �����,
       e.JOB        ����,
       d.DNAME      �μ���,
       d.LOC        ����
  FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO AND e.JOB = 'CLERK';

--emp, dept ���̺��� �μ���ȣ,�����,����,�μ���,���� ��ȸ ��, ����(job)�� CLERK�� ����̰ų� 
--Manager�� ����� ��ȸ

SELECT e.DEPTNO     �μ���ȣ,
       e.ENAME      �����,
       e.JOB        ����,
       d.DNAME      �μ���,
       d.LOC        ����
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO AND e.JOB IN ('CLERK', 'MANAGER');

SELECT e.DEPTNO     �μ���ȣ,
       e.ENAME      �����,
       e.JOB        ����,
       d.DNAME      �μ���,
       d.LOC        ����
  FROM emp  e
       JOIN dept d ON e.DEPTNO = d.DEPTNO AND e.JOB IN ('CLERK', 'MANAGER');

--emp, dept ���̺��� ����(loc)�� �޿�(sal)�� ��� ��ȸ ? Join, group by ��� �̿�

  SELECT d.LOC, AVG (NVL (e.SAL, 0))
    FROM emp e, dept d
   WHERE e.DEPTNO = d.DEPTNO
GROUP BY d.LOC;

  SELECT d.LOC, AVG (NVL (e.SAL, 0))
    FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
GROUP BY d.LOC;

-- student ���̺�� exam_01 ���̺��� ��ȸ�Ͽ� �л����� �й�, �̸�, ����, ������ ����Ͻÿ� 
--(������ dcode�� case�̿�- 90 �̻��̸� 'A', 80�̻��̸� 'B', 70�̻��̸� 'C', 60�̻��̸�'D' 
--60�̸��̸� 'F' )

SELECT s.STUDNO    �й�,
       s.NAME      �̸�,
       e.TOTAL     ����,
       CASE TRUNC (e.TOTAL / 10)
           WHEN 10 THEN 'A'
           WHEN 9 THEN 'A'
           WHEN 8 THEN 'B'
           WHEN 7 THEN 'C'
           WHEN 6 THEN 'D'
           ELSE 'F'
       END         ����
  FROM student s, exam_01 e
 WHERE s.STUDNO = e.STUDNO;

SELECT s.STUDNO    �й�,
       s.NAME      �̸�,
       e.TOTAL     ����,
       CASE TRUNC (e.TOTAL / 10)
           WHEN 10 THEN 'A'
           WHEN 9 THEN 'A'
           WHEN 8 THEN 'B'
           WHEN 7 THEN 'C'
           WHEN 6 THEN 'D'
           ELSE 'F'
       END         ����
  FROM student s JOIN exam_01 e ON s.STUDNO = e.STUDNO;

   --2020-04-22 ������

  SELECT l.city,
         d.department_name,
         e.job_id,
         e.job_id,
         e.salary
    FROM employees e
         LEFT JOIN departments d ON e.department_id = d.department_id
         LEFT JOIN locations l ON d.location_id = l.location_id
ORDER BY d.department_id DESC;

  SELECT l.city,
         d.department_name,
         e.job_id,
         SUM (e.salaty)     �޿��հ�,
         COUNT (*)          �ο���
    FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON d.location_id = l.location_id
GROUP BY l.city, d.department_name, e.job_id
ORDER BY l.city, d.department_name, e.job_id;

--select * from emp_details_view;

--[3] self join
--���� �μ��� ��ȸ�ϱ�
--�μ� ���̺��� �����μ��ڵ�(pdept)�� �ش��ϴ� �����μ� ������ ���

SELECT * FROM dept2;                                         -- 13��

--inner join

  SELECT a.*,
         a.dname,
         a.pdept     "���� �μ� �ڵ�",
         a.area,
         b.dname     "���� �μ���"
    FROM dept2 a JOIN dept2 b ON a.pdept = b.dcode
ORDER BY a.dcode;                                   --12 ��
-- ������� ���� �μ��� null�̹Ƿ� �����͸� �������� �ʾ���

--outer join

  SELECT a.*,
         a.dname,
         a.pdept     "���� �μ� �ڵ�",
         a.area,
         b.dname     "���� �μ���"
    FROM dept2 a LEFT JOIN dept2 b ON a.pdept = b.dcode
ORDER BY a.dcode;                                   -- 13��
--=> ����� ���ڵ嵵 ���Ե�

--��������� �ش� ����� ���� ����� �̸� ���
select * from employees;

select a.*, b.first_name "���ӻ���� �̸�"
from employees a left join employees b
on a.manager_id=b.employee_id;

--2. EMP Table�� �ִ� EMPNO�� MGR�� �̿��Ͽ� ������ ���踦 ������ ���� ����϶�. 
--��FORD�� �Ŵ����� JONES��
select a.*, b.ename "�Ŵ���"
from emp a left join emp b
on a.mgr=b.empno;

-- īƼ�ǰ�(cartesion product)
/*
- join ������ ���� ���
 �� ���̺��� �����͸� ���� ������ŭ�� �����Ͱ� ��µ�
- ANSI join ������ cross join�̶�� �θ�
*/
select * from emp; --14��
select * from dept; -- 4��

select e.*,d.dname
from emp e, dept d; -- 14 * 4 = 56�� ���

--ANSI join
select e.*,d.dname, d.deptno
from emp e cross join dept d
order by d.deptno, e.empno; -- 14 * 4 = 56�� ���