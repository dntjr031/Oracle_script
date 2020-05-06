/* Formatted on 2020/05/06 오전 10:44:18 (QP5 v5.360) */
--3강_sql그룹함수.sql
--20-04-20 월

--복수행함수(그룹함수)

SELECT SUM (pay) FROM professor;

SELECT * FROM professor;

--count() : 입력되는 데이터의 건수를 리턴
--그룹함수는 null을 제외하고 계산함

SELECT COUNT (*), COUNT (bonus), COUNT (hpage), COUNT (name) FROM professor;                                                                                                                                                                        --=> bonus, hpage의 건수는 null이 제외된 건수

--sum() : 합계를 구하는 함수

/*
문자, 날짜는 sum, avg() 함수를 사용할 수 없다(연산불가)
count함수는 모두 사용 가능
*/

SELECT SUM (pay),
       SUM (bonus),
       COUNT (pay),
       COUNT (bonus),
       COUNT (*)
  FROM professor;

--select sum(name) from professor; => error

--avg() : 평균을 구하는 함수

SELECT AVG (pay),
       SUM (pay),
       COUNT (pay),
       COUNT (*),
       AVG (bonus),
       SUM (bonus),
       COUNT (bonus),
       COUNT (*),
       SUM (bonus) / COUNT (bonus),
       SUM (bonus) / COUNT (*),
       AVG (NVL (bonus, 0))
  FROM professor;

/*
그룹함수는 null을 제외하고 연산하므로, avg()는 정상적인 결과값이 나오지 않음
=> nvl() 함수를 이용하여 처리
=> avg(nvl(컬럼,0))
*/

--max() : 최대값
--min() : 최소값

SELECT MAX (pay), MIN (pay), MAX (bonus), MIN (bonus) FROM professor;

--문자, 날짜도 최대값, 최소값을 구할 수 있다.(대소 비교가 가능하므로)

SELECT MAX (name), MIN (name), MAX (hiredate), MIN (hiredate) FROM professor;

--중복값을 제외한 건수 : count(distinct 컬럼명)

SELECT COUNT (grade), COUNT (*), COUNT (DISTINCT grade) FROM student;

/*
sum(distinct 컬럼명) - 중복값을 제외한 합계
avg(distinct 컬럼명) - 중복값을 제외한 평균
max(distinct 컬럼명) - 중복값을 제외한 최대값
min(distinct 컬럼명) - 중복값을 제외한 최소값
*/

--그룹별 집계
--학과별로 교수들의 평균급여를 구하기

SELECT AVG (pay) FROM professor;                                                                                                --전체 교수들의 평균급여

  SELECT deptno, pay
    FROM professor
ORDER BY deptno;                                                                                   -- 학과별로 정렬

  SELECT deptno, AVG (pay)
    FROM professor
GROUP BY deptno
ORDER BY deptno;

/*
group by
- 테이블 전체에 대한 집계를 구하는 것이 아닌, 특정 범위에서의 집계 데이터를 구함
*/
-- 학과별, 직급별 급여의 평균 구하기

  SELECT deptno, position, AVG (NVL (pay, 0))
    FROM professor
GROUP BY deptno, position
ORDER BY deptno, position;

--=> group by 절에 있는 컬럼과 그룹함수만 select절에 올 수 있다.

--group by절에서는 별칭 사용 불가

  SELECT deptno dno, position 직급, AVG (NVL (pay, 0)) "평균급여"
    FROM professor
GROUP BY dno, position                                                -- error
ORDER BY deptno, position;

--학과별 평균 급여를 구한 후, 평균 급여가 450초과인 부서의 부서번호와 평균급여구하기

  SELECT deptno, AVG (NVL (pay, 0))
    FROM professor
--where avg(nvl(pay,0)) > 400=>error : group function is not allowed here
GROUP BY deptno
  HAVING AVG (NVL (pay, 0)) > 450;

/*
having
- group by의 결과 내에서 특정 조건을 만족하는 것을 구하려면 having을 이용
- group by절에 의해 출력된 결과에 대한 조건을 정의
- group by된 결과를 제한하고자 할 때 사용

group by 칼럼
having 조건
*/

--Student 테이블에서 grade별로 weight, height의 평균, 최대값 구하기 

  SELECT grade,
         AVG (NVL (weight, 0))     "무게 평균",
         AVG (NVL (height, 0))     "키 평균",
         MAX (weight)              "무게 최대값",
         MAX (height)              "키 최대값"
    FROM student
GROUP BY grade;

