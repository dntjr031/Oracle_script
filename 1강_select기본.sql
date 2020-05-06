/* Formatted on 2020/05/06 오전 10:44:43 (QP5 v5.360) */
--1강_select기본.sql
--[2020-04-14 화]

--한줄 주석

/*
여러줄 주석
*/

SELECT * FROM tab;                   -- 해당 계정의 테이블 목록을 조회

DESC countries;                -- 해당 테이블에 어떤 컬럼이 있는 등 테이블 구조를 확인할 수 있다.

/*
sqlplus 툴 사용시 해달 계정에 연결하는 방법
[1] sqlplus 아이디/비밀번호
예) sqlplus hr /hr123
sqlplus sys/a123$ as sysdba
sqlplus / as sysdba

[2] sqlplus 들어간 후
conn 아이디/비밀번호
예) conn hr/hr123
conn sys/a123$ as sysdba
conn / as sysdba

* 오라클 설치 후 사용자 sample 계정에 들어가려면 lock을 풀고 사용해야 함
sys꼐정으로 접속한 수

- hr 계정ㅇ의 lock풀기
alter user hr account unlock;

- hr 계정의 비밀번호 변경하기
alter user hr identified by hr123;
=> hr 계정의 비밀번호를 hr123으로 변경한다

* sqlplus에서 접속한 계정을 확인하려면
show user
*/
--table 간의 관계 확인

SELECT * FROM employees;                         -- 자식

SELECT * FROM jobs;                    -- 부모

SELECT * FROM employees;                         -- 자식

SELECT * FROM departments;                           --부모

SELECT * FROM locations;                         --  부모

SELECT * FROM departments;                           -- 자식

SELECT * FROM locations;                         -- 자식

SELECT * FROM countries;                         --부모

SELECT * FROM countries;                         -- 자식

SELECT * FROM regions;                       --부모

SELECT * FROM JOB_HISTORY;                           -- 자식

SELECT * FROM employees;                         -- 부모

SELECT * FROM jobs;                    --부모

SELECT * FROM JOB_HISTORY;                          --자식

SELECT * FROM JOB_HISTORY;                          --자식

SELECT * FROM departments;                           --부모

-------------------------20.04.16목요일

--데이터 조회하기
-- SELECT 컬럼명1,컬럼명2 FROM 테이블명;

--1. 모든 컬럼 조회하기
-- SELECT * FROM 테이블명;

--EMPLOYEES 테이블에서 모든 컬럼 조회하기

SELECT * FROM EMPLOYEES;                         -- 대소문자 구분 안함
-- 단, 데이터는 대소문자 구분함

--2. 일부 컬럼만 조회하기
-- SELECT 컬럼1, 컬럼2 FROM 테이블명;

--employees 테이블에서 사원아이디, 이름, 입사일, 급여 조회하기

SELECT employee_id, first_name, last_name, hire_date, salary FROM employees;

--3. 표현식을 사용하여 출력하기

SELECT first_name, '님 환영합니다.' FROM employees;

/*
표현식(literal 상수, 문자)
- 컬럼 이름 외에 출력하기를 원하는 내용을 의미
SELECT 구분 뒤에 '(홑따옴표)로 묶어서 사용
*/

--4. 컬럼 별칭 사용하여 출력하기

/*
컬럼명 뒤에 as "별칭" (공백이나 일부 특수기호가 있으면 반드시 ""로 묶어줘야 함
또는 컬럼명 뒤에 "별칭"
또는 컬럼명 뒤에 별칭

- 원래 테이블의 컬럼명이 변경되는 것이 아니라 출력될때 임시로 바꾸어서 보여주는 것
*/

SELECT first_name, '님 환영합니다' AS "인사말" FROM EMPLOYEES;

SELECT employee_id      AS "사원아이디",
       first_name       이름,
       last_name        성,
       phone_number     "전화번호",
       salary           "급여!"
  FROM employees;

-- 5. distinct 중복된 값을 제거하고 출력하기

SELECT * FROM emp;

SELECT deptno FROM emp;

SELECT DISTINCT deptno
  FROM emp;                                 -- 중복된 데이터가 제거됨

  SELECT deptno, job
    FROM emp
