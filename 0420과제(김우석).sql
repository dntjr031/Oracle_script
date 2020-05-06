--실습
--1.  emp테이블의 부서별 급여의 총합 구하기.
select deptno, sum(nvl(SAL,0)) 
from emp
group by DEPTNO 
order by deptno;

--2. emp 테이블의 job별로 급여의 합계 구하기.
select JOB, sum(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--3. emp 테이블의 job별로 최고 급여 구하기
select JOB, max(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--4. emp 테이블의 job별로 최저 급여 구하기
select JOB, min(nvl(SAL,0)) 
from emp
group by JOB  
order by JOB;

--1. emp 테이블의 job별로 급여의 평균 구하기 ? 소수이하 2자리만 표시
select JOB, round(avg(nvl(SAL,0)),2) 
from emp
group by JOB  
order by JOB;

--4.  emp2 테이블에서 emp_type별로 pay의 평균을 구한 상태에서 
--평균 연봉이 3 천만원 이상인 경우의 emp_type 과 평균 연봉을 읽어오기
select emp_type, avg(nvl(pay,0))
from emp2
group by emp_type
having avg(nvl(pay,0)) >= 30000000
order by emp_type;

--5. emp2의 자료를 이용해서 직급(position)별로 사번(empno)이 제일 늦은 사람 을 구하고 
--그 결과 내에서 사번이 1997로 시작하는 경우 구하기 (사번의 최대값), like 이용
select position, max(empno)
from emp2
group by position
having substr(max(empno),1,4) = '1997'
order by position;

--6. emp 테이블에서 hiredate가 1982년 이전인 사원들 중에서 deptno별, 
--job별 sal의 합계를 구하되 그 결과 내에서 합계가 2000 이상인 사원만 조회
select deptno, job, sum(nvl(sal,0))
from emp
where hiredate < '1982-01-01'
group by deptno, job
having sum(nvl(sal,0)) >= 2000;