--2번의 결과에서 키의 평균이 170 이하인 경우 구하기

  SELECT grade,
         AVG (NVL (weight, 0))     "무게 평균",
         AVG (NVL (height, 0))     "키 평균",
         MAX (weight)              "무게 최대값",
         MAX (height)              "키 최대값"
    FROM student
GROUP BY grade
  HAVING AVG (NVL (height, 0)) <= 170;

--emp2 에서 position 별 pay의 합계, 평균 구하기
--그 결과에서 평균이 5000만원 이상인 경우 구하기

  SELECT position,
         SUM (NVL (pay, 0))     "pay 합계",
         AVG (NVL (pay, 0))     "pay 평균"
    FROM emp2
GROUP BY position
  HAVING AVG (NVL (pay, 0)) >= 50000000;

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

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "평균 급여"
    FROM professor
GROUP BY deptno
ORDER BY deptno;

--rollup()이용

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "평균 급여"
    FROM professor
GROUP BY ROLLUP (deptno)
ORDER BY deptno;

--cube()이용

  SELECT deptno, ROUND (AVG (NVL (pay, 0)), 1) "평균 급여"
    FROM professor
GROUP BY CUBE (deptno)
ORDER BY deptno;

--group by한 컬럼이 2개인 경우
--학과별, 직급별 평균 급여

  SELECT deptno, position, AVG (NVL (pay, 0)) "평균 급여"
    FROM professor
GROUP BY deptno, position
ORDER BY deptno, position;

--rollup()

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 1) "평균 급여"
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--=> 학과별, 전체 소계가 추가됨

--cube()

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 1) "평균 급여"
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--=> 학과별, 직급별, 전체 소계가 추가됨

-- group by한 컬럼이 3개인 경우
--지역별, 부서별, 직군별 평균 급여 구하기

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "인원수",
         AVG (NVL (SALARY, 0))       "평균 급여"
    FROM emp_details_view
GROUP BY CITY, DEPARTMENT_name, JOB_ID
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--rollup()

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "인원수",
         AVG (NVL (SALARY, 0))       "평균 급여"
    FROM emp_details_view
GROUP BY ROLLUP (CITY, DEPARTMENT_name, JOB_ID)
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--=> 컬럼의 개수+1개의 소계가 만들어짐
--예) rollup(a,b,c) => (a),(a,b),(a,b,c),() => 3+1 => 4개의 소계가 만들어짐

--cube() 

  SELECT CITY,
         DEPARTMENT_name,
         JOB_ID,
         COUNT (NVL (salary, 0))     "인원수",
         AVG (NVL (SALARY, 0))       "평균 급여"
    FROM emp_details_view
GROUP BY CUBE (CITY, DEPARTMENT_name, JOB_ID)
ORDER BY CITY, DEPARTMENT_name, JOB_ID;

--=> 2의 컬럼승 개의 소계가 만들어짐
--예) rollup(a,b,c) => (a),(b),...,(a,b,c),() => 2의 3승 => 8개의 소계가 만들어짐

--2020-04-21 화요일

/*
grouping 함수
- rollup함수와 cube 함수와 함께 사용되는 함수로 어떤 칼럼이 해당 grouping작업에
  사용 되었는지 아닌지를 구별해주는 역할을 함
- 어떤 칼럼이 grouping 작업에 사용되었으면 0을 반환하고, 사용되지 않았으면 1을 반환
- 소계에 대한 요약 정보를 줄 때 사용
*/

--group by한 컬럼이 1개인 경우
--rollup

  SELECT deptno                            학과,
         ROUND (AVG (NVL (pay, 0)), 1)     "평균급여",
         GROUPING (deptno)
    FROM professor
GROUP BY ROLLUP (deptno)
ORDER BY deptno;

-- cube

  SELECT deptno                            학과,
         ROUND (AVG (NVL (pay, 0)), 1)     "평균급여",
         GROUPING (deptno)
    FROM professor
GROUP BY CUBE (deptno)
ORDER BY deptno;

--group by 한 컬럼이 2개인 경우
--rollup

  SELECT deptno                            학과,
         position                          직급,
         ROUND (AVG (NVL (pay, 0)), 1)     "평균급여",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--cube

  SELECT deptno                            학과,
         position                          직급,
         ROUND (AVG (NVL (pay, 0)), 1)     "평균급여",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

