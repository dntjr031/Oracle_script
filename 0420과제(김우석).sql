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