----과제!

--실습) student 테이블에서 1전공이 101번인 학생들의 이름과 주민번 호를 출력하되 
--주민번호의 뒤 7자리는 '*'로 표시되게 출력 
select name, replace(JUMIN, substr(jumin,7), '*******') from student
where DEPTNO1=101; 
--실습) student 테이블에서 1전공이 102번인 학생들의 이름과 전화번 호, 
--전화번호에서 국번 부분만 '#' 처리하여 출력. 단, 모든 국번은 3자 리로 간주함 
select NAME, TEL, replace(tel, substr(tel,instr(tel,')')+1,3), '###') 
from student
where deptno1=102;

--emp테이블에서 사원의 입사일 90일 후의 날짜? ? 
select HIREDATE+90 from emp;
--emp테이블에서 사원의 입사후 1년이 되는 날짜? ? 
select add_months(HIREDATE, 12) from emp;
--오늘부터 크리스마스까지 남은 일수는? ? 
select to_date('2020-12-25') - trunc(sysdate) from dual;
--오늘부터 크리스마스까지 남은 달수는? (months_between) 
select months_between(to_date('2020-12-25'), trunc(sysdate)) from dual;

-- emp테이블에서 입사한지 오늘까지 몇일 되었나? 
select trunc(sysdate) - HIREDATE from emp; 
--emp테이블에서 입사한지 오늘까지 몇달 되었나? ?
select months_between(trunc(sysdate), hiredate) from emp;
--emp테이블에서 입사한지 오늘까지 몇 년이 되었나? 
select (trunc(sysdate) - HIREDATE)/365 from emp;