-- decode 이용

  SELECT deptno
             학과,
         DECODE (GROUPING (position), 0, position, '학과별 소계')
             직급,
         ROUND (AVG (NVL (pay, 0)), 1)
             "평균급여",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

  SELECT DECODE (GROUPING (deptno), 1, '[전체]', deptno)
             학과,
         DECODE (
             GROUPING (position),
             0, position,
             DECODE (GROUPING (deptno), 0, '학과별 소계', '[총 합계]'))
             직급,
         ROUND (AVG (NVL (pay, 0)), 1)
             "평균급여",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--cube

  SELECT DECODE (
             GROUPING (deptno),
             1, DECODE (GROUPING (position),
                        0, '[직급별 소계]',
                        '[전체]'),
             deptno)                      학과,
         DECODE (
             GROUPING (position),
             1, DECODE (GROUPING (deptno),
                        0, '[학과별 소계]',
                        '[총 합계]'),
             position)                    직급,
         ROUND (AVG (NVL (pay, 0)), 1)    "평균급여",
         GROUPING (deptno),
         GROUPING (position)
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--grouping sets
--원하는 집계만 수행할 수 있다.
--그룹핑 조건이 여러 개일 경우 유용하게 사용

--예) STUDENT 테이블에서 학년별로 학생들의 인원수 합계와 학과별로 인 원수의 합계를 구해야 하는 경우에 
--기존에는 학년별로 인원수 합계를 구하 고 별도로 학과별로 인원수 합계를 구한 후 UNION 연산을 했음 

  SELECT grade, COUNT (*)
    FROM student
GROUP BY grade
UNION
  SELECT deptno1, COUNT (*)
    FROM student
GROUP BY deptno1;

--grouping sets 이용
--원래 그룹

  SELECT grade, deptno1, COUNT (*)
    FROM student
GROUP BY grade, deptno1
ORDER BY grade, deptno1;

--grouping sets

  SELECT grade, deptno1, COUNT (*)
    FROM student
GROUP BY GROUPING SETS ((grade), (deptno1), (  ))
ORDER BY grade, deptno1;

--rollup

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) 급여
    FROM professor
GROUP BY ROLLUP (deptno, position)
ORDER BY deptno, position;

--grouping sets을 이용한 rollup과 동일한 상황

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) 급여
    FROM professor
GROUP BY GROUPING SETS ((deptno, position), (deptno), (  ))
ORDER BY deptno, position;

--cube

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) 급여
    FROM professor
GROUP BY CUBE (deptno, position)
ORDER BY deptno, position;

--grouping sets을 이용한 cube와 동일한 상황

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) 급여
    FROM professor
GROUP BY GROUPING SETS ((deptno, position),
                        (deptno),
                        (position),
                        (  ))
ORDER BY deptno, position;

--grouping sets을 이용해 내가 원하는데로 출력

  SELECT deptno, position, ROUND (AVG (NVL (pay, 0)), 2) 급여
    FROM professor
GROUP BY GROUPING SETS ((deptno, position), (position))
ORDER BY deptno, position;

--panmae 테이블에서 수량(p_qty)이 3개 이상인 데 이터에 대해 판매일(p_date)별, 판매점(p_store) 별로 
--판매금액(p_total)의 합계 구하기 ? 

  SELECT p_qty                      수량,
         p_date                     판매일,
         p_store                    판매점,
         SUM (NVL (p_total, 0))     판매금액
    FROM panmae
   WHERE p_qty >= 3
GROUP BY p_qty, p_date, p_store
ORDER BY p_qty, p_date, p_store;

--rollup, cube이용하여 소계 출력 ? 

  SELECT p_qty                      수량,
         p_date                     판매일,
         p_store                    판매점,
         SUM (NVL (p_total, 0))     판매금액
    FROM panmae
   WHERE p_qty >= 3
GROUP BY ROLLUP (p_qty, p_date, p_store)
ORDER BY p_qty, p_date, p_store;

  SELECT p_qty                      수량,
         p_date                     판매일,
         p_store                    판매점,
         SUM (NVL (p_total, 0))     판매금액
    FROM panmae
   WHERE p_qty >= 3
GROUP BY CUBE (p_qty, p_date, p_store)
ORDER BY p_qty, p_date, p_store;

