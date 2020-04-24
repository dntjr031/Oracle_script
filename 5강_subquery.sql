/* Formatted on 2020/04/24 오전 10:43:08 (QP5 v5.360) */
--5강_subquery.sql
--[2020-04-22 수요일]

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
 WHERE ename = 'SCOTT';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 -- 3000

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


 --[2020-04-23 목요일]

 /*
 <exists 연산자>
 - 특저 컬럼값이 존재하는지 여부를 체크
 - 서브쿼리가 반환하는 결과에 메인 쿼리에서 추출될 데이터들이 존재하기만 하면 조건을 만족
 - 성능면에서 in보다 월등히 우수함
 
 ※ in, exists비교
 1) in - 어떤 값에 포함되는지 여부를 체크
        in은 ()에 비교할 값이 올수도 있고, 서브쿼리가 올 수도 있다.
 2) exists - 특정 컬럼값이 존재하는지 여부를 체크
            exists는 오직 서브쿼리만 올 수 있다.
 */

 --부서 테이블의 pdept 값이 null이 아닌 부서에 속하는 사원 추출

SELECT *
  FROM dept2
 WHERE pdept IS NOT NULL;

 --0001을 제외한 모든 부서

 --in 이용

SELECT *
  FROM emp2
 WHERE deptno IN (SELECT dcode
                    FROM dept2
                   WHERE pdept IS NOT NULL);

 --exists 이용

SELECT *
  FROM emp2 e
 WHERE EXISTS
           (SELECT 1
              FROM dept2 d
             WHERE d.pdept IS NOT NULL AND e.DEPTNO = d.DCODE);

-- cf. join

SELECT e.*, d.*
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE AND d.pdept IS NOT NULL;

-- 경기 지사에 속하는 사원들의 정보 조회
--in

SELECT *
  FROM dept2
 WHERE area = '경기지사';

SELECT *
  FROM emp2
 WHERE DEPTNO IN (SELECT dcode
                    FROM dept2
                   WHERE area = '경기지사');

--exists

SELECT *
  FROM emp2 e
 WHERE EXISTS
           (SELECT 1
              FROM dept2 d
             WHERE e.DEPTNO = d.DCODE AND area = '경기지사');

--cf. join

SELECT *
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE AND area = '경기지사';

--월급이 3000달러 이상인 사원이 속한 부서를 조회 emp, dept 이용
-- in

SELECT *
  FROM dept
 WHERE DEPTNO IN (SELECT deptno
                    FROM emp
                   WHERE SAL >= 3000);

-- exists

SELECT *
  FROM dept d
 WHERE EXISTS
           (SELECT 1
              FROM emp e
             WHERE d.DEPTNO = e.DEPTNO AND sal >= 3000);

--join

SELECT DISTINCT d.*
  FROM dept d JOIN emp e ON d.DEPTNO = e.DEPTNO AND sal >= 3000;

/*
※ 서브쿼리 위치별 이름
- 서브쿼리는 오는 위치에 따라서 그 이름이 다름
[1] scalar sub query
    - select 절에 오는 서브쿼리로 한번에 결과를 1행씩 반환함
[2] inline view
    - from 절에 오는 서브쿼리
[3] sub query
    - where 절에 오는 서브쿼리 
*/

-- 예제) emp2 테이블과 dept2 테이블을 조회하여 사원들의 이름과 부서이름 을 출력하시오
--join

SELECT e.NAME, d.DNAME
  FROM emp2 e JOIN dept2 d ON e.DEPTNO = d.DCODE;

--outer join

SELECT e.NAME, d.DNAME
  FROM emp2 e LEFT JOIN dept2 d ON e.DEPTNO = d.DCODE;

--scalar sub query

SELECT name,
       (SELECT dname
          FROM dept2 d
         WHERE d.DCODE = e.deptno)    부서명
  FROM emp2 e;

--=> select문에서 사용하려면 단일 서브쿼리 중에서 단일행이면서 단일 컬럼인 경우만 가능함
--(임의의 숫자나 문자로 인식할 수 있는 서브쿼리) 

--employees, departments - 사원정보, 부서명 조회
--scalar sumquery

  SELECT e.*,
         (SELECT d.DEPARTMENT_NAME
            FROM departments d
           WHERE e.department_id = d.DEPARTMENT_ID)    부서명
    FROM employees e
ORDER BY e.department_id DESC;

--join

  SELECT e.*, d.DEPARTMENT_NAME 부서명
    FROM employees e JOIN departments d ON e.department_id = d.DEPARTMENT_ID
