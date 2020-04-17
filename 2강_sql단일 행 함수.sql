--2��_���� �� �Լ�.sql 
--2020.04.17 �ݿ���
/*
������ �Լ� - �ԷµǴ� �������� ������ ����
[1] �����Լ� - �ԷµǴ� ��(�Ű�����)�� ������ �Լ�
[2] �����Լ�
[3] ��¥�Լ�
[4] ����ȯ �Լ�
[5] �Ϲ��Լ�
*/
 
-- [1] �����Լ�
-- initcap() - ���� ù���ڸ� �빮�ڷ� �ٲ۴�.
select id, initcap(id) from student;

select 'pretty girl', initcap('pretty girl') from dual;
-- ���� ���� ���ڵ� �빮�ڷ� �ٲ���

--upper() - �빮�ڷ� ��ȯ
--lower() - �ҹ��ڷ� ��ȯ
select id, initcap(id), upper(id), lower(id) from student;

select lower('JAVA') from dual;

select * from emp where ename='SCOTT';

select * from emp where lower(ename)='scott';

--length(), lengthb() - ���ڿ��� ���̸� �������ִ� �Լ�
--lengthb() - ���ڿ��� ����Ʈ���� ����(�ѱ� 1���ڴ� 2����Ʈ�� 3����Ʈ�� ó��)
--express ������ 3����Ʈ�� ó��

select name, id, length(name) "�̸��� ����", lengthb(name) "�̸� ����Ʈ��"
    , length(id) "id ����", lengthb(id) "id�� ����Ʈ��"
from student;

--concat(���ڿ�, ���ڿ�) - �� ���ڿ��� ������ �ִ� �Լ�
-- 3�� �̻��� ���ڿ��� �����Ϸ��� || ������ �̿�
select name || position as "���� �̸�", concat(name, position) as "concat�̿�",
    name || ' ' || position as "|| ������ �̿�"
from professor;

--select concat(naem,' ', position) from professor; -- error

--substr() - ���ڿ����� Ư�� ������ ���ڿ��� ������ �� ���
/*
substr(���ڿ�, ������ġ, ������ ���ڼ�)
-������ġ�� -(����)�� �ϸ� �ڿ������� �ڸ����� �����
*/
select substr('abcdefghi', 2, 3),
    substr('abcdefghi', 6),
    substr('abcdefghi', -5, 2) 
from dual;
--bcd, fghi, ef
--2��° ��ġ���� 3�� ����
-- 6��° ��ġ���� ������ ����
-- �ڿ��� 5��° ��ġ���� 2�� ����

select substr('java����Ŭ',5,2),
    substr('java����Ŭ',3,3),
    substr('java����Ŭ',6),
    substr('java����Ŭ',-3,1)
from dual;
--����, va��, ��Ŭ, ��

--ĳ���ͼ� Ȯ��
select  parameter, value from nls_database_parameters
where parameter like '%CHAR%';

--student ���̺��� JUMIN Į���� ����Ͽ� 1������ 101 ���� �л����� �̸��� ��������� ��� 
select name, substr(jumin,1,6) ������� from student where deptno1=101;

-- student ���̺��� JUMIN Į���� ����Ͽ� �¾ ���� 8���� ����� �̸��� ��������� ��� 
select name, substr(jumin,1,6) ������� from student 
where substr(jumin,3,2)=8;

--substrb()
select name, substr(name,1,2), substrb(name,1,3) from student;

--instr()- �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
--instr(���ڿ�, ã�� ����)
--instr(���ڿ�, ã�� ����, ������ġ, ���°����)
--���°�� �⺻���� 1

select 'A*B*C*', instr('A*B*C*', '*'), instr('A*B*C*', '*',3)
    , instr('A*B*C*', '*',3,2) from dual;
--2,4,6
--�տ������� ���� ó�� ������ *�� ��ġ(����Ŭ������ ��ġ���� 1���� ����)
--3��° ��ġ ���Ŀ� ó�� ������ *�� ��ġ
--3��° ��ġ ���Ŀ� 2��°�� ������ *�� ��ġ