ORDER BY deptno, job;

  SELECT DISTINCT deptno, job
    FROM emp
ORDER BY deptno, job;

-- distinct 키워드는 1개의 컬럼에만 적어도 모든 컬럼에 적용됨

--6. 연결 연산자 ||

SELECT * FROM professor;

SELECT name, position FROM professor;

SELECT name || ' ' || position AS "교수 이름" FROM professor;

--7. 산술 연산자 사용하기 +,-,*,/

SELECT ename,
       sal,
       comm,
       sal + 100,
       sal + comm,
       sal + 100 / 2,
       (sal + 100) / 2
  FROM emp;

SELECT first_name,
       salary,
       commission_pct,
       salary + salary * commission_pct
  FROM employees;

SELECT 100 * 0.3, 200 - 60, 100 + NULL, 20 * NULL FROM DUAL;

--오라클은 select 절과 from절이 필수절임
--from 절 생략 불가, from 뒤에 가상 테이블인 dual을 써준다

--null : 존재하지 않다는 것,
--null에 연산을 하더라도 결과는 null

SELECT * FROM DUAL;

DESC dual;

SELECT dcode "부서#", dname 부서명, area 위치 FROM dept2;

SELECT    name
       || '의 키는 '
       || HEIGHT
       || ' cm, 몸무게는 '
       || WEIGHT
       || 'kg 입니다.'    AS "학생의 키와 몸무게"
  FROM student;

-- where 절을 활용하여 원하는 조건만 조회하기 
--select [칼럼명 또는 표현식]  from [테이블명, 뷰명] where 원하는 조건; 

-- emp 테이블에서 10번 부서에 근무하는 사원의 이름과 급 여, 부서번호를 출력 

SELECT ename, sal, deptno
  FROM emp
 WHERE deptno = 10;

-- emp 테이블에서 급여(sal)가 4000보다 큰 사람의 이름과 급여를 출력 

SELECT ename, sal
  FROM emp
 WHERE sal > 4000;

-- emp 테이블에서 이름이 scott인 사람의 이름과 사원번호, 급여를 출력
-- select ename, empno, sal from emp where ename = 'scott'; -- 데이터가 조회X

SELECT ename, empno, sal
  FROM emp
 WHERE ename = 'SCOTT';

-- 오라클은 대소문자를 구분하지 않지만, 데이터는 대소문자를 구분함

--문자열과 날짜는 '(홑땅옴효)로 감싸주어야 함
--professor테이블에서 입사일이 1987-01-30인 레코드 조회

SELECT *
  FROM professor
 WHERE HIREDATE = '1987-01-30';

--또는

SELECT *
  FROM professor
 WHERE HIREDATE = '1987/01/30';

--조건에서 다양한 연산자 이용

/*
비교 : =, !=, <, >, <=, >=
논리 : and, or, not
범위 : between A and B
목록 : in(A,B,C)
특정 패턴 : like
*/

--비교 연산자를 사용하여 student 테이블에서 키(height)가 180cm 보 다 크거나 같은 사람 출력 

SELECT *
  FROM student
 WHERE height >= 180;

SELECT *
  FROM student
 WHERE NOT (height < 180);

--Between 연산자를 사용하여 student 테이블에서 몸무게(weight)가 60~80kg 인 
--사람의 이름과 체중 출력 

SELECT *
  FROM student
 WHERE weight BETWEEN 60 AND 80;

SELECT *
  FROM student
 WHERE weight >= 60 AND weight <= 80;

-- 몸무게가 60~80이 아닌 사람

SELECT *
  FROM student
 WHERE weight < 60 OR weight > 80;

SELECT *
  FROM student
 WHERE NOT (weight BETWEEN 60 AND 80);

SELECT *
  FROM student
 WHERE weight NOT BETWEEN 60 AND 80;

-- 문자, 날짜도 between을 이용해 범위값을 구할 수 있다.
--ename이 B~G 사이인 사람 조회

SELECT *
  FROM emp
 WHERE ename >= 'B' AND ename <= 'G';

SELECT *
  FROM emp
 WHERE ename BETWEEN 'B' AND 'G';

--ename 이 B~G가 아닌 사람 조회

