----����!

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� �ֹι� ȣ�� ����ϵ� 
--�ֹι�ȣ�� �� 7�ڸ��� '*'�� ǥ�õǰ� ��� 
select name, replace(JUMIN, substr(jumin,7), '*******') from student
where DEPTNO1=101; 
--�ǽ�) student ���̺��� 1������ 102���� �л����� �̸��� ��ȭ�� ȣ, 
--��ȭ��ȣ���� ���� �κи� '#' ó���Ͽ� ���. ��, ��� ������ 3�� ���� ������ 
select NAME, TEL, replace(tel, substr(tel,instr(tel,')')+1,3), '###') 
from student
where deptno1=102;

--emp���̺��� ����� �Ի��� 90�� ���� ��¥? ? 
select HIREDATE+90 from emp;
--emp���̺��� ����� �Ի��� 1���� �Ǵ� ��¥? ? 
select add_months(HIREDATE, 12) from emp;
--���ú��� ũ������������ ���� �ϼ���? ? 
select to_date('2020-12-25') - trunc(sysdate) from dual;
--���ú��� ũ������������ ���� �޼���? (months_between) 
select months_between(to_date('2020-12-25'), trunc(sysdate)) from dual;

-- emp���̺��� �Ի����� ���ñ��� ���� �Ǿ���? 
select trunc(sysdate) - HIREDATE from emp; 
--emp���̺��� �Ի����� ���ñ��� ��� �Ǿ���? ?
select months_between(trunc(sysdate), hiredate) from emp;
--emp���̺��� �Ի����� ���ñ��� �� ���� �Ǿ���? 
select (trunc(sysdate) - HIREDATE)/365 from emp;