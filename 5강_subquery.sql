/* Formatted on 2020/04/22 오후 6:45:58 (QP5 v5.360) */
--5강_subquery.sql
--2020-04-22 수요일

/*
서브쿼리 - 쿼리안에 또 다른 쿼리가 담겨 있는 것

select * from 테이블 -- main query
where 조건 연산자(select 컬럼 from 테이블 where 조건); --subquery

()안에 서브쿼리를 넣는다
*/
--예)emp테이블에서 scott 보다 급여를 많이 받는 사람의 이름과 급여 출력
--1) 먼저 scott의 급여를 구한다

SELECT sal
  FROM emp
 WHERE ename = 'SCOTT';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    -- 3000

--2) 3000보다 많이 받는 직원 조회

SELECT ename, sal
  FROM emp
 WHERE sal > 3000;

--subquery 이용

SELECT ename, sal
  FROM emp
 WHERE sal > (SELECT sal
                FROM emp
               WHERE ename = 'SCOTT');

--subquery 부분은 where절의 연산자 오른쪽에 위치해야 하며 반드시 괄호로 묶어 주어야 함

/*
=> 단일행 서브쿼리 - 서브쿼리의 결과가 하나의 행인 경우
              서브쿼리를 수행한 결과가 1건만 나오고, 이 결과를 main query로 전달해서
              main query를 수행하게 됨
단일행 서브쿼리일 경우 where절에서 사용되는 연산자
( =, !=, >, <, >=, <= )

※ 서브쿼리의 종류
1) 단일행 서브쿼리 - 서브쿼리의 결과가 1개의 행인 경우
2) 다중행 서브쿼리 - 서브쿼리의 결과가 2개의 행 이상인 경우
3) 다중컬럼 서브쿼리 - 서브쿼리의 결과가 여러컬럼인 경우
4) 연관성 있는 서브쿼리(상관관계 서브쿼리) - 메인 쿼리와 서브쿼리가 서로 연관되어 있는 경우
*/

--예제) student 테이블과 department 테이블을 사용하여 이윤나 학생 과 1전공(deptno1)이 
--동일한 학생들의 이름과 1전공 이름을 출력하시오

SELECT * FROM student;

SELECT * FROM department;

SELECT s.name 이름, d.dname 전공명
  FROM student  s
       JOIN department d
           ON     s.deptno1 = d.deptno
              AND deptno1 = (SELECT deptno1
                               FROM student
                              WHERE name = '이윤나');

-- 실습) Professor 테이블에서 입 사일이 송도권 교수보다 나중에 입사한 사람의 이름과 입사일, 학과명을 출력하시오.
-- professor, department테이블 이용

SELECT p.NAME, p.HIREDATE, d.DNAME
  FROM professor  p
       JOIN department d
           ON     p.DEPTNO = d.DEPTNO
              AND p.hiredate > (SELECT hiredate
                                  FROM professor
                                 WHERE name = '송도권');

-- 실습) student 테이블에서 1전 공(deptno1)이 101번인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 
-- 이름과 몸무게를 출력 하시오

SELECT name, weight
  FROM student
 WHERE weight > (SELECT AVG (NVL (weight, 0))
                   FROM student
                  WHERE deptno1 = 101);

--예제) Professor 테이블에서 심슨 교수와 같은 입사일에 입사한 교수 중에서 조인형 교수보다 
--월급을 적게 받는 교수의 이름과 급여, 입사일을 출력하시오
--1)심슨의 입사일

SELECT HIREDATE
  FROM professor
 WHERE name = '심슨';

 --1981/10/23

--2) 조인형의 월급

SELECT PAY
  FROM professor
 WHERE name = '조인형';

 -- 550

--3) subquery

SELECT *
  FROM professor
 WHERE     HIREDATE = (SELECT HIREDATE
                         FROM professor
                        WHERE name = '심슨')
       AND pay < (SELECT PAY
                    FROM professor
                   WHERE name = '조인형');

-- emp2에서 월급이 가장 많은 사원 조회 
--1) pay의 최대값

SELECT MAX (pay) FROM emp2;

--2) subquery