SELECT *
  FROM emp
 WHERE ename NOT BETWEEN 'B' AND 'G';

SELECT *
  FROM emp
 WHERE NOT (ename BETWEEN 'B' AND 'G');

SELECT *
  FROM emp
 WHERE ename < 'B' OR ename > 'G';

-- employees에서 입사일이 2005-2006년 사이의 사원 조회

SELECT *
  FROM employees
 WHERE hire_date >= '2005-01-01' AND hire_date <= '2006-12-31';

SELECT *
  FROM employees
 WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2006-12-31';

--student에서 4학년이 아닌 학생들 조회

SELECT *
  FROM student
 WHERE grade != 4;

SELECT *
  FROM student
 WHERE grade <> 4;

SELECT *
  FROM student
 WHERE grade ^= 4;

--In 연산자를 사용하여 student 테이블에서 101번 학과 학생과 102번 학과 학생들을 모두 출력  

SELECT *
  FROM student
 WHERE DEPTNO1 IN (101, 102);

SELECT *
  FROM student
 WHERE deptno1 = 101 OR deptno1 = 102;

--학과가 101,102가 아닌 학생

SELECT *
  FROM student
 WHERE deptno1 NOT IN (101, 102);

--Like 연산자를 사용하여 student 테이블에서 성이 "김"씨인 사람을 조회

SELECT *
  FROM student
 WHERE NAME LIKE '김%';

-- 이름이 수로 끝나는 사람 조회

SELECT *
  FROM student
 WHERE name LIKE '%수';

-- 이름에 재가 포함된 사람 조회

SELECT *
  FROM student
 WHERE name LIKE '%재%';

/*
like와 함께 사용할 수 있는 wild card : %, _
1) % : 글자수 제한 없고 어떤 글자가 와도 됨, 글자가 안 와도 됨
2) _ : 글자수는 한 글자만 올 수 있고, 어떤 글자가 와도 됨
        반드시 한 글자가 와야 됨

*/

SELECT *
  FROM student
 WHERE id LIKE '%in%';                                            -- in이 포함된 것

SELECT *
  FROM student
 WHERE id LIKE '_in__';                                             -- in 앞에 한글자, 뒤에 2글자 와야하는 것

SELECT *
  FROM employees
 WHERE job_id LIKE '%PR_%';                                                   --PR뒤에 한글자가 나와야함

SELECT *
  FROM employees
 WHERE job_id LIKE '%PR\_%' ESCAPE '\';                                                               -- PR_(언더바) 포함

--job_id가 SA_로 시작하고 뒤에 3글자가 나오는 것 조회

SELECT *
  FROM employees
 WHERE job_id LIKE 'SA\____' ESCAPE '\';

--이름이 김재수인 사람 조회

SELECT *
  FROM student
 WHERE name = '김재수';

-- 성이 김보다 크거나 같은 사람들 조회

SELECT *
  FROM student
 WHERE name >= '김';

/*
null : 오라클의 데이터 종류 중 한 가지로 어떤 값인지 모른다는 의미
        데이터가 없음을 의미함, 아직 정의되지 않은 미지의 값
null 에는 어떤 연산을 수행해도 결과값은 항상 null 이 나옴

null 값은 = 연산을 사용할 수 없음
=> is null, is not null 사용
*/
--professor 테이블에서 bonus가 null인 데이터 조회

SELECT *
  FROM professor
 WHERE bonus IS NULL;

SELECT *
  FROM professor
 WHERE bonus IS NOT NULL;

--검색 조건이 2개 이상인 경우
--논리 연산자 우선 순위 () > not > and > or

-- student 테이블을 사용하여 4학년 중에서 키가 170cm 이상인 사람 의 이름과 학년, 키를 조회

SELECT * FROM student;

SELECT name, grade, height
  FROM student
 WHERE grade = 4 AND height >= 170;

-- student 테이블을 사용하여 1학년이거나 또는 몸무게가 80kg 이상인 학생들의 이름과 학년, 키, 몸무게를 조회 

SELECT name, grade, weight
  FROM student
 WHERE grade = 1 OR weight >= 80;

