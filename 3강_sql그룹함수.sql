--3��_sql�׷��Լ�.sql
--20-04-20 ��

--�������Լ�(�׷��Լ�)
select sum(pay) from professor;
select * from professor;

--count() : �ԷµǴ� �������� �Ǽ��� ����
--�׷��Լ��� null�� �����ϰ� �����

select count(*), count(bonus), count(hpage), count(name)
from professor; --=> bonus, hpage�� �Ǽ��� null�� ���ܵ� �Ǽ�

--sum() : �հ踦 ���ϴ� �Լ�
/*
����, ��¥�� sum, avg() �Լ��� ����� �� ����(����Ұ�)
count�Լ��� ��� ��� ����
*/
select sum(pay), sum(bonus), count(pay), count(bonus),
    count(*) from professor;
    
--select sum(name) from professor; => error

--avg() : ����� ���ϴ� �Լ�
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus), count(*),
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus,0))
from professor;
/*
�׷��Լ��� null�� �����ϰ� �����ϹǷ�, avg()�� �������� ������� ������ ����
=> nvl() �Լ��� �̿��Ͽ� ó��
=> avg(nvl(�÷�,0))
*/

--max() : �ִ밪
--min() : �ּҰ�
select max(pay), min(pay), max(bonus), min(bonus) from professor;

--����, ��¥�� �ִ밪, �ּҰ��� ���� �� �ִ�.(��� �񱳰� �����ϹǷ�)
select max(name), min(name), max(hiredate), min(hiredate) from professor;

--�ߺ����� ������ �Ǽ� : count(distinct �÷���)
select count(grade), count(*), count(distinct grade) from student;
/*
sum(distinct �÷���) - �ߺ����� ������ �հ�
avg(distinct �÷���) - �ߺ����� ������ ���
max(distinct �÷���) - �ߺ����� ������ �ִ밪
min(distinct �÷���) - �ߺ����� ������ �ּҰ�
*/

--�׷캰 ����
--�а����� �������� ��ձ޿��� ���ϱ�
select avg(pay) from professor; --��ü �������� ��ձ޿�

select deptno, pay from professor order by deptno; -- �а����� ����

select deptno, avg(pay) from professor group by deptno order by deptno;
/*
group by
- ���̺� ��ü�� ���� ���踦 ���ϴ� ���� �ƴ�, Ư�� ���������� ���� �����͸� ����
*/
-- �а���, ���޺� �޿��� ��� ���ϱ�
select deptno, position, avg(nvl(pay,0)) from professor
group by deptno, position 
order by deptno, position;
--=> group by ���� �ִ� �÷��� �׷��Լ��� select���� �� �� �ִ�.

--group by�������� ��Ī ��� �Ұ�
select deptno dno, position ����, avg(nvl(pay,0)) "��ձ޿�" from professor
group by dno, position -- error
order by deptno, position;

--�а��� ��� �޿��� ���� ��, ��� �޿��� 450�ʰ��� �μ��� �μ���ȣ�� ��ձ޿����ϱ�
select deptno, avg(nvl(pay,0))
from professor
--where avg(nvl(pay,0)) > 400=>error : group function is not allowed here
group by deptno
having avg(nvl(pay,0)) > 450;
/*
having
- group by�� ��� ������ Ư�� ������ �����ϴ� ���� ���Ϸ��� having�� �̿�
- group by���� ���� ��µ� ����� ���� ������ ����
- group by�� ����� �����ϰ��� �� �� ���

group by Į��
having ����
*/

--Student ���̺��� grade���� weight, height�� ���, �ִ밪 ���ϱ� 
select grade, avg(nvl(weight,0)) "���� ���", avg(nvl(height,0)) "Ű ���"
    , max(weight) "���� �ִ밪", max(height) "Ű �ִ밪"
from student
group by grade;
--2���� ������� Ű�� ����� 170 ������ ��� ���ϱ�
select grade, avg(nvl(weight,0)) "���� ���", avg(nvl(height,0)) "Ű ���"
    , max(weight) "���� �ִ밪", max(height) "Ű �ִ밪"
from student
group by grade
having avg(nvl(height,0)) <= 170;