SELECT *
  FROM emp2
 WHERE pay = (SELECT MAX (pay) FROM emp2);

 --dept2에서 부서명도 조회

SELECT e.*, d.DNAME
  FROM emp2  e
       JOIN dept2 d
           ON e.DEPTNO = d.DCODE AND pay = (SELECT MAX (pay) FROM emp2);

--employees 테이블에서 월급이 가장 적은 사원 정보 조회(Department 테이블과 조인해서 부서명도 조회할 것)

SELECT e.*, d.DEPARTMENT_NAME 부서명
  FROM employees  e
       JOIN departments d
           ON     e.DEPARTMENT_ID = d.DEPARTMENT_ID
              AND SALARY = (SELECT MIN (NVL (salary, 0)) FROM employees);

/*
<다중행 서브쿼리>
- 서브쿼리의 결과가 2건 이상 출력되는 경우
- 서브쿼리의 결과가 여러 건 출력되기 때문에 단일행 연산자를 사용할 수 없음

※ 다중 행 서브쿼리 연산자
in - 같은 값을 찾는다(포함한 값)
<ani - 최대값을 반환 
>ani - 최소값을 반환
<all - 최소값을 반환
>all - 최대값을 반환

any - 여러 개 중 아무거나 하나만 조건을 만족해도 된다는 의미
all - 서브쿼리에서 반환되는 모든 row값을 만족해야 함을 의미
*/
--예제) emp2 테이블과 dept2 테 이블을 참조하여 근무지역 (dept2 테이블의 area 칼럼)이 서 울 지사인 
--모든 사원들의 사번과 이름, 부서번호를 출력하시오

SELECT EMPNO, NAME, DEPTNO
  FROM emp2
 WHERE DEPTNO IN (SELECT dcode
                    FROM dept2
                   WHERE area = '서울지사');

--예제) emp2 테이블을 사용하여 전체 직원 중 과장 직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급, 
--연봉을 출력하시오. 단, 연봉 출력형식은 천 단위 구분 기호와 원 표시를 하시오.

SELECT * FROM emp2;

SELECT MIN (pay)
  FROM emp2
 WHERE position = '과장';

 --49000000

SELECT TO_CHAR (pay, '999,999,999') || '원'     연봉
  FROM emp2
 WHERE position = '과장';

 --50000000,56000000,51000000,49000000

SELECT *
  FROM emp2
 WHERE pay > ANY (50000000,
                  56000000,
                  51000000,
                  49000000);

SELECT *
  FROM emp2
 WHERE pay > 50000000 OR pay > 56000000 OR pay > 51000000 OR pay > 49000000;

--단일행 subquery

SELECT *
  FROM emp2
 WHERE pay > (SELECT MIN (pay)
                FROM emp2
               WHERE position = '과장');

--다중행 subquery

SELECT *
  FROM emp2
 WHERE pay > ANY (SELECT pay
                    FROM emp2
                   WHERE position = '과장');

--예제) emp2 테이블을 사용하여 전체 직원 중 과장 직급의 최대 연봉자 보다 연봉이 높은 사람의 
--이름과 직급, 연봉을 출력하시오.

SELECT *
  FROM emp2
 WHERE pay > (SELECT MAX (NVL (pay, 0))
                FROM emp2
               WHERE position = '과장');

SELECT *
  FROM emp2
 WHERE PAY > ALL (SELECT pay
                    FROM emp2
                   WHERE position = '과장');

--근무지역이 경기지사가 아닌 모든 사원들 조회 
-- 다중행

SELECT *
  FROM emp2
 WHERE deptno NOT IN (SELECT dcode
                        FROM dept2
                       WHERE area = '경기지사');

--부서명도 조회

SELECT e.*, d.area
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE
 WHERE deptno NOT IN (SELECT dcode
                        FROM dept2
                       WHERE area = '경기지사');

--loc가 DALLAS 가 아닌 모든 사원 조회 
--단일행

SELECT *
  FROM emp
 WHERE deptno != (SELECT deptno
                    FROM dept
                   WHERE loc = 'DALLAS');

--join 부서명도