-- student 테이블을 사용하여 2학년 중에서 키가 180cm 보다 크면서 
-- 몸무게가 70kg 보다 큰 학생들의 이름과 학년, 키와 몸무게를 조회 

SELECT name,
       grade,
       height,
       weight
  FROM student
 WHERE grade = 2 AND weight > 70 AND height > 180;

-- student 테이블을 사용하여 2학년 학생 중에서 키가 180cm 보다 크거나 
-- 또는 몸무게가 70kg 보다 큰 학생들의 이름과 학년, 키, 몸무게를 조회

SELECT name,
       grade,
       height,
       weight
  FROM student
 WHERE grade = 2 AND (height > 180 OR weight > 80);

--실습> professor 테이블에서 교수들의 이름을 조회하여 성 부분에 'ㅈ'이 포함된 사람의 명단을 출력 

SELECT * FROM professor;

SELECT name
  FROM professor
 WHERE name >= '자' AND name < '차';

SELECT name
  FROM professor
 WHERE name BETWEEN '자' AND '차';

--10. order by 절을 사용하여 출력 결과 정렬하기

/*
오름차순 정렬(기본값) asc
내림차순 정렬 desc
SQL문장의 가장 마지막에 적어야 함

order by 컬럼명;       --오름차순
order by 컬럼명 asc;   --오름차순
order by 컬럼명 desc;  --내림차순
*/
-- student 테이블을 사용하여 1학년 학생의 이름과  키를 출력. 단, 키가 작은 순서대로 출력 

  SELECT name, height
    FROM student
ORDER BY height;

  SELECT name "이름", height
    FROM student
ORDER BY "이름";                                                     -- 별칭으로도 가능

-- student 테이블을 사용하여 1학년 학생의 이름과  키, 몸무게를 출력. 
-- 단, 키는 작은 순서대로 출력하고 몸무게는 많은 사람부터 출력 

  SELECT name, height, weight
    FROM student
ORDER BY height, weight DESC;

-- 키가 같은 경우에는 두번째 정렬 컬럼인 몸무게 내림차순으로 정렬함

  SELECT name, height, weight
    FROM student
ORDER BY 2, 3 DESC;

-- 숫자를 이용하면 두번째 컬럼, 3번째 컬럼으로 정렬한다는 것

-- student 테이블을 사용하여 1학년 학생의 이름과  생일, 키, 몸무게를 출력. 
-- 단, 생일이 빠른 사람 순서대로 정렬 

  SELECT name,
         BIRTHDAY,
         height,
         weight
    FROM student
ORDER BY birthday;

-- student 테이블을 사용하여 1학년 학생의 이름과 키를 출력. 단, 이름 을 오름차순으로 정렬 

  SELECT name, height
    FROM student
   WHERE grade = 1
ORDER BY name;

SELECT * FROM employees;

-- [실습]employees 테이블에서 사원아이디, 이름 - 성(예 : Steven-King), 입사일, 기본급(salary), 
-- 수당(salary*commission_pct), 급여(salary+수당) 조회하기(모든컬럼은 별칭 사용)

SELECT EMPLOYEE_ID                          "사원 아이디",
       FIRST_NAME || '-' || LAST_NAME       이름,
       HIRE_DATE                            입사일,
       SALARY                               기본급,
       SALARY * COMMISSION_PCT              수당,
       SALARY + SALARY * COMMISSION_PCT     급여
  FROM employees;

--

SELECT * FROM set1;                    -- 1:AAA, 1:AAA, 2:BBB

SELECT * FROM set2;                    -- 2:BBB:20, 3:CCC:15, 3:CCC:23

/*
집합 연산자

union - 두 집합을 더해서 결과를 출력(합집합), 중복제거, 정렬해줌
union all - 두 집합을 더해서 결과를 출력(합집합), 중복제거하지 않고, 정렬해주지 않음
intersect - 두 집합의 교집합 결과를 출력, 정렬해줌
minus - 두 집합의 차집합 결과를 출력, 정렬해줌

=> 집합 연산자 사용시 주의사항
1) 컬럼의 개수가 일치해야 함
2) 컬럼의 자료형이 일치해야 함(컬럼명은 달라도 상관 없음)
*/
--set1과 set2 테이블 union

