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