select 'A*B*C*', instr('A*B*C*', '*',-1), instr('A*B*C*', '*',-2)
    , instr('A*B*C*', '*',-2,2), instr('A*B*C*', '*',-3,2) 
    , instr('A*B*C*', '*',-3,4)from dual;
--6,4,2,2,0
--�ڿ��� ù��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� ó�� ������ *�� ��ġ
--�ڿ��� 2��° ��ġ ���� �� ��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� �� ��°�� ������ *�� ��ġ
--�ڿ��� 3��° ��ġ ���� �� ��°�� ������ *�� ��ġ => ������ 0����

--student ���̺��� TEL Į���� ����Ͽ� �л��� �̸��� ��ȭ��ȣ, ')'�� ������ ��ġ�� ��� 
select name, tel, instr(tel, ')') from student;

-- student ���̺��� �����ؼ� 1������ 101���� �л��� �̸��� �� ȭ��ȣ�� ������ȣ�� ���. 
--��, ������ȣ�� ���ڸ� ���;� �� 
select name, tel, substr(tel, 1, instr(tel,')')-1) ������ȣ from STUDENT 
where deptno1=101;

--���ϸ� �����ϱ�
create table test_file
(
    no number,
    filepath varchar2(100)
);

insert into test_file values(1, 'c:\test\js\example.txt');
insert into test_file values(2, 'd:\css\sample\temp\abc.java');

select * from test_file;