ORDER BY e.department_id DESC;

-- outer join

  SELECT e.*, d.DEPARTMENT_NAME 부서명
    FROM employees e
         LEFT JOIN departments d ON e.department_id = d.DEPARTMENT_ID
ORDER BY e.department_id DESC;

--scalar subquery는 outer join 과 동일
--사원정보를 모두 출력하고, 부서번호가 없는 경우 scalar subquery로 조회한 부서명은 null값이 됨

--각 부서에 해당하는 사원수 구하기

SELECT * FROM dept;

SELECT * FROM emp;

SELECT dname,
       d.LOC,
       (SELECT COUNT (*)
          FROM emp e
         WHERE e.DEPTNO = d.deptno)    사원수
  FROM dept d;

-- 학과별 교수의 인원수, 백분율 구하기

SELECT COUNT (*) FROM professor;

  SELECT deptno,
         COUNT (*)                                                         인원수,
         ROUND (COUNT (*) / (SELECT COUNT (*) FROM professor) * 100, 1)    "백분율"
    FROM professor
GROUP BY deptno
ORDER BY deptno;

SELECT d.*,
       (SELECT COUNT (*)
          FROM professor p
         WHERE p.DEPTNO = d.deptno)    "교수의 인원수",
          ROUND (  (SELECT COUNT (*)
                      FROM professor p
                     WHERE p.DEPTNO = d.deptno)
                 / (SELECT COUNT (*) FROM professor)
                 * 100,
                 1)
       || '%'                          "백분율"
  FROM department d;

--employees 에서 job_id별 급여의 합계가 전체 금액에서 차지하는 비율 구하기

  SELECT job_id,
         SUM (SALARY)    "급여의 합계",
            ROUND (SUM (SALARY) / (SELECT SUM (salary) FROM employees) * 100,
                   2)
         || '%'          "비율"
    FROM employees
GROUP BY ROLLUP (job_id)
ORDER BY job_id;

--case 이용, scalar subquery 이용
--employees에서 직속 상관이름, 급여 레벨 구하기
--상관이 없는 경우 사장으로 표시, 
--salary가 5000미만이면 하, 5000~10000 중, 10001~20000 상, 그 이상 특상

  SELECT FIRST_NAME || '-' || LAST_NAME    이름,
         NVL ((SELECT b.FIRST_NAME
                 FROM employees b
                WHERE b.EMPLOYEE_ID = e.MANAGER_ID),
              '사장')                    "직속상관 이름",
         e.SALARY,
         CASE
             WHEN salary < 5000 THEN '하'
             WHEN salary BETWEEN 5000 AND 10000 THEN '중'
             WHEN salary BETWEEN 10001 AND 20000 THEN '상'
             ELSE '특상'
         END                               "급여 레벨"
    FROM employees e
ORDER BY salary DESC;


  SELECT FIRST_NAME || '-' || LAST_NAME    이름,
         CASE
             WHEN e.MANAGER_ID IS NULL
             THEN
                 '사장'
             ELSE
                 (SELECT b.FIRST_NAME
                    FROM employees b
                   WHERE b.EMPLOYEE_ID = e.MANAGER_ID)
         END                               "직속상관 이름",
         e.SALARY,
         CASE
             WHEN salary < 5000 THEN '하'
             WHEN salary BETWEEN 5000 AND 10000 THEN '중'
             WHEN salary BETWEEN 10001 AND 20000 THEN '상'
             ELSE '특상'
         END                               "급여 레벨"
    FROM employees e
ORDER BY salary DESC;

/*
<의사컬럼(pseudocolumn) - 모조, 유령 컬럼>
- 테이블에 있는 일반적인 컬럼처럼 행동하기는 하지만, 실제로 테이블에 저장되어 있지 않은 컬럼

[1] rownum : 쿼리의 결과로 나오는 각각의 row들에 대한 순서값을 가리키는 의사컬럼
- 주로 특정 개수나 그 이하의 row를 선택할 때 사용됨

[2] rowid : 테이블에 저장된 각각의 row들이 저장된 주소값을 가진 의사컬럼
- 모든 테이블의 모든 row들은 오직 자신만의 유일한 rowid값을 가지고 있다
*/

SELECT ROWNUM, empno, ename, sal, ROWID AS "ROW_ID" FROM emp;

-- emp테이블 전체에서 상위 5건의 데이터 조회

SELECT ROWNUM,
       empno,
       ename,
       sal,
       ROWID     AS "ROW_ID"
  FROM emp
 WHERE ROWNUM <= 5;