SELECT e.*, d.loc
  FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
 WHERE e.deptno != (SELECT deptno
                      FROM dept
                     WHERE loc = 'DALLAS');

--단일행 서브쿼리에서는 != 연산자 이용
--다중행 서브쿼리에서는 not in 연산자 이용

/*
단일행 서브쿼리의 연산자       다중행 서브쿼리의 연산자
    =                      in
    !=                   not in
    >,<            <ani, >ani, <all, >all
*/

--실습)student 테이블을 조회하여 전체 학생 중에서 체중이 4학년 학생 들의 체중에서 
--가장 적게 나가는 학생보다 몸무게가 적은 학생의 이름 과 몸무게를 출력하시오.

SELECT *
  FROM student
 WHERE weight < (SELECT MIN (NVL (weight, 0))
                   FROM student
                  WHERE grade = 4);

SELECT *
  FROM student
 WHERE weight < ALL (SELECT weight
                       FROM student
                      WHERE grade = 4);

--예제) emp2 테이블을 조회하여 각 부서별 평균 연봉을 구 하고 그 중에서 평균 연봉이 
--가장 적은 부서의 평균 연봉보다 적게 받는 직원들의 부서명,직원명, 연봉을 출력하시오.
--1)부서별 평균 연봉

  SELECT AVG (NVL (pay, 0))
    FROM emp2
GROUP BY DEPTNO;

--2) 단일행 subquery

SELECT *
  FROM emp2
 WHERE PAY < (  SELECT MIN (AVG (NVL (pay, 0)))
                  FROM emp2
              GROUP BY DEPTNO);

--3) 다중행 subquery

SELECT *
  FROM emp2
 WHERE PAY < ALL (  SELECT AVG (NVL (pay, 0))
                      FROM emp2
                  GROUP BY DEPTNO);

--employees 에서 job_id별 salary 합계 금액이 30000이상인 job_id에 속하는 사원 조회

SELECT *
  FROM employees
 WHERE job_id IN (  SELECT job_id
                      FROM employees
                  GROUP BY job_id
                    HAVING SUM (NVL (salary, 0)) >= 30000);

/*
<다중칼럼 서브쿼리> - pairwise subquery
- Sub query의 결과가 여러 칼럼인 경우
*/
--예제) student 테이블을 조회하여 각 학년별로 최대 키를 가진 학생들 의 학년과 이름과 키를 출력하시오.
--학년별 최대키 구하기

  SELECT grade, MAX (NVL (height, 0))
    FROM student
GROUP BY grade;

--다중칼럼 서브쿼리

  SELECT grade, name, height
    FROM student
   WHERE (grade, height) IN (  SELECT grade, MAX (NVL (height, 0))
                                 FROM student
                             GROUP BY grade)
ORDER BY grade;

--예제) professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래 된 교수의 
--교수번호와 이름, 입사일, 학과명을 출력하시오. 단 학과이름순으로 오름차순 정렬하시오.
--group by

  SELECT DEPTNO, MIN (HIREDATE)
    FROM professor
GROUP BY DEPTNO;

-- 다중컬럼 서브쿼리

  SELECT p.*, d.DNAME
    FROM professor p JOIN DEPARTMENT d ON p.DEPTNO = d.DEPTNO
   WHERE (p.DEPTNO, HIREDATE) IN (  SELECT DEPTNO, MIN (HIREDATE)
                                      FROM professor
                                  GROUP BY DEPTNO)
ORDER BY d.DNAME;

--실습) emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하시오 . 
--단, 연봉순으로 오름차순 정렬하시오

  SELECT name 사원명, position 직급, pay 연봉
    FROM emp2
   WHERE (POSITION, PAY) IN (  SELECT position, MAX (pay)
                                 FROM emp2
                             GROUP BY position)
ORDER BY pay;


-- position이 null인 경우도 조회

  SELECT name 사원명, NVL (position, '신입') 직급, pay 연봉
    FROM emp2
   WHERE (NVL (POSITION, '신입'), PAY) IN
             (  SELECT NVL (position, '신입'), MAX (pay)
                  FROM emp2
              GROUP BY position)
ORDER BY pay;

