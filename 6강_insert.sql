/* Formatted on 2020/04/24 오후 6:26:26 (QP5 v5.360) */
--6강_insert.sql
--[2020-04-24 금요일]

/*
<1. insert문> - 데이터를 입력하는 DML
[1] 단일행 입력하기
insert into 테이블명(칼럼1,칼럼2,...) velues(값1,값2,...)
*/
--예1) dept2 테이블에 아래의 새로운 부서 정보를 입력하시오 ? 
--부서번호 : 9000, 부서명: 특판1팀 ? 
--상위부서 : 1006 (영업부), 지역 : 임시지역 

SELECT * FROM dept2;

INSERT INTO dept2 (DCODE,
                   DNAME,
                   PDEPT,
                   AREA)
     VALUES (9000,
             '특판1팀',
             1006,
             '임시지역');

INSERT INTO dept2 (DCODE,
                   DNAME,
                   AREA,
                   PDEPT)
     VALUES (9001,
             '특판2팀',
             '임시지역',
             1006);

--모든 컬럼의 데이터를 입력하는 경우 => 컬럼명 생략 가능

INSERT INTO dept2
     VALUES (9002,
             '특판3팀',
             1006,
             '임시지역');

 -- 일부 컬럼만 입력하는 경우 - not null인 컬럼은 반드시 값을 입력해야 함

DESC dept2;

INSERT INTO dept2 (DCODE, DNAME)
     VALUES (9004, '특판4팀');

INSERT INTO dept2 (DCODE, PDEPT)
     VALUES (9004, 1006);

     -- ORA-01400: cannot insert NULL into ("HR"."DEPT2"."DNAME")

--null 입력하기

/*
1) 데이터를 입력하지 않으면 null이 입력됨
2) 직접 null을 입력해도 null이 입력됨
*/

SELECT * FROM dept2;

INSERT INTO dept2 (dcode, dname, pdept)
     VALUES (9005, '특판5팀', NULL);

-- 날짜 데이터 입력하기

/*
? 아래 정보를 professor 테이블에 입력하시오 ? 
교수번호 : 5001, 교수이름: 김설희 ? 
ID : kimsh, Position : 정교수 ? 
Pay : 510, 입사일 : 2013년 2월 19일 
*/

SELECT * FROM professor;

INSERT INTO professor
     VALUES (5001,
             '김설희',
             'kimsh',
             '정교수',
             510,
             '2013-02-19',
             NULL,
             NULL,
             NULL,
             NULL);

--[2] 여러 행 입력하기

/*
insert into 테이블명()
select문

=> select문의 컬럼의 개수와 데이터 타입이 일치해야 입력 가능함
*/

  SELECT *
    FROM pd
ORDER BY no DESC;

SELECT * FROM product;

INSERT INTO pd (no,
                pdname,
                price,
                regdate)
    SELECT p_code,
           p_name,
           p_price,
           SYSDATE
      FROM product
     WHERE p_code IN (102, 103, 104);

--[3] 테이블을 생성하면서 데이터 입력하기

/*
creat table 신규테이블명
as
select 선택컬럼, 선택컬럼2, ... from 기존 테이블명;

- 신규 테이블을 만들고 동시에 다른 테이블에서 select된 컬럼과 결과 데이터를 insert시킴
- select문의 테이블과 컬럼의 제약조건을 복제되지 않기 때문에 신규 테이블에 대해 
  테이블과 컬럼 제약 조건을 정의해야 함
  * pk(primary key)값도 생성하지 않음
*/

CREATE TABLE professor2
AS
    SELECT * FROM professor;

SELECT * FROM professor2;

--employees, departments 테이블을 조인한 결과를 imsi_tbl을 만들면서 입력

CREATE TABLE imsi_tbl
AS
    SELECT e.EMPLOYEE_ID,
           e.FIRST_NAME || '-' || e.LAST_NAME    name,
           e.HIRE_DATE,
           NVL2 (e.COMMISSION_PCT,
                 e.SALARY + e.SALARY * e.COMMISSION_PCT,
                 salary)                         pay,
           e.DEPARTMENT_ID,
           d.DEPARTMENT_NAME,
           d.LOCATION_ID,
           d.MANAGER_ID
      FROM employees  e
           JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT * FROM imsi_tbl;

/*
=> insert 문에 컬럼 리스트가 없는 상태에서 select문 컬럼 리스트에 함수가 적용됐다면
  별칭을 써서 insert되는 데이터의 컬럼명을 지정해야 함
  그렇지 않으면 에러
*/