-- order by 이용, emp테이블에서 ename 순으로 정렬한 상태에서 상위 5건 조회

  SELECT ROWNUM,
         empno,
         ename,
         sal
    FROM emp
ORDER BY ename;

-- rownum 순서가 뒤바뀜

--inline view 이용

SELECT ROWNUM,
       empno,
       ename,
       sal
  FROM (  SELECT empno, ename, sal
            FROM emp
        ORDER BY ename)
 WHERE ROWNUM <= 5;

--student에서 height 순서대로 상위 7명의 학생 조회

  SELECT *
    FROM student
ORDER BY height DESC;

SELECT ROWNUM, name, height
  FROM (  SELECT *
            FROM student
        ORDER BY height DESC)
 WHERE ROWNUM <= 7;

--employees에서 salary를 내림차순 정렬해서 상위 6건만 조회

SELECT ROWNUM, FIRST_NAME, SALARY
  FROM (  SELECT FIRST_NAME, SALARY
            FROM employees
        ORDER BY salary DESC)
 WHERE ROWNUM <= 6;

 --상위에서 2~4 사이인 사원 조회

SELECT ROWNUM, FIRST_NAME, SALARY
  FROM (  SELECT FIRST_NAME, SALARY
            FROM employees
        ORDER BY salary DESC)
 WHERE ROWNUM BETWEEN 2 AND 4;

 --결과 안나옴, 1이 반드시 포함되어야 함(포함안되면 0건 출력)

 -- 별칭을 사용하여 1없이 출력(inline view 두번 사용)

SELECT rnum, FIRST_NAME, SALARY
  FROM (SELECT ROWNUM rnum, FIRST_NAME, SALARY
          FROM (  SELECT FIRST_NAME, SALARY
                    FROM employees
                ORDER BY salary DESC))
 WHERE rnum BETWEEN 2 AND 4;

 --inline view 
-- employees에서 사원정보를 조회하고, job_id별 평균 급여도 조회

SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY FROM employees;

  SELECT job_id, AVG (NVL (salary, 0))
    FROM employees
GROUP BY job_id;

SELECT a.EMPLOYEE_ID,
       a.FIRST_NAME,
       a.JOB_ID,
       a.SALARY,
       b.평균
  FROM employees  a
       JOIN (  SELECT job_id, AVG (NVL (salary, 0)) 평균
                 FROM employees
             GROUP BY job_id) b
           ON a.JOB_ID = b.JOB_ID;

--로그인 처리

SELECT * FROM MEMBER;

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = 'simson' AND passwd = 'a1234')
           WHEN 1 THEN '로그인 성공'
           ELSE '로그인 실패'
       END    로그인
  FROM DUAL;

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = 'simson' AND passwd = 'a1234')
           WHEN 1
           THEN
               '로그인 성공'
           ELSE
               CASE (SELECT COUNT (*)
                       FROM MEMBER
                      WHERE id = 'simson')
                   WHEN 1 THEN '비밀번호가 틀렸습니다.'
                   ELSE '아이디가 없습니다.'
               END
       END    로그인
  FROM DUAL;

-- 사용자로부터 입력값 받아와서 처리하기

SELECT CASE (SELECT COUNT (*)
               FROM MEMBER
              WHERE id = :id AND passwd = :pwd)
           WHEN 1
           THEN
               '로그인 성공'
           ELSE
               CASE (SELECT COUNT (*)
                       FROM MEMBER
                      WHERE id = :id)
                   WHEN 1 THEN '비밀번호가 틀렸습니다.'
                   ELSE '아이디가 없습니다.'
               END
       END    로그인
  FROM DUAL;

--decode 이용

SELECT DECODE ((SELECT COUNT (*)
                  FROM MEMBER
                 WHERE id = :id AND passwd = :pwd),
               1, '로그인 성공',
               DECODE ((SELECT COUNT (*)
                          FROM MEMBER
                         WHERE id = :id),
                       1, '비밀번호가 틀렸습니다.',
                       '아이디가 없습니다.'))    로그인
  FROM DUAL;

--gogak에서 10대, 30대 남자 조회 - inline view이용

/*
10,14,19 => 10
20,22,27 => 20
*/

SELECT * FROM gogak;

SELECT gname,
       jumin,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
           ELSE '여자'
       END    성별,
         EXTRACT (YEAR FROM SYSDATE)
       - (  SUBSTR (jumin, 1, 2)
          + CASE WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900 ELSE 2000 END)
       + 1    나이
  FROM gogak;