--각각의 경우 grouping함수를 이용해서 요약정보 출력하 기(decode()도 이용)

  SELECT DECODE (
             GROUPING (p_qty),
             1, DECODE (
                    GROUPING (p_date),
                    1, DECODE (GROUPING (p_store),
                               1, '[3개 이상]',
                               '[판매점별]'),
                    '[판매일별]'),
             p_qty)                수량,
         DECODE (
             GROUPING (p_date),
             1, DECODE (
                    GROUPING (p_store),
                    1, DECODE (GROUPING (p_qty),
                               1, '[판매금액]',
                               '[수량별]'),
                    '[판매일의 총 합]'),
             p_date)               판매일,
         DECODE (
             GROUPING (p_store),
             1, DECODE (GROUPING (p_date),
                        1, '[총 합]',
                        '[판매점의 총 합]'),
             p_store)              판매점,
         SUM (NVL (p_total, 0))    판매금액,
         GROUPING (p_qty),
         GROUPING (p_date),
         GROUPING (p_store)
    FROM panmae
   WHERE p_qty >= 3
GROUP BY GROUPING SETS ((p_qty, p_date, p_store),
                        (p_qty, p_date),
                        (p_qty, p_store),
                        (p_date, p_store),
                        (p_qty),
                        (p_date),
                        (p_store),
                        (  ))
ORDER BY p_qty, p_date, p_store;

--emp 테이블에서 부서별로 각 직급별 sal의 합계가 몇인 지 계산해서 출력하기
--[1] group by 이용, 세로 출력(기존 방식)

  SELECT DEPTNO, JOB, SUM (NVL (sal, 0))
    FROM emp
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

--[2] job을 가로로 출력하기
--job별 sal의 합계

  SELECT job, SUM (sal), COUNT (*)
    FROM emp
GROUP BY job
ORDER BY job;

--job을 가로로 나열

  SELECT SUM (DECODE (job, 'ANALYST', sal))       ANALYST,
         SUM (DECODE (job, 'CLERK', sal))         CLERK,
         SUM (DECODE (job, 'MANAGER', sal))       MANAGER,
         SUM (DECODE (job, 'PRESIDENT', sal))     PRESIDENT,
         SUM (DECODE (job, 'SALESMAN', sal))      SALESMAN,
         SUM (sal)                                "총 합계"
    FROM emp
ORDER BY deptno;

--deptno별로 group by하고, job을 가로로 출력

  SELECT deptno,
         SUM (DECODE (job, 'ANALYST', sal))       ANALYST,
         SUM (DECODE (job, 'CLERK', sal))         CLERK,
         SUM (DECODE (job, 'MANAGER', sal))       MANAGER,
         SUM (DECODE (job, 'PRESIDENT', sal))     PRESIDENT,
         SUM (DECODE (job, 'SALESMAN', sal))      SALESMAN,
         SUM (sal)                                "부서별 합계"
    FROM emp
GROUP BY deptno
ORDER BY deptno;

--월별 매출(월별로 price의 합계 구하기)
--[1] group by

  SELECT EXTRACT (MONTH FROM REGDATE) 월, SUM (price)
    FROM pd
GROUP BY EXTRACT (MONTH FROM REGDATE)
ORDER BY EXTRACT (MONTH FROM REGDATE);

  SELECT TO_CHAR (REGDATE, 'mm') 월, SUM (price)
    FROM pd
GROUP BY TO_CHAR (REGDATE, 'mm')
ORDER BY TO_CHAR (REGDATE, 'mm');

--[2] 월이 가로로 출력

SELECT SUM (DECODE (EXTRACT (MONTH FROM REGDATE), 3, price))     "3월",
       SUM (DECODE (EXTRACT (MONTH FROM REGDATE), 4, price))     "4월"
  FROM pd;

SELECT SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '01', price))     "1월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '02', price))     "2월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '03', price))     "3월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '04', price))     "4월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '05', price))     "5월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '06', price))     "6월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '07', price))     "7월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '08', price))     "8월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '09', price))     "9월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '10', price))     "10월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '11', price))     "11월",
       SUM (DECODE (TO_CHAR (REGDATE, 'mm'), '12', price))     "12월"
  FROM pd;

-- student 테이블에서 deptno1(학과)별, grade(학년)별 키 (height)의 평균구하기 ? 
--[1] group by 이용 ? 

  SELECT deptno1, grade, AVG (NVL (height, 0)) 평균키
    FROM student
GROUP BY deptno1, grade
ORDER BY deptno1, grade;

--[2] group by, decode 이용-가로, 세로 바꿔서

  SELECT deptno1,
         AVG (DECODE (grade, 1, NVL (height, 0)))     "1학년",
         AVG (DECODE (grade, 2, NVL (height, 0)))     "2학년",
         AVG (DECODE (grade, 3, NVL (height, 0)))     "3학년",
         AVG (DECODE (grade, 4, NVL (height, 0)))     "4학년"
    FROM student
GROUP BY deptno1
ORDER BY deptno1;