CREATE TABLE imsi_tbl2
(
    emp_id,
    name,
    pay,
    deptno,
    dname
)
AS
    SELECT e.employee_id,
           e.first_name || ' ' || e.last_name,
           NVL2 (e.commission_pct,
                 e.salary + e.salary * e.commission_pct,
                 e.salary),
           d.department_id,
           d.department_name
      FROM employees  e
           LEFT JOIN departments d ON e.department_id = d.department_id;

/*
=> create table에서 컬럼명을 지정하명 신규 테이블에 컬럼 리스트가 정의되면서
  select 문을 통해 필요한 데이터가 insert됨
*/

SELECT * FROM imsi_tbl2;

/*
<update> 
- 기존 데이터를 다른 데이터로 변경할 때 사용

update 테이블명
set 컬럼1 = value1, 컬럼2=value2, ...
where 조건;
*/

--예1) Professor 테이블에서 직급이 조교수인 교수들의 bonus를 100만원 으로 인상하시오.

SELECT *
  FROM professor
 WHERE position = '조교수';

UPDATE professor
   SET bonus = 100
 WHERE position = '조교수';

--예2) student 테이블에서  4학년 '김재수' 학생의 2전공(deptno2) 을 101로 수정하시오. 

UPDATE student
   SET deptno2 = 101
 WHERE grade = 4 AND name = '김재수';

SELECT *
  FROM student
 WHERE grade = 4 AND name = '김재수';

--예3) Professor 테이블에서  차범철교수의 직급과 동일한 직급을 가진 교수들 중 현재 급여가 
--250만원이 안 되는 교수들의 급여를 15% 인상하시오.

SELECT *
  FROM professor
 WHERE position = (SELECT position
                     FROM professor
                    WHERE name = '차범철');

UPDATE (SELECT *
          FROM professor
         WHERE position = (SELECT position
                             FROM professor
                            WHERE name = '차범철'))
   SET pay = pay * (1.15)
 WHERE pay < 250;

UPDATE professor
   SET pay = pay * (1.15)
 WHERE     pay < 250
       AND position = (SELECT position
                         FROM professor
                        WHERE name = '차범철');

--다중 건의 update - 서브쿼리를 이용한 update

/*
서브쿼리를 사용하면 한 번의 update 명령으로 여러 개의 컬럼을 수정할 수 있다.
여러 컬럼을 서브쿼리의 결과로 update하면 된다.

다중건의 update를 하기 위해서는 기본적인 update문의 폼을 사용하고
subquery로 추출한 데이터를 setting하려는 컬럼의 데이터값으로 사용함
*/

--1) EMP01 테이블의 사원번호가 7844인 사원의 부서번호와 직무(JOB)를          
--사원번호가 7782인 사원과 같은 직무와 같은 부서로 배정하라  

SELECT job, deptno
  FROM emp
 WHERE empno = 7782;

--MANAGER	10

SELECT *
  FROM emp
 WHERE empno = 7844;

/*
update emp
set job='MANAGER', deptno=10
where empno=7844;
*/

--cf. 다중 컬럼 서브쿼리
--학년별 최대키를 갖는 학생으 ㅣ정보 조회

SELECT *
  FROM student
 WHERE (grade, height) IN (  SELECT grade, MAX (height)
                               FROM student
                           GROUP BY grade);

--

UPDATE emp
   SET (job, deptno) =
           (SELECT job, deptno
              FROM emp
             WHERE empno = 7782)
 WHERE empno = 7844;

--[3] exists를 이용한 다중건의 update

/*
- 서브쿼리의 컬럼값이 존재하는 여부를 체크
- 존재여부만 체크하기 때문에 존재하면 true, 존재하지 않으면 false를 리턴
- true면 업데이트, false면 업데이트 진행하지 않음
*/

--삭제된 코드가 panmae 테이블에 있다면 새 코드로 update하기

SELECT * FROM product;

SELECT * FROM panmae;

SELECT *
  FROM panmae a
 WHERE EXISTS
           (SELECT 1
              FROM product b
             WHERE a.P_CODE = b.P_CODE AND del_yn = 'Y');

--

UPDATE panmae a
   SET p_code =
           (SELECT P_CODE_NEW
              FROM product b
             WHERE a.P_CODE = b.P_CODE)
 WHERE EXISTS
           (SELECT 1
              FROM product b
             WHERE a.P_CODE = b.P_CODE AND del_yn = 'Y');

