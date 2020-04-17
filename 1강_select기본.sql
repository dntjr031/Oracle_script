--1��_select�⺻.sql
--[2020-04-14 ȭ]

--���� �ּ�
/*
������ �ּ�
*/

select * from tab; -- �ش� ������ ���̺� ����� ��ȸ

desc countries; -- �ش� ���̺� � �÷��� �ִ� �� ���̺� ������ Ȯ���� �� �ִ�.

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
SELECT * FROM employees; -- �ڽ�
SELECT * FROM jobs; -- �θ�

SELECT * FROM employees; -- �ڽ�
SELECT * FROM departments; --�θ�

SELECT * FROM locations; --  �θ�
SELECT * FROM departments; -- �ڽ�

SELECT * FROM locations; -- �ڽ�
SELECT * FROM countries; --�θ�

SELECT * FROM countries; -- �ڽ�
SELECT * FROM regions; --�θ�

SELECT * FROM JOB_HISTORY; -- �ڽ�
SELECT * FROM employees; -- �θ�

SELECT * FROM jobs; --�θ�
SELECT * FROM JOB_HISTORY;--�ڽ�

SELECT * FROM JOB_HISTORY;--�ڽ�
SELECT * FROM departments; --�θ�

-------------------------20.04.16�����

--������ ��ȸ�ϱ�
-- SELECT �÷���1,�÷���2 FROM ���̺��;

--1. ��� �÷� ��ȸ�ϱ�
-- SELECT * FROM ���̺��;

--EMPLOYEES ���̺��� ��� �÷� ��ȸ�ϱ�
SELECT * FROM EMPLOYEES; -- ��ҹ��� ���� ����
-- ��, �����ʹ� ��ҹ��� ������

--2. �Ϻ� �÷��� ��ȸ�ϱ�
-- SELECT �÷�1, �÷�2 FROM ���̺��;

--employees ���̺��� ������̵�, �̸�, �Ի���, �޿� ��ȸ�ϱ�
SELECT employee_id, first_name, last_name, hire_date,
    salary FROM employees;
    
--3. ǥ������ ����Ͽ� ����ϱ�
SELECT first_name, '�� ȯ���մϴ�.' from employees;
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

SELECT employee_id as "������̵�", first_name �̸�, last_name ��,
phone_number "��ȭ��ȣ", salary "�޿�!" FROM employees;

-- 5. distinct �ߺ��� ���� �����ϰ� ����ϱ�
select * from emp;

select deptno from emp;
select distinct deptno from emp; -- �ߺ��� �����Ͱ� ���ŵ�

select deptno, job from emp order by deptno, job;
select distinct deptno, job from emp order by deptno, job;
-- distinct Ű����� 1���� �÷����� ��� ��� �÷��� �����

--6. ���� ������ ||
select * from professor;

select name, position from professor;
select name || ' ' || position as "���� �̸�" from professor;

--7. ��� ������ ����ϱ� +,-,*,/
select ename, sal, comm, sal+100, sal+comm, sal+100/2, 
(sal+100)/2 from emp;

select first_name, salary, commission_pct, salary+salary*commission_pct
from employees;

select 100*0.3, 200-60, 100+null, 20*null from dual;
--����Ŭ�� select ���� from���� �ʼ�����
--from �� ���� �Ұ�, from �ڿ� ���� ���̺��� dual�� ���ش�

--null : �������� �ʴٴ� ��,
--null�� ������ �ϴ��� ����� null

select * from dual;
desc dual;

select dcode "�μ�#", dname �μ���, area ��ġ FROM dept2;

select name || '�� Ű�� ' || HEIGHT || ' cm, �����Դ� ' || WEIGHT || 'kg �Դϴ�.'
as "�л��� Ű�� ������" from student;

-- where ���� Ȱ���Ͽ� ���ϴ� ���Ǹ� ��ȸ�ϱ� 
--select [Į���� �Ǵ� ǥ����]  from [���̺��, ���] where ���ϴ� ����; 

-- emp ���̺��� 10�� �μ��� �ٹ��ϴ� ����� �̸��� �� ��, �μ���ȣ�� ��� 
SELECT ename, sal, deptno from emp where deptno = 10;