SELECT gname,
       jumin,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
           ELSE '여자'
       END        성별,
         EXTRACT (YEAR FROM SYSDATE)
       - (  SUBSTR (jumin, 1, 2)
          + CASE WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900 ELSE 2000 END)
       + 1        나이,
       TRUNC (
           (  EXTRACT (YEAR FROM SYSDATE)
            - (  SUBSTR (jumin, 1, 2)
               + CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                     ELSE 2000
                 END)
            + 1),
           -1)    연령대
  FROM gogak;

SELECT a.*
  FROM (SELECT gname,
               jumin,
               CASE
                   WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
                   ELSE '여자'
               END        성별,
                 EXTRACT (YEAR FROM SYSDATE)
               - (  SUBSTR (jumin, 1, 2)
                  + CASE
                        WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                        ELSE 2000
                    END)
               + 1        나이,
               TRUNC (
                   (  EXTRACT (YEAR FROM SYSDATE)
                    - (  SUBSTR (jumin, 1, 2)
                       + CASE
                             WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                             ELSE 2000
                         END)
                    + 1),
                   -1)    연령대
          FROM gogak) a
 WHERE a.연령대 IN (10, 30) AND a.성별 = '남자';

--학년별, 성별 인원수, 백분율
--student

SELECT name,
       jumin,
       grade,
       CASE
           WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
           ELSE '여자'
       END    성별
  FROM student;

  SELECT grade,
         성별,
         COUNT (*)                                                    인원수,
         COUNT (*) / (SELECT COUNT (*) FROM student) * 100 || '%'     백분율
    FROM (SELECT name,
                 jumin,
                 grade,
                 CASE
                     WHEN SUBSTR (jumin, 7, 1) IN (1, 3) THEN '남자'
                     ELSE '여자'
                 END    성별
            FROM student) a
GROUP BY ROLLUP (grade, 성별);

--job_history의 정보를 조회하되, job_id에 해당하는 job_title,
--department_id에 해당하는 부서명도 조회
--scalar subquery 이용

SELECT * FROM job_history;

SELECT * FROM jobs;

SELECT * FROM departments;

SELECT * FROM employees;

SELECT a.*,
       (SELECT job_title
          FROM jobs b
         WHERE a.JOB_ID = b.job_id)                  job_title,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTs c
         WHERE a.department_id = c.DEPARTMENT_ID)    부서명
  FROM job_history a;

-- 사원 정보도 조회

SELECT a.EMPLOYEE_ID,
       a.START_DATE,
       a.END_DATE,
       a.JOB_ID,
       a.DEPARTMENT_ID,
       e.FIRST_NAME,
       e.HIRE_DATE,
       e.SALARY,
       (SELECT job_title
          FROM jobs b
         WHERE a.JOB_ID = b.job_id)                  job_title,
       (SELECT DEPARTMENT_NAME
          FROM DEPARTMENTs c
         WHERE a.department_id = c.DEPARTMENT_ID)    부서명
  FROM job_history a RIGHT JOIN employees e ON a.EMPLOYEE_ID = e.EMPLOYEE_ID;

-- 각 부서에 속하는 사원정보를 조회하고 , 부서별 평균급여도 출력하시오 
--[1] 각 부서에 속하는 사원정보를 조회하는 데이터 집합

SELECT d.DEPARTMENT_ID                        부서번호,
       d.DEPARTMENT_NAME                      부서명,
       e.EMPLOYEE_ID                          사원번호,
       e.FIRST_NAME || '-' || e.LAST_NAME     사원명,
       e.HIRE_DATE                            입사일,
       e.SALARY                               급여
  FROM DEPARTMENTS  d
       RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--[2] 부서별 평균급여

  SELECT 부서명, ROUND (AVG (NVL (급여, 0))) "평균 급여"
    FROM (SELECT d.DEPARTMENT_ID                        부서번호,
                 d.DEPARTMENT_NAME                      부서명,
                 e.EMPLOYEE_ID                          사원번호,
                 e.FIRST_NAME || '-' || e.LAST_NAME     사원명,
                 e.HIRE_DATE                            입사일,
                 e.SALARY                               급여
            FROM DEPARTMENTS d
                 RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) a
GROUP BY 부서명;

--[3] 두 개의 데이터를 조인