--emp에서 comm은 기존값보다 100인상하고,
--sal은 job이 CLERK이면 2배, MANAGER이면 3배, 나머지는 4배로 수정하시오

SELECT * FROM emp;

/*
UPDATE emp
   SET comm = comm + 100,
       sal =
           CASE job
               WHEN 'CLERK' THEN sal * 2
               WHEN 'MANAGER' THEN sal * 3
               ELSE sal * 4
           END;
*/


--update 추가
--1) employees 에서 사원번호가 100인 직원의 job_id 를 IT_PROG 로 수정

UPDATE employees
   SET job_id = 'IT_PROG'
 WHERE EMPLOYEE_ID = 100;

--2) employees 에서 사원번호가 100인 직원의 job_id 를 사원번호가 101인 job_id 로 수정

UPDATE employees
   SET job_id =
           (SELECT job_id
              FROM employees
             WHERE EMPLOYEE_ID = 101)
 WHERE EMPLOYEE_ID = 100;

SELECT * FROM employees;

/*
<[3] delete문>
- 데이터를 삭제하는 구문

delete from 테이블
where 조건
*/

--예1) dept2 테이블에서 부서번호(dcode)가 9000번에서 9100번 사이인 매장들을 삭제하시오 

SELECT *
  FROM dept2
 WHERE dcode BETWEEN 9000 AND 9100;

DELETE FROM dept2
      WHERE dcode BETWEEN 9000 AND 9100;

--delete문에서 서브쿼리 이용
--단일행 서브쿼리
--departments에서 10번 부서의 부서장을 employees에서 삭제

SELECT *
  FROM employees
 WHERE EMPLOYEE_ID = 200;

SELECT *
  FROM departments
 WHERE DEPARTMENT_ID = 10;

SELECT *
  FROM employees
 WHERE EMPLOYEE_ID = (SELECT MANAGER_ID
                        FROM departments
                       WHERE DEPARTMENT_ID = 10);

DELETE FROM employees e
      WHERE e.EMPLOYEE_ID = (SELECT MANAGER_ID
                               FROM departments d
                              WHERE d.DEPARTMENT_ID = 10);

-- 부모자식간 제약조건이 걸려잇어서 삭제 에러
-- 새로 만들어서 예제 시행

CREATE TABLE new_employees
AS
    SELECT * FROM employees;

SELECT * FROM new_employees;

DELETE FROM new_employees e
      WHERE e.EMPLOYEE_ID = (SELECT MANAGER_ID
                               FROM departments d
                              WHERE d.DEPARTMENT_ID = 10);

-- departments 에서 location_id 가 1700 인 사원들을 employees 에서 삭제

DELETE FROM new_employees
      WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                FROM departments
                               WHERE location_id = 1700);

DELETE FROM
    new_employees e
      WHERE EXISTS
                (SELECT 1
                   FROM departments d
                  WHERE     e.DEPARTMENT_ID = d.DEPARTMENT_ID
                        AND location_id = 1700);

SELECT * FROM new_employees;

-- 다중컬럼 서브쿼리
--employees에서 직업별 최대 급여를 받는 사원 삭제

DELETE new_employees
 WHERE (JOB_ID, SALARY) IN (  SELECT JOB_ID, MAX (SALARY)
                                FROM new_employees
                            GROUP BY JOB_ID);

-- 상관관계 서브쿼리
-- new_employees 에서 자신의 job_id의 평균 급여보다 많이 받는 사원 삭제

SELECT *
  FROM new_employees a
 WHERE salary > (  SELECT AVG (NVL (SALARY, 0))
                     FROM new_employees b
                    WHERE a.JOB_ID = b.JOB_ID
                 GROUP BY JOB_ID);

DELETE FROM new_employees a
      WHERE salary > (  SELECT AVG (NVL (SALARY, 0))
                          FROM new_employees b
                         WHERE a.JOB_ID = b.JOB_ID
                      GROUP BY JOB_ID);

-- commit, rollback

--insert all을 이용한 여러 테이블에 여러 행 입력하기
-- 예1) 다른 테이블에 한꺼번에 데이터 입력하기 

INSERT ALL
  INTO p_01
VALUES (1, 'AA')
  INTO p_02
VALUES (2, 'BB')
    SELECT * FROM DUAL;

SELECT * FROM p_01;

SELECT * FROM p_02;