SELECT id1, name1 FROM set1
UNION
SELECT id2, name2 FROM set2;                             -- AAA,BBB,CCC => 중복제거됨

-- union all

SELECT id1, name1 FROM set1
UNION ALL
SELECT id2, name2 FROM set2;                             -- AAA,AAA,BBB,BBB,CCC,CCC => 중복제거안됨

--학과가 101인 교수와 학생 명단 조회

SELECT '[교수]'     AS "구분",
       profno         번호,
       name,
       id,
       hiredate,
       deptno
  FROM professor
 WHERE deptno = 101
UNION
SELECT '[학생]'     AS "구분",
       studno         번호,
       name,
       id,
       birthday,
       deptno2
  FROM student
 WHERE deptno1 = 101;

-- intersect

SELECT id1, name1 FROM set1
INTERSECT
SELECT id2, name2 FROM set2;                             -- BBB <= 차집합, 중복제거됨

-- minus

SELECT id1, name1 FROM set1
MINUS
SELECT id2, name2 FROM set2;                             -- AAA <= 차집합, 중복제거됨

SELECT id2, name1 FROM set2
MINUS
SELECT id1, name2 FROM set1;                             -- CCC <= 차집합, 중복제거됨

--product 테이블의 모든 컬럼 가져오기 ? 

SELECT * FROM product;

--dept  테이블의 모든 컬럼 가져오기 ? 

SELECT * FROM dept;

--student 테이블에서 일부 컬럼만 가져오기 

SELECT id, name "학생 이름", birthday FROM student;

-- professor 테이블의 모든 컬럼을 조회하는데, name 내 림차순으로 조회하기 ? 
--조건 : position 이 ‘조교수’ 인 것만 조회 ? 

  SELECT *
    FROM professor
   WHERE position = '조교수'
ORDER BY name DESC;

--2. department 테이블에서 deptno, dname, build 컬럼만 조회 ? 
--조건 : 학과(dname)에 ‘공학’이라는 단어가 들어간 학과만을 조회 하기 ? 
--정렬 : dname 순으로 오름차순으로 정렬 ? 

  SELECT deptno, dname, build
    FROM department
   WHERE dname LIKE '%공학%'
ORDER BY dname;

--3. emp2 테이블에서 name, emp_type, tel, pay, position 컬럼만 조회하되, 
--position 컬럼은 컬럼제목을 ‘직위’로 나타내고 ?
-- 조건 : pay가 3000만원에서 5000만원인 것들만 조회하기 

SELECT name,
       emp_type,
       tel,
       pay,
       position     직위
  FROM emp2
 WHERE pay BETWEEN 30000000 AND 50000000;

-- 4. emp2 테이블에서 name, emp_type, tel, birthday 컬럼만 조회하되, 
--다음 조건에 맞는 데이터만 조회 ? 
--조건 : 생일(birthday)가 1980년도 인 것들만 조회하기(between 이용) 

SELECT name,
       emp_type,
       tel,
       birthday
  FROM emp2
 WHERE birthday BETWEEN '1980-01-01' AND '1980-12-31';

--5. gift 테이블에서 모든 컬럼을 조회하되 ? 
--조건 : gname에 ‘세트’라는 단어가 들어간 레코드만 조회하기 

SELECT *
  FROM gift
 WHERE gname LIKE '%세트%';

--6. emp2 테이블에서 name, position, hobby, birthday 컬럼을 조회하되 ? 
--조건 : position 이 null 이 아닌 것만 조회 ? 생일(birthday) 순으로 오름차순으로 정렬 

  SELECT name,
         position,
         hobby,
         birthday
    FROM emp2
   WHERE position IS NOT NULL
ORDER BY birthday;

--7. emp2 테이블에서 모든 컬럼을 조회하되 ? 
--조건 ? emp_type이 ‘정규직’이거나 ‘계약직’인 것만 조회(in 이용) 

SELECT *
  FROM emp2
 WHERE emp_type IN ('정규직', '계약직');

--8. emp2 테이블에서 emp_type, position 컬럼을 조회하되 ? 
-- 중복된 행(레코드)은 제거 

SELECT DISTINCT emp_type, position
  FROM emp2;

-----------------------------------20.04.17금요일