SELECT A.*, B."평균 급여"
  FROM (SELECT d.DEPARTMENT_ID                        부서번호,
               d.DEPARTMENT_NAME                      부서명,
               e.EMPLOYEE_ID                          사원번호,
               e.FIRST_NAME || '-' || e.LAST_NAME     사원명,
               e.HIRE_DATE                            입사일,
               e.SALARY                               급여
          FROM DEPARTMENTS  d
               RIGHT JOIN EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) A
       LEFT JOIN
       (  SELECT 부서명, ROUND (AVG (NVL (급여, 0))) "평균 급여"
            FROM (SELECT d.DEPARTMENT_ID                        부서번호,
                         d.DEPARTMENT_NAME                      부서명,
                         e.EMPLOYEE_ID                          사원번호,
                         e.FIRST_NAME || '-' || e.LAST_NAME     사원명,
                         e.HIRE_DATE                            입사일,
                         e.SALARY                               급여
                    FROM DEPARTMENTS d
                         RIGHT JOIN EMPLOYEES e
                             ON e.DEPARTMENT_ID = d.DEPARTMENT_ID) a
        GROUP BY 부서명) B
           ON A."부서명" = B."부서명";

-- emp 테이블을 조회하여 직원들 중에서 자신의 job의 평균 연봉(sal)보다 적거 나 같게 받는 사람들을 조회하시오.

SELECT AVG (NVL (sal, 0)) FROM emp;

  SELECT a.*
    FROM emp a
   WHERE sal <= (SELECT AVG (NVL (sal, 0))
                   FROM emp b
                  WHERE b.JOB = a.job)
ORDER BY a.job;

-- 각 학과에 해당하는 교수의 수 구하기 ?
-- 각 학과에 해당하는 학생수 구하기 ?
-- department , student 테이블

  SELECT DEPTNO, COUNT (*)
    FROM professor
GROUP BY DEPTNO;

SELECT deptno,
       dname,
       (SELECT COUNT (*)
          FROM professor b
         WHERE a.deptno = b.DEPTNO)    "교수의 수"
  FROM department a;

--학과별 교수의 수

SELECT deptno,
       dname,
       (SELECT COUNT (*)
          FROM student b
         WHERE a.deptno = b.DEPTNO1)    "학생의 수"
  FROM department a;

--학과별 학생 수

--Professor 테이블에서 월급을 많이 받는 교수 순으로 10명 조회하기 ? 

SELECT r,
       PROFNO,
       NAME,
       PAY
  FROM (SELECT ROWNUM     r,
               PROFNO,
               NAME,
               PAY
          FROM (  SELECT PROFNO, NAME, PAY
                    FROM professor
                ORDER BY pay DESC))
 WHERE r <= 10;

--Student, exam_01 테이블에서 총점이 90이상인 학생들의 정보 조회

SELECT s.*
  FROM student s
 WHERE TRUNC (  (SELECT TOTAL
                   FROM exam_01 e
                  WHERE e.STUDNO = s.STUDNO)
              / 10) IN (10, 9);

SELECT *
  FROM student
 WHERE studno IN (SELECT studno
                    FROM exam_01
                   WHERE total >= 90);

SELECT *
  FROM student s
 WHERE EXISTS
           (SELECT studno
              FROM exam_01 e
             WHERE s.STUDNO = e.STUDNO AND total >= 90);


--[2020-04-24 금요일]
--departments, employees 조인해서 부서에 해당하는 사원들 정보 조회

  SELECT d.DEPARTMENT_ID,
         d.DEPARTMENT_NAME,
         e.EMPLOYEE_ID,
         e.FIRST_NAME,
         e.SALARY
    FROM departments d
         FULL JOIN employees e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
ORDER BY d.DEPARTMENT_ID;

--부서장 명도 알고싶다

SELECT a.DEPARTMENT_ID       "부서 번호",
       a.DEPARTMENT_NAME     "부서 이름",
       a.MANAGER_ID          "부서장 번호",
       b.FIRST_NAME          "부서장 명"
  FROM departments a LEFT JOIN employees b ON a.MANAGER_ID = b.EMPLOYEE_ID;

  SELECT A.*,
         e.EMPLOYEE_ID     "사원 번호",
         e.FIRST_NAME      "사원 이름",
         e.SALARY          "월급"
    FROM (SELECT a.DEPARTMENT_ID       "부서 번호",
                 a.DEPARTMENT_NAME     "부서 이름",
                 a.MANAGER_ID          "부서장 번호",
                 b.FIRST_NAME          "부서장 명"
            FROM departments a JOIN employees b ON a.MANAGER_ID = b.EMPLOYEE_ID)
         A
         FULL JOIN employees e ON A."부서 번호" = e.DEPARTMENT_ID
ORDER BY "부서 번호";