-- 예2) 다른 테이블의 데이터를 가져와서 입력하기 ? 
--Professor 테이블에서 교수번호가 1000번에서 1999번까지인 교수의 번호와 교수이름은 p_01 테이블에 입력하고, 
--교수번호가 2000번에서 2999번까지인 교수의 번호와 교수이름은 p_02 테이블에 입력하시오.

  INSERT ALL
    WHEN profno BETWEEN 1000 AND 1999
    THEN
        INTO p_01
          VALUES (profno, name)
    WHEN profno BETWEEN 2000 AND 2999
    THEN
        INTO p_02
          VALUES (profno, name)
    SELECT profno, name FROM professor;

SELECT * FROM p_01;

SELECT * FROM p_02;

--예3) 다른 테이블에 동시에 같은 데이터 입력하기 ? 
--Professor 테이블에서 교수번호가 3000번에서 3999번까지인 교수들의 번호와 교수이름을 
--p_01 테이블과 p_02 테이블에 동시에 입력하시오. 

INSERT ALL
  INTO p_01
VALUES (profno, name)
  INTO p_02
VALUES (profno, name)
    SELECT profno, name
      FROM professor
     WHERE profno BETWEEN 3000 AND 3999;

SELECT * FROM p_01;

SELECT * FROM p_02;

-- dept => dept01 테이블 만들기 ?
-- emp => emp01 테이블 만들기 ? 

--insert ? 
--1) dept01, emp01 테이블에 데이터 입력하기 ? 
--dept01 테이블에는 모든 칼럼 입력, emp01 테이블에는 일부 칼럼만 입력 
 
create table dept01
as
select * from dept;

create table emp01
(EMPNO, ENAME, SAL, job, MGR, HIREDATE, COMM, DEPTNO )
as
select EMPNO, ENAME, SAL, job, MGR, HIREDATE, COMM, DEPTNO from emp;

desc emp01;

--update ? 
--1) DEPT01 테이블의 부서번호가 30인 부서의 위치(LOC)를 '부산'으로 수정 ? 
update dept01
set loc ='부산'
where DEPTNO =30;
--2) DEPT01 테이블의 지역을 모두 '서울'로 수정 ? 
update dept01
set LOC = '서울';
--3) emp01 테이블에서 job이 'MANAGER' 인 사원의 급여(sal)를 10% 인상 
update emp01
set sal = sal*(1.1)
where job= 'MANAGER';


--서브쿼리를 이용한 update ? 
--1) 사원번호가 7934인 사원의 급여와, 직무를 사원번호가 7654인 사원의 직무와 급여 로 수정(emp01 테이블 이용) 
update emp01
set (SAL, JOB) = (select SAL, JOB from emp01 where EMPNO = 7654)
where EMPNO = 7934;

--다른 테이블을 참조한 UPDATE ? 
--1) DEPT01 테이블에서 부서이름이 SALES인 데이터를 찾아 그 부서에 해당되는 
--EMP01 테이블의 사원업무(JOB)를 'SALSEMAN'으로 수정 ? 
update emp01
set job = 'SALSEMAN'
where DEPTNO = (select deptno from dept01 where dname='SALES');

--2) DEPT01 테이블의 위치(loc)가  'DALLAS'인 데이터를 찾아 그 부서에 해당하는 
--EMP01 테이블의 사원들의 직무(JOB)을 'ANALYST'로 수정
update emp01
set job = 'ANALYST'
where DEPTNO = (select deptno from dept01 where loc='DALLAS');


-- DELETE ? 
--1) EMP01테이블에서 7782의 사원번호인 사원정보를 모두 삭제 ? 
delete from emp01
where EMPNO = 7782;
--2) EMP01테이블에서 직무(JOB)이 'CLERK'인 사원들의 정보를 삭제 ? 
delete from emp01
where job='CLERK';

--3) EMP01테이블의 모든 정보를 삭제 후 rollback 
delete from emp01;

--서브쿼리를 이용한 데이터의 삭제 ? 
--1) 'ACCOUNTING'부서명에 대한 부서코드를 DEPT01테이블에서 검색한 후   
--해당 부서코드를 가진 사원의 정보를 EMP01테이블에서 삭제 ? 
delete from emp01
where DEPTNO = (select deptno from dept01 where dname='ACCOUNTING');

--2) DEPT01테이블에서 부서의 위치가 'NEW YORK'인 부서를 찾아   
--EMP01테이블에서 그 부서에 해당하는 사원을 삭제 
delete from emp01
where DEPTNO = (select deptno from dept01 where loc='NEW YORK');