--emp2 ���� position �� pay�� �հ�, ��� ���ϱ�
--�� ������� ����� 5000���� �̻��� ��� ���ϱ�
select position, sum(nvl(pay,0)) "pay �հ�", avg(nvl(pay,0)) "pay ���"
from emp2
group by position
having avg(nvl(pay,0)) >= 50000000;

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
select deptno, round(avg(nvl(pay,0)),1) "��� �޿�"
from professor
group by deptno
order by deptno;

--rollup()�̿�
select deptno, round(avg(nvl(pay,0)),1) "��� �޿�"
from professor
group by rollup(deptno)
order by deptno;

--cube()�̿�
select deptno, round(avg(nvl(pay,0)),1) "��� �޿�"
from professor
group by cube(deptno)
order by deptno;

--group by�� �÷��� 2���� ���
--�а���, ���޺� ��� �޿�
select deptno, position, avg(nvl(pay,0)) "��� �޿�"
from professor
group by deptno, position
order by deptno, position;

--rollup()
select deptno, position, round(avg(nvl(pay,0)),1) "��� �޿�"
from professor
group by rollup(deptno, position)
order by deptno, position;
--=> �а���, ��ü �Ұ谡 �߰���

--cube()
select deptno, position, round(avg(nvl(pay,0)),1) "��� �޿�"
from professor
group by cube(deptno, position)
order by deptno, position;
--=> �а���, ���޺�, ��ü �Ұ谡 �߰���

-- group by�� �÷��� 3���� ���
--������, �μ���, ������ ��� �޿� ���ϱ�
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "�ο���"
    , avg(nvl(SALARY,0)) "��� �޿�"
from emp_details_view
group by CITY, DEPARTMENT_name, JOB_ID
order by CITY, DEPARTMENT_name, JOB_ID;

--rollup()
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "�ο���"
    , avg(nvl(SALARY,0)) "��� �޿�"
from emp_details_view
group by rollup(CITY, DEPARTMENT_name, JOB_ID)
order by CITY, DEPARTMENT_name, JOB_ID;
--=> �÷��� ����+1���� �Ұ谡 �������
--��) rollup(a,b,c) => (a),(a,b),(a,b,c),() => 3+1 => 4���� �Ұ谡 �������

--cube() 
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "�ο���"
    , avg(nvl(SALARY,0)) "��� �޿�"
from emp_details_view
group by cube(CITY, DEPARTMENT_name, JOB_ID)
order by CITY, DEPARTMENT_name, JOB_ID;
--=> 2�� �÷��� ���� �Ұ谡 �������
--��) rollup(a,b,c) => (a),(b),...,(a,b,c),() => 2�� 3�� => 8���� �Ұ谡 �������

--�ǽ�
--1.  emp���̺��� �μ��� �޿��� ���� ���ϱ�.
select deptno, sum(nvl(SAL,0)) 
from emp
group by DEPTNO 
order by deptno;

--2. emp ���̺��� job���� �޿��� �հ� ���ϱ�.
select JOB, sum(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--3. emp ���̺��� job���� �ְ� �޿� ���ϱ�
select JOB, max(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--4. emp ���̺��� job���� ���� �޿� ���ϱ�
select JOB, min(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--1. emp ���̺��� job���� �޿��� ��� ���ϱ� ? �Ҽ����� 2�ڸ��� ǥ��
select JOB, round(avg(nvl(SAL,0)),2) 
from emp
group by JOB  
order by JOB;

--4.  emp2 ���̺��� emp_type���� pay�� ����� ���� ���¿��� 
--��� ������ 3 õ���� �̻��� ����� emp_type �� ��� ������ �о����
select emp_type, avg(nvl(pay,0))
from emp2
group by emp_type
having avg(nvl(pay,0)) >= 30000000
order by emp_type;

--5. emp2�� �ڷḦ �̿��ؼ� ����(position)���� ���(empno)�� ���� ���� ��� �� ���ϰ� 
--�� ��� ������ ����� 1997�� �����ϴ� ��� ���ϱ� (����� �ִ밪), like �̿�
select position, max(empno)
from emp2
group by position
having substr(max(empno),1,4) = '1997'
order by position;

--6. emp ���̺��� hiredate�� 1982�� ������ ����� �߿��� deptno��, 
--job�� sal�� �հ踦 ���ϵ� �� ��� ������ �հ谡 2000 �̻��� ����� ��ȸ
select deptno, job, sum(nvl(sal,0))
from emp
where hiredate < '1982-01-01'
group by deptno, job
having sum(nvl(sal,0)) >= 2000;