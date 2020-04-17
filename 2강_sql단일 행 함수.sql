--2강_단일 행 함수.sql 
--2020.04.17 금요일
/*
단일행 함수 - 입력되는 데이터의 종류에 따라
[1] 문자함수 - 입력되는 값(매개변수)이 문자인 함수
[2] 숫자함수
[3] 날짜함수
[4] 형변환 함수
[5] 일반함수
*/
 
-- [1] 문자함수
-- initcap() - 영문 첫글자만 대문자로 바꾼다.
select id, initcap(id) from student;

select 'pretty girl', initcap('pretty girl') from dual;
-- 공백 뒤의 문자도 대문자로 바꿔줌

--upper() - 대문자로 변환
--lower() - 소문자로 변환
select id, initcap(id), upper(id), lower(id) from student;

select lower('JAVA') from dual;

select * from emp where ename='SCOTT';

select * from emp where lower(ename)='scott';