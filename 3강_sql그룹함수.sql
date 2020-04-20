--3강_sql그룹함수.sql
--20-04-20 월

--복수행함수(그룹함수)
select sum(pay) from professor;
select * from professor;

--count() : 입력되는 데이터의 건수를 리턴
--그룹함수는 null을 제외하고 계산함

select count(*), count(bonus), count(hpage), count(name)
from professor; --=> bonus, hpage의 건수는 null이 제외된 건수

--sum() : 합계를 구하는 함수
/*
문자, 날짜는 sum, avg() 함수를 사용할 수 없다(연산불가)
count함수는 모두 사용 가능
*/
select sum(pay), sum(bonus), count(pay), count(bonus),
    count(*) from professor;
    
--select sum(name) from professor; => error

--avg() : 평균을 구하는 함수
select avg(pay), sum(pay), count(pay), count(*),
    avg(bonus), sum(bonus), count(bonus), count(*),
    sum(bonus)/count(bonus), sum(bonus)/count(*),
    avg(nvl(bonus,0))
from professor;
/*
그룹함수는 null을 제외하고 연산하므로, avg()는 정상적인 결과값이 나오지 않음
=> nvl() 함수를 이용하여 처리
=> avg(nvl(컬럼,0))
*/

--max() : 최대값
--min() : 최소값
select max(pay), min(pay), max(bonus), min(bonus) from professor;

--문자, 날짜도 최대값, 최소값을 구할 수 있다.(대소 비교가 가능하므로)
select max(name), min(name), max(hiredate), min(hiredate) from professor;

--중복값을 제외한 건수 : count(distinct 컬럼명)
select count(grade), count(*), count(distinct grade) from student;
/*
sum(distinct 컬럼명) - 중복값을 제외한 합계
avg(distinct 컬럼명) - 중복값을 제외한 평균
max(distinct 컬럼명) - 중복값을 제외한 최대값
min(distinct 컬럼명) - 중복값을 제외한 최소값
*/

--그룹별 집계
--학과별로 교수들의 평균급여를 구하기
select avg(pay) from professor; --전체 교수들의 평균급여

select deptno, pay from professor order by deptno; -- 학과별로 정렬

select deptno, avg(pay) from professor group by deptno order by deptno;
/*
group by
- 테이블 전체에 대한 집계를 구하는 것이 아닌, 특정 범위에서의 집계 데이터를 구함
*/
-- 학과별, 직급별 급여의 평균 구하기
select deptno, position, avg(nvl(pay,0)) from professor
group by deptno, position 
order by deptno, position;
--=> group by 절에 있는 컬럼과 그룹함수만 select절에 올 수 있다.

--group by절에서는 별칭 사용 불가
select deptno dno, position 직급, avg(nvl(pay,0)) "평균급여" from professor
group by dno, position -- error
order by deptno, position;

--학과별 평균 급여를 구한 후, 평균 급여가 450초과인 부서의 부서번호와 평균급여구하기
select deptno, avg(nvl(pay,0))
from professor
--where avg(nvl(pay,0)) > 400=>error : group function is not allowed here
group by deptno
having avg(nvl(pay,0)) > 450;
/*
having
- group by의 결과 내에서 특정 조건을 만족하는 것을 구하려면 having을 이용
- group by절에 의해 출력된 결과에 대한 조건을 정의
- group by된 결과를 제한하고자 할 때 사용

group by 칼럼
having 조건
*/

--Student 테이블에서 grade별로 weight, height의 평균, 최대값 구하기 
select grade, avg(nvl(weight,0)) "무게 평균", avg(nvl(height,0)) "키 평균"
    , max(weight) "무게 최대값", max(height) "키 최대값"
from student
group by grade;
--2번의 결과에서 키의 평균이 170 이하인 경우 구하기
select grade, avg(nvl(weight,0)) "무게 평균", avg(nvl(height,0)) "키 평균"
    , max(weight) "무게 최대값", max(height) "키 최대값"
from student
group by grade
having avg(nvl(height,0)) <= 170;

--emp2 에서 position 별 pay의 합계, 평균 구하기
--그 결과에서 평균이 5000만원 이상인 경우 구하기
select position, sum(nvl(pay,0)) "pay 합계", avg(nvl(pay,0)) "pay 평균"
from emp2
group by position
having avg(nvl(pay,0)) >= 50000000;

/*
※ select sql문 실행 순서
5. select 컬럼
1. from 테이블 
2. where 조건
3. group by 컬럼
4. having 조건
6. order by 컬럼 (desc)
*/

--rollup, cube : group by와 함게 사용
--[1] rollup() : 주어진 데이터들의 소계를 구해줌
--group by절에 주어진 조건으로 소계값을 구해줌

--학과별 평균 급여
select deptno, round(avg(nvl(pay,0)),1) "평균 급여"
from professor
group by deptno
order by deptno;

--rollup()이용
select deptno, round(avg(nvl(pay,0)),1) "평균 급여"
from professor
group by rollup(deptno)
order by deptno;

--cube()이용
select deptno, round(avg(nvl(pay,0)),1) "평균 급여"
from professor
group by cube(deptno)
order by deptno;

--group by한 컬럼이 2개인 경우
--학과별, 직급별 평균 급여
select deptno, position, avg(nvl(pay,0)) "평균 급여"
from professor
group by deptno, position
order by deptno, position;

--rollup()
select deptno, position, round(avg(nvl(pay,0)),1) "평균 급여"
from professor
group by rollup(deptno, position)
order by deptno, position;
--=> 학과별, 전체 소계가 추가됨

--cube()
select deptno, position, round(avg(nvl(pay,0)),1) "평균 급여"
from professor
group by cube(deptno, position)
order by deptno, position;
--=> 학과별, 직급별, 전체 소계가 추가됨

-- group by한 컬럼이 3개인 경우
--지역별, 부서별, 직군별 평균 급여 구하기
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "인원수"
    , avg(nvl(SALARY,0)) "평균 급여"
from emp_details_view
group by CITY, DEPARTMENT_name, JOB_ID
order by CITY, DEPARTMENT_name, JOB_ID;

--rollup()
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "인원수"
    , avg(nvl(SALARY,0)) "평균 급여"
from emp_details_view
group by rollup(CITY, DEPARTMENT_name, JOB_ID)
order by CITY, DEPARTMENT_name, JOB_ID;
--=> 컬럼의 개수+1개의 소계가 만들어짐
--예) rollup(a,b,c) => (a),(a,b),(a,b,c),() => 3+1 => 4개의 소계가 만들어짐

--cube() 
select CITY, DEPARTMENT_name, JOB_ID
    , count(nvl(salary,0)) "인원수"
    , avg(nvl(SALARY,0)) "평균 급여"
from emp_details_view
group by cube(CITY, DEPARTMENT_name, JOB_ID)
order by CITY, DEPARTMENT_name, JOB_ID;
--=> 2의 컬럼승 개의 소계가 만들어짐
--예) rollup(a,b,c) => (a),(b),...,(a,b,c),() => 2의 3승 => 8개의 소계가 만들어짐

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