-- emp ���̺��� �޿�(sal)�� 4000���� ū ����� �̸��� �޿��� ��� 
select ename, sal from emp where sal > 4000;
 
-- emp ���̺��� �̸��� scott�� ����� �̸��� �����ȣ, �޿��� ���
-- select ename, empno, sal from emp where ename = 'scott'; -- �����Ͱ� ��ȸX
select ename, empno, sal from emp where ename = 'SCOTT';
-- ����Ŭ�� ��ҹ��ڸ� �������� ������, �����ʹ� ��ҹ��ڸ� ������

--���ڿ��� ��¥�� '(Ȭ����ȿ)�� �����־�� ��
--professor���̺��� �Ի����� 1987-01-30�� ���ڵ� ��ȸ
SELECT * from professor where HIREDATE = '1987-01-30';

--�Ǵ�
SELECT * from professor where HIREDATE = '1987/01/30';

--���ǿ��� �پ��� ������ �̿�
/*
�� : =, !=, <, >, <=, >=
�� : and, or, not
���� : between A and B
��� : in(A,B,C)
Ư�� ���� : like
*/

--�� �����ڸ� ����Ͽ� student ���̺��� Ű(height)�� 180cm �� �� ũ�ų� ���� ��� ��� 
 select * from student where height >= 180;
 select * from student where not(height <180);
 
--Between �����ڸ� ����Ͽ� student ���̺��� ������(weight)�� 60~80kg �� 
--����� �̸��� ü�� ��� 
select * from student where weight between 60 and 80;
select * from student where weight >= 60 and weight <= 80;

-- �����԰� 60~80�� �ƴ� ���
select * from student where weight <60 or weight > 80;
select * from student where not(weight between 60 and 80);
select * from student where weight not between 60 and 80;

-- ����, ��¥�� between�� �̿��� �������� ���� �� �ִ�.
--ename�� B~G ������ ��� ��ȸ
select * from emp where ename >= 'B' and ename <='G';
select * from emp where ename between 'B' and 'G';

--ename �� B~G�� �ƴ� ��� ��ȸ
select * from emp where ename not between 'B' and 'G';
select * from emp where not(ename between 'B' and 'G');
select * from emp where ename < 'B' or ename > 'G';

-- employees���� �Ի����� 2005-2006�� ������ ��� ��ȸ
select * from employees where hire_date >= '2005-01-01' and hire_date <= '2006-12-31';
select * from employees where HIRE_DATE between '2005-01-01' and '2006-12-31';

--student���� 4�г��� �ƴ� �л��� ��ȸ
select * from student where grade != 4;

select * from student where grade <> 4;

select * from student where grade ^= 4;

--In �����ڸ� ����Ͽ� student ���̺��� 101�� �а� �л��� 102�� �а� �л����� ��� ���  
 select * from student where DEPTNO1 in(101,102);
 select * from student where deptno1 = 101 or deptno1 = 102;

--�а��� 101,102�� �ƴ� �л�
select * from student where deptno1 not in(101,102);

--Like �����ڸ� ����Ͽ� student ���̺��� ���� "��"���� ����� ��ȸ
select * from student where NAME like '��%';

-- �̸��� ���� ������ ��� ��ȸ
select * from student where name like '%��';

-- �̸��� �簡 ���Ե� ��� ��ȸ
select * from student where name like '%��%';

/*
like�� �Բ� ����� �� �ִ� wild card : %, _
1) % : ���ڼ� ���� ���� � ���ڰ� �͵� ��, ���ڰ� �� �͵� ��
2) _ : ���ڼ��� �� ���ڸ� �� �� �ְ�, � ���ڰ� �͵� ��
        �ݵ�� �� ���ڰ� �;� ��

*/

select * from student where id like '%in%'; -- in�� ���Ե� ��
select * from student where id like '_in__'; -- in �տ� �ѱ���, �ڿ� 2���� �;��ϴ� ��

select * from employees where job_id like '%PR_%'; --PR�ڿ� �ѱ��ڰ� ���;���
select * from employees where job_id like '%PR\_%' escape '\'; -- PR_(�����) ����

--job_id�� SA_�� �����ϰ� �ڿ� 3���ڰ� ������ �� ��ȸ
select * from employees where job_id like 'SA\____' escape '\';

--�̸��� ������� ��� ��ȸ
select * from student where name = '�����';
-- ���� �躸�� ũ�ų� ���� ����� ��ȸ
select * from student where name >= '��';

/*
null : ����Ŭ�� ������ ���� �� �� ������ � ������ �𸥴ٴ� �ǹ�
        �����Ͱ� ������ �ǹ���, ���� ���ǵ��� ���� ������ ��
null ���� � ������ �����ص� ������� �׻� null �� ����

null ���� = ������ ����� �� ����
=> is null, is not null ���
*/
--professor ���̺��� bonus�� null�� ������ ��ȸ
select * from professor where bonus is null;

SELECT * from professor where bonus is not null;

--�˻� ������ 2�� �̻��� ���
--�� ������ �켱 ���� () > not > and > or

-- student ���̺��� ����Ͽ� 4�г� �߿��� Ű�� 170cm �̻��� ��� �� �̸��� �г�, Ű�� ��ȸ
select * from student;
select name, grade, height from student where grade = 4 and height >= 170;
-- student ���̺��� ����Ͽ� 1�г��̰ų� �Ǵ� �����԰� 80kg �̻��� �л����� �̸��� �г�, Ű, �����Ը� ��ȸ 
select name, grade, weight from student
where grade = 1 or weight >= 80;
 
-- student ���̺��� ����Ͽ� 2�г� �߿��� Ű�� 180cm ���� ũ�鼭 
-- �����԰� 70kg ���� ū �л����� �̸��� �г�, Ű�� �����Ը� ��ȸ 
select name, grade, height, weight from student
where grade = 2 and weight > 70 and height > 180;

-- student ���̺��� ����Ͽ� 2�г� �л� �߿��� Ű�� 180cm ���� ũ�ų� 
-- �Ǵ� �����԰� 70kg ���� ū �л����� �̸��� �г�, Ű, �����Ը� ��ȸ
select name, grade, height, weight from student
where grade = 2 and (height > 180 or weight > 80);

--�ǽ�> professor ���̺��� �������� �̸��� ��ȸ�Ͽ� �� �κп� '��'�� ���Ե� ����� ����� ��� 
select * from professor;
SELECT name from professor where name >= '��' and name < '��';
SELECT name from professor where name between '��' and '��';

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
select name, height from student order by height;
select name "�̸�", height from student order by "�̸�"; -- ��Ī���ε� ����

-- student ���̺��� ����Ͽ� 1�г� �л��� �̸���  Ű, �����Ը� ���. 
-- ��, Ű�� ���� ������� ����ϰ� �����Դ� ���� ������� ��� 
select name, height, weight from student order by height, weight desc;
-- Ű�� ���� ��쿡�� �ι�° ���� �÷��� ������ ������������ ������
select name, height, weight from student order by 2, 3 desc;
-- ���ڸ� �̿��ϸ� �ι�° �÷�, 3��° �÷����� �����Ѵٴ� ��

-- student ���̺��� ����Ͽ� 1�г� �л��� �̸���  ����, Ű, �����Ը� ���. 
-- ��, ������ ���� ��� ������� ���� 
select name, BIRTHDAY, height, weight from student order by birthday;
 
-- student ���̺��� ����Ͽ� 1�г� �л��� �̸��� Ű�� ���. ��, �̸� �� ������������ ���� 
select name, height from student where grade = 1 order by name;

select * from employees;
-- [�ǽ�]employees ���̺��� ������̵�, �̸� - ��(�� : Steven-King), �Ի���, �⺻��(salary), 
-- ����(salary*commission_pct), �޿�(salary+����) ��ȸ�ϱ�(����÷��� ��Ī ���)
select 
    EMPLOYEE_ID "��� ���̵�", FIRST_NAME || '-' || LAST_NAME �̸�, 
    HIRE_DATE �Ի���, SALARY �⺻��, SALARY*COMMISSION_PCT ����, 
    SALARY+SALARY*COMMISSION_PCT �޿� 