-- ���ϸ� ����
select no, 
    substr(filepath, instr(filepath,'\',-1)+1) ���ϸ�
from test_file;

-- Ȯ���ڸ� ����
select no, 
    substr(filepath, instr(filepath,'.',-1)+1) Ȯ����
from test_file;

--���� ���ϸ� ����
select no, 
    substr(filepath, instr(filepath,'\',-1)+1, 
        instr(filepath, '.',-1)-instr(filepath,'\',-1)-1) "���� ���ϸ�"
from test_file;

--lpad(���ڿ� �Ǵ� �÷���, �ڸ���, ä�﹮��)
--���ڿ��� ���� �ڸ����� ä�� ���ڷ� ä���. ���ʺ��� ä����
--RPAD() - �����ʺ��� ä����

--student ���̺��� 1������ 101���� �а� �л����� ID�� �� 10�ڸ� �� ����ϵ� 
--���� �� �ڸ��� '$'��ȣ�� ä�켼�� 
select name, id, lpad(id, 10, '$') from student where deptno1=101;

-- �ǽ�) DEPT2 ���̺��� ����Ͽ� DNAME�� ���� ����� �������� �� �� �ۼ��ϱ� ? 
--dname�� �� 10����Ʈ�� ����ϵ� ���� dname�� ������ ������ �� �ڸ��� �ش� �� ���� ���ڰ� ������ ��. 
--��, ������� �̸��� �� 6����Ʈ�̹Ƿ� ���ڰ� 1234���� �� ��
select dname, lpad(dname, 10, '1234567890') from dept2;

--student ���̺��� ID�� 12�ڸ��� ����ϵ� ������ �� �ڸ����� '*'�� ȣ�� ä�켼�� 
select name, id, rpad(id,12,'*') from student;

--ltrim(���ڿ��̳� �÷���, ������ ����)
--���ʿ��� �ش� ���ڸ� �����Ѵ�
--������ ���ڸ� �����ϸ� ������ ������

--rtrim() - �����ʿ��� �ش� ���ڸ� ������

select ltrim('javaoracle','j'), ltrim('javaoracle','abcdefghijvw'),
    ltrim('javaoracle','java'), rtrim('javaoracle','oracle'),
    rtrim('javaoracle','abcelmnopqr') , '|' || ltrim('   javaoracle')
    , rtrim('java oracle   ') || '|'
from dual;

 --DEPT2 ���̺��� DNAME�� ����ϵ� ���ʿ� '��'�̶� ���ڸ� ��� �����ϰ� ��� 
select dname, ltrim(dname, '��') from dept2;

 --DEPT2 ���̺��� DNAME�� ����ϵ� ������ ���� '��'��� ���ڴ� �����ϰ� ��� 
select dname, rtrim(dname, '��') from dept2;

--reverse()
--� ���ڿ��� �Ųٷ� �����ִ� ��
select 'oracle', reverse('oracle') 
--reverse('���ѹα�') --�ѱ��� ������
from dual;

--replace(���ڿ��̳� �÷���, ����1, ����2)
--���ڿ����� ����1�� ������ ���� 2�� �ٲپ� ����ϴ� �Լ�

select replace('javajsp','j','J'), replace('javajsp', 'jsp', 'oracle')
from dual;

--student ���̺��� �л����� �̸��� ����ϵ� �� �κ��� '#'���� ǥ �õǰ� ��� 
select name, replace(name, substr(name,1,1), '#') from student;

--�ǽ�) student ���̺��� 1������ 101���� �л����� �̸��� ����� �� 
--��� ���ڸ� '#'���� ǥ�õǰ� ��� 
select name, replace(name, substr(name,2,1),'#') �̸�
from student
where deptno1=101;
 


--[2] ���� �Լ�
--round(����, ���ϴ� �ڸ���) - �ݿø�
select 12345.457, round(12345.457),
    round(12345.457,1),round(12345.457,2),
    round(12345.457,-1),round(12345.457,-2),
    round(12345.457,-3) from dual;
--12345, 12345.5, 12345.46, 12350, 12300, 12000
/*
������ �ݿø�(�Ҽ� ���� ù° �ڸ����� �ݿø�)
1: �Ҽ����� 1�ڸ��� �����(�Ҽ����� ��° �ڸ����� �ݿø�)
2: �Ҽ����� 2�ڸ��� �����
-1: 1���ڸ����� �ݿø�(�ڸ����� ������ ��쿡�� �Ҽ� �̻󿡼� ó��)
-2: 10���ڸ����� �ݿø�
-3: 100���ڸ����� �ݿø�
*/

--trunc(����, ���ϴ� �ڸ���) - ����
select 12345.457, trunc(12345.457),
    trunc(12345.457,1),trunc(12345.457,2),
    trunc(12345.457,-1),trunc(12345.457,-2),
    trunc(12345.457,-3) from dual;
--12345, 12345.4, 12345.45, 12340, 12300, 12000

select first_name, salary, round(salary, -3),
    trunc(salary, -3) from employees; -- 100�� �ڸ����� �ݿø�, ����

--mod(����, ������ ��) - �������� ���ϴ� �Լ�
--ceil(�Ҽ����� �ִ� �Ǽ�) - �ø�(�־��� ���ڿ� ���� ������ ū ���� ���)
--floor(�Ҽ����� �ִ� �Ǽ�) - ����(���� ������ ���� ����)
--power(����1, ����2) - ����1�� ����2��
select mod(13,3), ceil(12.3), floor(17.87), power(3,4) from dual;

--[3] ��¥ �Լ�
--1) ��ĥ ��, ��ĥ ��
/*
���ú��� 100�� ��, 100�� ��
2020-04-17 + 100 => ��¥
2020-04-17 - 100 => ��¥
=> ���ϰ� ���� ������ �ϼ�
*/

--sysdate : �������ڸ� �����ϴ� �Լ�
select sysdate from dual;

select sysdate as ��������, sysdate+100 as "100�� ��",
    sysdate-100 as "100�� ��", sysdate+1 �Ϸ���, sysdate-1 �Ϸ��� from dual;
    
--2�� 1�ð� 5�� 10�� �� ��¥ ���ϱ�
select sysdate ��������, 
    sysdate+2+1/24+5/(24*60)+10/(24*60*60) "2�� 1�ð� 5�� 10�� ��"
from dual;

--3���� �� ��¥, 3������ ��¥
--add_months(��¥, ������) : �ش糯¥�κ��� ������ ��ŭ ���ϰų� �� ��¥�� ���Ѵ�
--=> �� ���� ��, �� ���� ���� �ش��ϴ� ��¥�� ���� �� �ִ�
select sysdate, add_months(sysdate, 3) as "3���� ��",
    add_months(sysdate, -3) "3���� ��" from dual;

--1�� ��, 1�� �� ��¥
select sysdate, add_months(sysdate, 12) as "1�� ��"
    , add_months(sysdate, -12) as "1�� ��" from dual;
    
-- 2�� 4���� 1�� 3�ð� 10�� 20�� ���� ��¥ ���ϱ�
select sysdate, add_months(sysdate, 2*12+4) "2�� 4���� ��",
    add_months(sysdate, 2*12+4) + 1 + 3/24 + 10/(24*60) + 20/(24*60*60)
from dual;

--to_yminterval()
--to_dsinterval()

select sysdate, sysdate+to_yminterval('02-04') "2�� 4���� ��",
    sysdate+to_dsinterval('1 03:10:20') "1�� 3�ð� 10�� 20�� ��",
    sysdate + to_yminterval('02-04') + to_dsinterval('1 03:10:20')
    as "2-4-1 3:10:20��"
from dual;

--2)�� ��¥ ������ ����� �ð�(�ϼ�)
--���� 1/1 ���� ��ĥ ����Ǿ�����
--2020-04-17 - 2020-01-01 => ����
select '2020-04-17' - '2020-01-01' from dual; --error

select to_date('2020-04-17') - to_date('2020-01-01') from dual;
--to_date(����) => ���ڸ� ��¥���·� ��ȯ���ִ� �Լ�

--�������� ���ñ��� ����� �ϼ�, ���ú��� ���ϱ��� ���� �ϼ�
select to_date('2020-04-17') - to_date('2020-04-16') "��������",
    to_date('2020-04-18') - to_date('2020-04-17') "���ϱ���"
from dual;

select sysdate, sysdate - to_date('2020-04-16') "��������",
    to_date('2020-04-18') - sysdate "���ϱ���"
from dual; -- �������ڴ� �ð��� ���ԵǼ� ����� ����� �ٸ�

--�ð��� ������ �� ��¥ ������ �ϼ��� ���ϴ� ���
select sysdate, trunc(sysdate),
    to_date('2020-04-18') - trunc(sysdate) "���ϱ���"
from dual; -- �������ڴ� �ð��� ����
-- trunc(��¥) : �ش� ��¥�� ������(�ð� ����)
-- round(��¥) : �ش� ��¥�� �ݿø��ؼ� ����(���� ����)

--�� ��¥ ������ ���� ��
--months_between() - �� ��¥ ������ �������� ������
select months_between('2020-04-17', '2020-02-17'),
    months_between('2020-04-17', '2020-02-01'),
    months_between('2020-04-17', '2020-02-23')
from dual;

--next_day()
/*
�־��� ��¥�� �������� ���ƿ��� ���� �ֱ� ������ ��¥�� ��ȯ�� �ִ� �Լ�
���ϸ� ��� ���ڸ� �Է��� ���� �ִ�.
1:�� 2:�� ... 7:��
*/
select sysdate, next_day(sysdate,'��'),
    next_day(sysdate,'ȭ����'),
    next_day(sysdate,1),
    next_day('2020-05-01',4)
from dual;

--last_day()
--�־��� ��¥�� ���� ���� ���� ������ ���� ������ִ� �Լ�
select sysdate, last_day(sysdate), last_day('2020-02-10'),
    last_day('2020-08-05'), last_day('2019-02-03')
from dual;

-- trunc(��¥) : �ش� ��¥�� ������(�ð� ����)
-- round(��¥) : �ش� ��¥�� �ݿø��ؼ� ����(���� ����)
-- => �Ѵ� �ð��� ���ܵ�
select sysdate, round(sysdate), trunc(sysdate) from dual;

--����� �Ի��� 50�� ���� ��¥ ���ϱ�
select FIRST_NAME, LAST_NAME, HIRE_DATE, HIRE_DATE+50 "50�� ��" 
from employees; 

--�Ի��� 3���� ���� ��¥ ���ϱ�
select FIRST_NAME, LAST_NAME, HIRE_DATE, add_months(HIRE_DATE,3) "3���� ��" 
from employees; 

--�����ϱ��� ���� �ϼ�
select to_date('2020-08-19') - trunc(sysdate) || '��' "�����ϱ���" from dual;

--�����ϱ��� ���� ������
select months_between(last_day('2020-08-19'), 
    last_day(sysdate)) || '����' "�����ϱ���" 
from dual;

--[4] ����ȯ �Լ�

/*
<����Ŭ�� �ڷ���>
���� - char(����������), varchar2(�⺯ ������)
���� - number
��¥ - date

<����ȯ>
1) �ڵ� ����ȯ
2) ����� ����ȯ
to_char() - ����, ��¥�� ���ڷ�
to_number() - ���ڸ� ���ڷ�
to_date() - ���ڸ� ��¥��
*/

--�ڵ� ����ȯ
select 1+'2', 2+'003' from dual;
-- =>���� ������ ���ڸ� �����ϸ� �ش� ���ڸ� ���ڷ� �ڵ�����ȯ�� �� ������

select '004',1+to_number('2'), 2+to_number('003') from dual;

--(1-1) to_char(��¥, ����) - ��¥�� ���ڷ� ��ȯ�Ѵ�
select sysdate, to_char(sysdate, 'yyyy'), to_char(sysdate,'mm'),
    to_char(sysdate, 'dd'), to_char(sysdate, 'd') ����
from dual;

select sysdate, to_char(sysdate, 'year'), to_char(sysdate,'mon'),
    to_char(sysdate,'month'), to_char(sysdate, 'day'), -- ����(������,ȭ����,...)
    to_char(sysdate, 'dy'), -- ����(��, ȭ,...)
    to_char(sysdate, 'q'), -- �б�
    to_char(sysdate, 'ddd') -- 1�� �� ��ĥ°����
from dual;

select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss am'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss pm day')
from dual;

--Ư�� ��¥���� �⵵�� ����, ���� ����, �ϸ� ����
select extract(year from sysdate) �⵵,
    extract(month from sysdate) ��,
    extract(day from sysdate) ��
from dual;

--�ǽ�) STUDENT ���̺��� birthday Į���� �����Ͽ� ���� �� 3���� �л��� �̸��� birthday�� ��� 
select name, birthday from student where extract(month from birthday)=3;

select name, birthday from student where to_char(birthday, 'mm') = 3;

--(1-2) to_char(����, ����) - ���ڸ� ������ ����� ���ڷ� ��ȯ
/*
9 : �����ڸ��� �������� ä��
0 : �����ڸ��� 0���� ä��
*/

select 1234, to_char(1234, '99999'), to_char(1234,'099999'),
    to_char(1234, '$99999'), to_char(1234, 'L99999'),
    to_char(1234.56, '9999.9'), to_char(1234, '$99,999'),
    to_char(123456789, '999,999,999'),
    to_char(1234.56, '9999')
from dual;

--Professor ���̺��� �����Ͽ� 101�� �а� ������ �� �̸��� ������ ����Ͻÿ�. 
--�� ������ (pay*12)+bonus �� ����ϰ� õ ���� ���б�ȣ�� ǥ���Ͻÿ�
select NAME �̸�, to_char((pay*12)+bonus, '99,999')���� 
from professor 
where DEPTNO=101;

--(2) to_date(����, ����) - ���ڸ� ��¥�� ��ȯ
select to_date('2020-05-09'), to_date('2020-05-09', 'yyyy-mm-dd')
    , to_date('2020/05/09', 'yyyy/mm/dd')
    , to_date('2020-05-09 16:20:35', 'yyyy-mm-dd hh24:mi:ss')
from dual;

select * from professor where hiredate >= '1995-01-01';
select '2020-04-03' - '2020-01-01' from dual; --error
select to_date('2020-04-03') - to_date('2020-01-01') from dual; 

--2020-03-07 ~ 2020-04-16������ ������ ��ȸ
select * from pd 
where regdate 
    between '2020-03-07' 
    and 
    to_date('2020-04-16 23:59:59','yyyy-mm-dd hh24:mi:ss');
    
--������� �� �ð��� �������� ��ȸ
select PDNAME, PRICE, REGDATE, (sysdate - regdate)*24 ����ð� from pd;

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