--부서번호별로 기본급이 최대인 사원과 기본급이 최소인 사원 조회하기
--employees 이용
--부서가 null인 경우도 조회되도록
--1)최대

  SELECT NVL (DEPARTMENT_ID, '0'), MAX (SALARY)
    FROM employees
GROUP BY DEPARTMENT_ID;

--2)최소

  SELECT NVL (DEPARTMENT_ID, '0'), MIN (SALARY)
    FROM employees
GROUP BY DEPARTMENT_ID;

--3)다중컬럼 서브쿼리

  SELECT FIRST_NAME, NVL (DEPARTMENT_ID, '-10') 부서번호, SALARY
    FROM employees
   WHERE    (NVL (DEPARTMENT_ID, '-10'), SALARY) IN
                (  SELECT NVL (DEPARTMENT_ID, '-10'), MAX (SALARY)
                     FROM employees
                 GROUP BY DEPARTMENT_ID)
         OR (NVL (DEPARTMENT_ID, '-10'), SALARY) IN
                (  SELECT NVL (DEPARTMENT_ID, '-10'), MIN (SALARY)
                     FROM employees
                 GROUP BY DEPARTMENT_ID)
ORDER BY 부서번호;

/*
<상호 연관 서브 쿼리(연관성 있는 서브퀄, 상관관계 서브쿼리)>
- 서브쿼리가 메인 쿼리에 독립적이지 않고, 연관관계 즉 조인을 통해 연결되어 있는 쿼리를 말함
- 서브쿼리와 메인쿼리 사이에서 조인이 사용
- 메인쿼리의 컬럼이 서브쿼리의 where 조건절에 사용됨

- 메인쿼리 값을 서브쿼리에 주고 서브쿼리를 수행한 후, 그 결과를 다시 메인 쿼리로 반환해서 수행하는 서브 쿼리
*/
--예제) emp2 테이블을 조회하여 직원들 중에서 자신의 직급의 평균 연 봉과 같거나 많이 받는 사람들의 
--이름, 직급, 현재연봉을 출력하시오.

  SELECT name, position, pay
    FROM emp2 a
   WHERE pay >= (SELECT AVG (pay)
                   FROM emp2 b
                  WHERE a.POSITION = b.POSITION)
ORDER BY position;

-- professor 테이블을 조회하여 교수들 중에서 자신의 학과의 평균 급여보다 많이 받는 사람들의 
--이름, 부서, 현재급여를 출력하시오

  SELECT *
    FROM professor a
   WHERE pay > (SELECT AVG (NVL (pay, 0))
                  FROM professor b
                 WHERE a.DEPTNO = b.DEPTNO)
ORDER BY DEPTNO;

--emp에서 사원들 중에 자신의 job의 평균 연봉보다 적거나 같게 받는 사람들 조회

SELECT *
  FROM emp a
 WHERE SAL <= (SELECT AVG (NVL (sal, 0))
                 FROM emp b
                WHERE a.JOB = b.JOB);

-----실습------

--1.job이 MANAGER인 사원들 조회(emp)

SELECT *
  FROM emp
 WHERE empno IN (SELECT empno
                   FROM emp
                  WHERE job = 'MANAGER');

-- 2. job이 Manager인 모든 사원들보다 입사일이 빠른(작은) 사원 데이 터 조회 => all 이용 (emp) ? 

SELECT *
  FROM emp
 WHERE hiredate < ALL (SELECT hiredate
                         FROM emp
                        WHERE job = 'MANAGER');

--3. ALL없이 결과값 출력 <= MIN함수를 써서

SELECT *
  FROM emp
 WHERE hiredate < (SELECT MIN (hiredate)
                     FROM emp
                    WHERE job = 'MANAGER');

--4. sales부서에 근무하는 사원 데이터 조회(emp, dept) ? 

SELECT *
  FROM emp
 WHERE DEPTNO IN (SELECT DEPTNO
                    FROM dept
                   WHERE DNAME = 'SALES');

--5. 평균급여보다 급여를 많이 받는 사원 데이터 가져오기(emp)

SELECT *
  FROM emp
 WHERE sal > (SELECT AVG (NVL (sal, 0)) FROM emp);