from employees;

--
select * from set1; -- 1:AAA, 1:AAA, 2:BBB
select * from set2; -- 2:BBB:20, 3:CCC:15, 3:CCC:23

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
select id1, name1 from set1
union
select id2, name2 from set2; -- AAA,BBB,CCC => �ߺ����ŵ�

-- union all
select id1, name1 from set1
union all
select id2, name2 from set2; -- AAA,AAA,BBB,BBB,CCC,CCC => �ߺ����žȵ�

--�а��� 101�� ������ �л� ��� ��ȸ
select '[����]' as "����", profno ��ȣ, name, id, hiredate, deptno
from professor
where deptno=101
union
select '[�л�]' as "����", studno ��ȣ, name, id, birthday, deptno2
from student
where deptno1=101;

-- intersect
select id1, name1 from set1
intersect
select id2, name2 from set2; -- BBB <= ������, �ߺ����ŵ�

-- minus
select id1, name1 from set1
minus
select id2, name2 from set2; -- AAA <= ������, �ߺ����ŵ�

select id2, name1 from set2
minus
select id1, name2 from set1; -- CCC <= ������, �ߺ����ŵ�

--product ���̺��� ��� �÷� �������� ? 
select * from product;
--dept  ���̺��� ��� �÷� �������� ? 
select * from dept;
--student ���̺��� �Ϻ� �÷��� �������� 
select id, name "�л� �̸�", birthday from student;

-- professor ���̺��� ��� �÷��� ��ȸ�ϴµ�, name �� ���������� ��ȸ�ϱ� ? 
--���� : position �� ���������� �� �͸� ��ȸ ? 
select * from professor where position='������' order by name desc;

--2. department ���̺��� deptno, dname, build �÷��� ��ȸ ? 
--���� : �а�(dname)�� �����С��̶�� �ܾ �� �а����� ��ȸ �ϱ� ? 
--���� : dname ������ ������������ ���� ? 
select deptno, dname, build
from department
where dname like '%����%' order by dname;

--3. emp2 ���̺��� name, emp_type, tel, pay, position �÷��� ��ȸ�ϵ�, 
--position �÷��� �÷������� ���������� ��Ÿ���� ?
-- ���� : pay�� 3000�������� 5000������ �͵鸸 ��ȸ�ϱ� 
select name, emp_type, tel, pay, position ����
from emp2
where pay between 30000000 and 50000000;

-- 4. emp2 ���̺��� name, emp_type, tel, birthday �÷��� ��ȸ�ϵ�, 
--���� ���ǿ� �´� �����͸� ��ȸ ? 
--���� : ����(birthday)�� 1980�⵵ �� �͵鸸 ��ȸ�ϱ�(between �̿�) 
select name, emp_type, tel, birthday
from emp2
where birthday 
between '1980-01-01' 
and '1980-12-31';

--5. gift ���̺��� ��� �÷��� ��ȸ�ϵ� ? 
--���� : gname�� ����Ʈ����� �ܾ �� ���ڵ常 ��ȸ�ϱ� 
select * from gift
where gname like '%��Ʈ%';

--6. emp2 ���̺��� name, position, hobby, birthday �÷��� ��ȸ�ϵ� ? 
--���� : position �� null �� �ƴ� �͸� ��ȸ ? ����(birthday) ������ ������������ ���� 
select name, position, hobby, birthday
from emp2
where position is not null
order by birthday;

--7. emp2 ���̺��� ��� �÷��� ��ȸ�ϵ� ? 
--���� ? emp_type�� �����������̰ų� ����������� �͸� ��ȸ(in �̿�) 
select * from emp2
where emp_type in('������','�����');
--8. emp2 ���̺��� emp_type, position �÷��� ��ȸ�ϵ� ? 
-- �ߺ��� ��(���ڵ�)�� ���� 
select distinct emp_type, position from emp2;

-----------------------------------20.04.17�ݿ���

