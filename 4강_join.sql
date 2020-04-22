/* Formatted on 2020/04/22 오전 10:36:48 (QP5 v5.360) */
--4강_join.sql
--20-04-21 화

/*
조인(join)
- 각각의 테이블에 분리되어 있는 연관성 있는 데이터들을 연결하거나 조합하는 일련의 작업들
- 여러 테이블에 흩어져 있는 정보 중에서 사용자가 필요한 정보만 가져와서 가상의 테이블간
 공통된 열을 기준으로 검색
 
※ 조인의 종류
1) 내부 조인(inner join)
    - 양쪽 테이블에 모두 데이터가 존재해야 결과가 나옴
2) 외부 조인(outer join)
3) self 조인
4) cross join(카티션 곱)

오라클용 조인
표준 ANSI 조인
*/
--[1] inner join(내부 조인)
--예제) 학생 테이블 (student)과 학과 테이블 (department)을 사용하여 학생이름, 
--1전공 학과번호 (deptno1), 1전공 학과이 름을 출력하시오.

SELECT * FROM student;

SELECT * FROM department;

--1) 오라클용 조인

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s, department d
 WHERE s.DEPTNO1 = d.DEPTNO;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        -- join 조건

--2) 표준 ANSI 조인

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s INNER JOIN department d ON s.DEPTNO1 = d.DEPTNO;

-- inner 생략 가능

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       d.DNAME
  FROM student s JOIN department d ON s.DEPTNO1 = d.DEPTNO;

--4학년 학생들의 정보를 조회, 학과명도 출력
--1) 오라클용 조인

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       s.GRADE,
       d.DNAME
  FROM student s, department d
 WHERE s.DEPTNO1 = d.DEPTNO                                           --join조건
                            AND s.GRADE = 4;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           -- 검색조건

--2) ANSI

SELECT s.STUDNO,
       s.NAME,
       s.DEPTNO1,
       s.GRADE,
       d.DNAME
  FROM student s JOIN department d ON s.DEPTNO1 = d.DEPTNO AND s.GRADE = 4;

--예제) 학생 테이블(student)과 교수 테이블(professor)을 join하여 학 생이름, 
--지도교수 번호, 지도교수 이름을 출력하시오

SELECT *
  FROM student
 WHERE profno IS NULL;

SELECT s.NAME, p.PROFNO, p.NAME
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    -- 15건 student에 profno가 null인 데이터는 안 나옴
--=> 내부조인 : 양쪽 테이블에 데이터가 있는 것만 출력됨 

SELECT s.NAME, p.PROFNO, p.NAME
  FROM student s JOIN professor p ON s.profno = p.profno;

-- employees, jobs 를 조인해서 사원정보(이름, job_id)와 job_title도 출력

SELECT e.FIRST_NAME || '-' || e.LAST_NAME 이름, e.JOB_ID, j.JOB_TITLE
  FROM employees e, jobs j
 WHERE e.JOB_ID = j.JOB_ID;

SELECT e.FIRST_NAME || '-' || e.LAST_NAME 이름, e.JOB_ID, j.JOB_TITLE
  FROM employees e JOIN jobs j ON e.JOB_ID = j.JOB_ID;

--예제) 학생 테이블(student)과 학과 테이블(department), 교수 테이블 (professor)을 join하여 
--학생이름, 학과 이름, 지도교수 이름을 출력하시오

SELECT s.NAME, d.DNAME, p.NAME
  FROM student s, department d, professor p
 WHERE s.PROFNO = p.PROFNO AND s.DEPTNO1 = d.DEPTNO;

SELECT s.NAME, d.DNAME, p.NAME
  FROM student  s
       JOIN department d ON s.DEPTNO1 = d.DEPTNO
       JOIN professor p ON s.PROFNO = p.PROFNO;

-- 예제) emp2 테이블과 학과 p_grade 테이블을 join하여 사원이름, 직 급, 현재연봉, 
--해당 직급의 연봉의 하한 금액과 상한 금액을 출력하시오

SELECT e.NAME,
       e.POSITION,
       e.PAY       현재,
       p.S_PAY     하한,
       p.E_PAY     상한
  FROM emp2 e, p_grade p
 WHERE e.POSITION = p.POSITION;

SELECT e.NAME,
       e.POSITION,
       e.PAY       현재,
       p.S_PAY     하한,
       p.E_PAY     상한
  FROM emp2 e JOIN p_grade p ON e.POSITION = p.POSITION;

--부서명도 출력

SELECT e.NAME,
       e.POSITION,
       e.PAY       현재,
       p.S_PAY     하한,
       p.E_PAY     상한,
       d.DNAME
  FROM emp2 e, p_grade p, dept2 d
 WHERE e.POSITION = p.POSITION AND e.DEPTNO = d.DCODE;

SELECT e.NAME,
       e.POSITION,
       e.PAY       현재,
       p.S_PAY     하한,
       p.E_PAY     상한,
       d.DNAME
  FROM emp2  e
       JOIN p_grade p ON e.POSITION = p.POSITION
       JOIN dept2 d ON e.DEPTNO = d.DCODE;

-- 사원정보, 사원의 부서정보, 부서의 지역정보, 지역의 나라정보 조회

SELECT e.*,
       d.DEPARTMENT_NAME,
       l.CITY,
       c.COUNTRY_NAME
  FROM employees    e,
       departments  d,
       locations    l,
       countries    c
 WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID
       AND d.LOCATION_ID = l.LOCATION_ID
       AND l.COUNTRY_ID = c.COUNTRY_ID;

SELECT e.*,
       d.DEPARTMENT_NAME,
       l.CITY,
       c.COUNTRY_NAME
  FROM employees  e
       JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
       JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
       JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID;

-- 예제) 1전공(depton1)이 101번인 학생들의 학생이름과 지도교수 이름을 출력하시오.

SELECT s.*, p.NAME
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO AND s.DEPTNO1 = 101;

SELECT s.*, p.NAME
  FROM student s JOIN professor p ON s.PROFNO = p.PROFNO AND s.DEPTNO1 = 101;

--1) emp2, dept2 테이블을 이용해서 사원이름(name), 급여(pay), 직급(position), 
--부서명(dname)를 조회하시오

SELECT e.name,
       e.pay,
       e.position,
       d.dname
  FROM emp2 e, dept2 d
 WHERE E.DEPTNO = D.DCODE;

SELECT e.name,
       e.pay,
       e.position,
       d.dname
  FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE;

--2) emp2 - 부서번호별 pay의 평균

  SELECT deptno, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e
GROUP BY DEPTNO;

--emp2, dept2 테이블에서 부서이름별 pay의 평균 구하기

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e, dept2 d
   WHERE E.DEPTNO = D.DCODE
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname;

--[실습] 위의 예제의 결과에서 부서 이름이 영업으로 시작하는 부서의 평균만 조회하시오.

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e, dept2 d
   WHERE E.DEPTNO = D.DCODE AND d.dname LIKE '영업%'
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE AND d.dname LIKE '영업%'
GROUP BY d.dname;

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname
  HAVING d.dname LIKE '영업%';

--위의 결과에서 부서평균이 5000만원 이상인 데이터만 조회

  SELECT d.dname, AVG (NVL (pay, 0)) "pay 평균"
    FROM emp2 e JOIN dept2 d ON E.DEPTNO = D.DCODE
GROUP BY d.dname
  HAVING AVG (NVL (pay, 0)) >= 50000000;

--[2]outer join(외부 조인)

/*
inner join과는 반대로 한쪽 테이블에는 데이터가 있고, 한쪽 테이블에 없는 경우
데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
*/
--예제)student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오. 
--단, 지도교수가 결정되지 않은 학 생의 명단도 함께 출력하시오. (학생 데이터는 전부 출력되도록)

--1) inner join - 양쪽에 데이터가 존재하는 것만 출력

SELECT s.name, p.name
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO;

-- => 15건, 지도교수가 없는 학생은 제외

--2) outer join - 학생은 모두 출력

SELECT s.name, p.name
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO(+);

-- 데이터가 없는 쪽에 (+) 표시를 한다

SELECT s.name, p.name
  FROM student s LEFT OUTER JOIN professor p ON s.PROFNO = p.PROFNO;

-- 데이터가 있는 쪽에 표시를 함
-- 학생 데이터는 전부 출력해야 하므로 학생 테이블을 향해 표시
-- 학생 테이블이 왼쪽에 있으므로 left


--예제) student 테이블과 professor 테이블을 조인하여 학 생이름과 지도교수 이름을 출력 하시오. 
--단, 지도학생이 결정되지 않은 교 수의 명단도 함께 출력하시오. (교수 데이터는 전부 출력되도록)
-- 교수 데이터 18건

  SELECT s.name, p.name, p.POSITION
    FROM student s, professor p
   WHERE s.PROFNO(+) = p.PROFNO
ORDER BY p.name;                                                                                                                                                                                                                                                                                                                                                                  -- 24건

  SELECT s.name, p.name, p.POSITION
    FROM student s RIGHT OUTER JOIN professor p ON s.PROFNO = p.PROFNO
ORDER BY p.name;

/*
예제)student 테이블과 professor 테이블을 조인하여 학생이름과 지도교수 이름을 출력하시오. 
단, 지도학생이 결정되지 않은 교 수의 명단과 지도교수가 결정 안 된 학생 명단을 한꺼번에 출력하 시오. ? 
두 가지 outer join의 결과를 합쳐서 만들어야 함 (Oracle outer join에서는 지원하지 않음)
=> 두 outer join을 각각 수행한 후 Union을 사용하여 결과를 인위적으로 합쳐서 출력함 ? 
*/

SELECT s.name, p.name 지도교수, p.POSITION
  FROM student s, professor p
 WHERE s.PROFNO(+) = p.PROFNO
UNION
SELECT s.name, p.name 지도교수, p.POSITION
  FROM student s, professor p
 WHERE s.PROFNO = p.PROFNO(+)
ORDER BY 지도교수;

--Ansi outer join 에서는 훨씬 간단한 방법을 제공함

  SELECT s.name, p.name, p.POSITION
    FROM student s FULL OUTER JOIN professor p ON s.PROFNO = p.PROFNO
ORDER BY p.name;

--학생 정보 출력, 학과명, 지도교수명도 출력
--학생 데이터는 전부 출력되도록

  SELECT s.*, d.DNAME, p.NAME
    FROM student s, professor p, department d
   WHERE s.PROFNO = p.PROFNO(+) AND p.DEPTNO = d.DEPTNO(+)
ORDER BY s.PROFNO;

  SELECT s.*, d.DNAME, p.NAME
    FROM student s
         LEFT OUTER JOIN professor p ON s.PROFNO = p.PROFNO
         LEFT JOIN department d ON p.DEPTNO = d.DEPTNO
ORDER BY s.PROFNO;

--사원정보, 부서정보, 지역정보, 나라정보 조회
--사원 전체 출력(사원-부서간), 부서 전체 출력(부서-지역간), 지역전체 출력(지역-나라 간)

  SELECT e.*,
         d.DEPARTMENT_NAME     부서명,
         l.CITY                지역명,
         c.COUNTRY_NAME        나라정보
    FROM employees  e,
         departments d,
         locations  l,
         countries  c
   WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID(+)
         AND d.LOCATION_ID = l.LOCATION_ID(+)
         AND l.COUNTRY_ID = c.COUNTRY_ID(+)
ORDER BY e.DEPARTMENT_ID;

--ANSI

  SELECT e.*,
         d.DEPARTMENT_NAME     부서명,
         l.CITY                지역명,
         c.COUNTRY_NAME        나라정보
    FROM employees e
         LEFT JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         LEFT JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
         LEFT JOIN countries c ON l.COUNTRY_ID = c.COUNTRY_ID
ORDER BY e.DEPARTMENT_ID;

--실습
-- 1. emp2, p_grade 테이블에서 name(사원이름),  position(직급), 시작연도 (s_year), 
--끝연도(e_year)을 조회 ? 단, emp2 테이블의 데이터는 전부 출력되도록 할 것

SELECT e.NAME 사원이름, e.POSITION 직급, p.S_YEAR 시작연도
  FROM emp2 e, p_grade p
 WHERE e.POSITION = p.POSITION(+);

SELECT e.NAME 사원이름, e.POSITION 직급, p.S_YEAR 시작연도
  FROM emp2 e LEFT JOIN p_grade p ON e.POSITION = p.POSITION;

--emp, dept 테이블에서 부서번호,사원명,직업,부서명,지역 조회 단, 직업(job)이 CLERK인 사원 데이터만 조회

SELECT e.DEPTNO     부서번호,
       e.ENAME      사원명,
       e.JOB        직업,
       d.DNAME      부서명,
       d.LOC        지역
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO AND e.JOB = 'CLERK';

SELECT e.DEPTNO     부서번호,
       e.ENAME      사원명,
       e.JOB        직업,
       d.DNAME      부서명,
       d.LOC        지역
  FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO AND e.JOB = 'CLERK';

--emp, dept 테이블에서 부서번호,사원명,직업,부서명,지역 조회 단, 직업(job)이 CLERK인 사원이거나 
--Manager인 사원만 조회

SELECT e.DEPTNO     부서번호,
       e.ENAME      사원명,
       e.JOB        직업,
       d.DNAME      부서명,
       d.LOC        지역
  FROM emp e, dept d
 WHERE e.DEPTNO = d.DEPTNO AND e.JOB IN ('CLERK', 'MANAGER');

SELECT e.DEPTNO     부서번호,
       e.ENAME      사원명,
       e.JOB        직업,
       d.DNAME      부서명,
       d.LOC        지역
  FROM emp  e
       JOIN dept d ON e.DEPTNO = d.DEPTNO AND e.JOB IN ('CLERK', 'MANAGER');

--emp, dept 테이블에서 지역(loc)별 급여(sal)의 평균 조회 ? Join, group by 모두 이용

  SELECT d.LOC, AVG (NVL (e.SAL, 0))
    FROM emp e, dept d
   WHERE e.DEPTNO = d.DEPTNO
GROUP BY d.LOC;

  SELECT d.LOC, AVG (NVL (e.SAL, 0))
    FROM emp e JOIN dept d ON e.DEPTNO = d.DEPTNO
GROUP BY d.LOC;

-- student 테이블과 exam_01 테이블을 조회하여 학생들의 학번, 이름, 점수, 학점을 출력하시오 
--(학점은 dcode나 case이용- 90 이상이면 'A', 80이상이면 'B', 70이상이면 'C', 60이상이면'D' 
--60미만이면 'F' )

SELECT s.STUDNO    학번,
       s.NAME      이름,
       e.TOTAL     점수,
       CASE TRUNC (e.TOTAL / 10)
           WHEN 10 THEN 'A'
           WHEN 9 THEN 'A'
           WHEN 8 THEN 'B'
           WHEN 7 THEN 'C'
           WHEN 6 THEN 'D'
           ELSE 'F'
       END         학점
  FROM student s, exam_01 e
 WHERE s.STUDNO = e.STUDNO;

SELECT s.STUDNO    학번,
       s.NAME      이름,
       e.TOTAL     점수,
       CASE TRUNC (e.TOTAL / 10)
           WHEN 10 THEN 'A'
           WHEN 9 THEN 'A'
           WHEN 8 THEN 'B'
           WHEN 7 THEN 'C'
           WHEN 6 THEN 'D'
           ELSE 'F'
       END         학점
  FROM student s JOIN exam_01 e ON s.STUDNO = e.STUDNO;

   --2020-04-22 수요일

  SELECT l.city,
         d.department_name,
         e.job_id,
         e.job_id,
         e.salary
    FROM employees e
         LEFT JOIN departments d ON e.department_id = d.department_id
         LEFT JOIN locations l ON d.location_id = l.location_id
ORDER BY d.department_id DESC;

  SELECT l.city,
         d.department_name,
         e.job_id,
         SUM (e.salaty)     급여합계,
         COUNT (*)          인원수
    FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON d.location_id = l.location_id
GROUP BY l.city, d.department_name, e.job_id
ORDER BY l.city, d.department_name, e.job_id;

--select * from emp_details_view;

--[3] self join
--상위 부서명 조회하기
--부서 테이블에서 상위부서코드(pdept)에 해당하는 상위부서 정보를 출력

SELECT * FROM dept2;                                         -- 13건

--inner join

  SELECT a.*,
         a.dname,
         a.pdept     "상위 부서 코드",
         a.area,
         b.dname     "상위 부서명"
    FROM dept2 a JOIN dept2 b ON a.pdept = b.dcode
ORDER BY a.dcode;                                   --12 건
-- 사장실은 상위 부서가 null이므로 데이터를 가져오지 않았음

--outer join

  SELECT a.*,
         a.dname,
         a.pdept     "상위 부서 코드",
         a.area,
         b.dname     "상위 부서명"
    FROM dept2 a LEFT JOIN dept2 b ON a.pdept = b.dcode
ORDER BY a.dcode;                                   -- 13건
--=> 사장실 레코드도 포함됨

--사원정보와 해당 사원의 직속 상관의 이름 출력
select * from employees;

select a.*, b.first_name "직속상관의 이름"
from employees a left join employees b
on a.manager_id=b.employee_id;

--2. EMP Table에 있는 EMPNO와 MGR을 이용하여 서로의 관계를 다음과 같이 출력하라. 
--‘FORD의 매니저는 JONES’
select a.*, b.ename "매니저"
from emp a left join emp b
on a.mgr=b.empno;

-- 카티션곱(cartesion product)
/*
- join 조건이 없는 경우
 두 테이블의 데이터를 곱한 개수만큼의 데이터가 출력됨
- ANSI join 에서는 cross join이라고 부름
*/
select * from emp; --14건
select * from dept; -- 4건

select e.*,d.dname
from emp e, dept d; -- 14 * 4 = 56건 출력

--ANSI join
select e.*,d.dname, d.deptno
from emp e cross join dept d
order by d.deptno, e.empno; -- 14 * 4 = 56건 출력