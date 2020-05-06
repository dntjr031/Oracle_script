/* Formatted on 2020/05/06 오전 10:44:40 (QP5 v5.360) */
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

SELECT id, INITCAP (id) FROM student;

SELECT 'pretty girl', INITCAP ('pretty girl') FROM DUAL;

-- 공백 뒤의 문자도 대문자로 바꿔줌

--upper() - 대문자로 변환
--lower() - 소문자로 변환

SELECT id, INITCAP (id), UPPER (id), LOWER (id) FROM student;

SELECT LOWER ('JAVA') FROM DUAL;

SELECT *
  FROM emp
 WHERE ename = 'SCOTT';

SELECT *
  FROM emp
 WHERE LOWER (ename) = 'scott';

--length(), lengthb() - 문자열의 길이를 리턴해주는 함수
--lengthb() - 문자열의 바이트수를 구함(한글 1글자는 2바이트나 3바이트로 처리)
--express 버젼은 3바이트로 처리

SELECT name,
       id,
       LENGTH (name)      "이름의 길이",
       LENGTHB (name)     "이름 바이트수",
       LENGTH (id)        "id 길이",
       LENGTHB (id)       "id의 바이트수"
  FROM student;

--concat(문자열, 문자열) - 두 문자열을 연결해 주는 함수
-- 3개 이상의 문자열을 연결하려면 || 연산자 이용

SELECT name || position            AS "교수 이름",
       CONCAT (name, position)     AS "concat이용",
       name || ' ' || position     AS "|| 연산자 이용"
  FROM professor;

--select concat(naem,' ', position) from professor; -- error

--substr() - 문자열에서 특정 길이의 문자열을 추출할 때 사용

/*
substr(문자열, 시작위치, 추출할 글자수)
-시작위치를 -(음수)로 하면 뒤에서부터 자리수를 계산함
*/

SELECT SUBSTR ('abcdefghi', 2, 3),
       SUBSTR ('abcdefghi', 6),
       SUBSTR ('abcdefghi', -5, 2)
  FROM DUAL;

--bcd, fghi, ef
--2번째 위치에서 3개 추출
-- 6번째 위치에서 끝까지 추출
-- 뒤에서 5번째 위치에서 2개 추출

SELECT SUBSTR ('java오라클', 5, 2),
       SUBSTR ('java오라클', 3, 3),
       SUBSTR ('java오라클', 6),
       SUBSTR ('java오라클', -3, 1)
  FROM DUAL;

--오라, va오, 라클, 오

--캐릭터셋 확인

SELECT parameter, VALUE
  FROM nls_database_parameters
 WHERE parameter LIKE '%CHAR%';

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101 번인 학생들의 이름과 생년월일을 출력 

SELECT name, SUBSTR (jumin, 1, 6) 생년월일
  FROM student
 WHERE deptno1 = 101;

-- student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이 8월인 사람의 이름과 생년월일을 출력 

SELECT name, SUBSTR (jumin, 1, 6) 생년월일
  FROM student
 WHERE SUBSTR (jumin, 3, 2) = 8;

--substrb()

SELECT name, SUBSTR (name, 1, 2), SUBSTRB (name, 1, 3) FROM student;

--instr()- 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr(문자열, 찾는 글자)
--instr(문자열, 찾는 글자, 시작위치, 몇번째인지)
--몇번째의 기본값은 1

SELECT 'A*B*C*',
       INSTR ('A*B*C*', '*'),
       INSTR ('A*B*C*', '*', 3),
       INSTR ('A*B*C*',
              '*',
              3,
              2)
  FROM DUAL;

--2,4,6
--앞에서부터 제일 처음 만나는 *의 위치(오라클에서는 위치값이 1부터 시작)
--3번째 위치 이후에 처음 만나는 *의 위치
--3번째 위치 이후에 2번째로 만나는 *의 위치

SELECT 'A*B*C*',
       INSTR ('A*B*C*', '*', -1),
       INSTR ('A*B*C*', '*', -2),
       INSTR ('A*B*C*',
              '*',
              -2,
              2),
       INSTR ('A*B*C*',
              '*',
              -3,
              2),
       INSTR ('A*B*C*',
              '*',
              -3,
              4)
  FROM DUAL;

--6,4,2,2,0
--뒤에서 첫번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 두 번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 두 번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 네 번째로 만나는 *의 위치 => 없으면 0리턴

--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력 

SELECT name, tel, INSTR (tel, ')') FROM student;

-- student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전 화번호와 지역번호를 출력. 
--단, 지역번호는 숫자만 나와야 함 

SELECT name, tel, SUBSTR (tel, 1, INSTR (tel, ')') - 1) 지역번호
  FROM STUDENT
 WHERE deptno1 = 101;

--파일명만 추출하기

CREATE TABLE test_file
(
    no          NUMBER,
    filepath    VARCHAR2 (100)
);

INSERT INTO test_file
     VALUES (1, 'c:\test\js\example.txt');

INSERT INTO test_file
     VALUES (2, 'd:\css\sample\temp\abc.java');

SELECT * FROM test_file;

-- 파일명만 추출

SELECT no, SUBSTR (filepath, INSTR (filepath, '\', -1) + 1) 파일명
  FROM test_file;

-- 확장자만 추출

SELECT no, SUBSTR (filepath, INSTR (filepath, '.', -1) + 1) 확장자
  FROM test_file;

--순수 파일명만 추출

SELECT no,
       SUBSTR (filepath,
               INSTR (filepath, '\', -1) + 1,
               INSTR (filepath, '.', -1) - INSTR (filepath, '\', -1) - 1)    "순수 파일명"
  FROM test_file;

--lpad(문자열 또는 컬럼명, 자리수, 채울문자)
--문자열의 남은 자리수를 채울 문자로 채운다. 왼쪽부터 채워줌
--RPAD() - 오른쪽부터 채워줌

--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리 로 출력하되 
--왼쪽 빈 자리는 '$'기호로 채우세요 

SELECT name, id, LPAD (id, 10, '$')
  FROM student
 WHERE deptno1 = 101;

-- 실습) DEPT2 테이블을 사용하여 DNAME을 다음 결과가 나오도록 쿼 리 작성하기 ? 
--dname을 총 10바이트로 출력하되 원래 dname이 나오고 나머지 빈 자리는 해당 자 리의 숫자가 나오면 됨. 
--즉, 사장실은 이름이 총 6바이트이므로 숫자가 1234까지 나 옴

SELECT dname, LPAD (dname, 10, '1234567890') FROM dept2;

--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기 호로 채우세요 

SELECT name, id, RPAD (id, 12, '*') FROM student;

--ltrim(문자열이나 컬럼명, 제거할 문자)
--왼쪽에서 해당 문자를 제거한다
--제거할 문자를 생략하면 공백을 제거함

--rtrim() - 오른쪽에서 해당 문자를 제거함

SELECT LTRIM ('javaoracle', 'j'),
       LTRIM ('javaoracle', 'abcdefghijvw'),
       LTRIM ('javaoracle', 'java'),
       RTRIM ('javaoracle', 'oracle'),
       RTRIM ('javaoracle', 'abcelmnopqr'),
       '|' || LTRIM ('   javaoracle'),
       RTRIM ('java oracle   ') || '|'
  FROM DUAL;

 --DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력 

SELECT dname, LTRIM (dname, '영') FROM dept2;

 --DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력 

SELECT dname, RTRIM (dname, '부') FROM dept2;

--reverse()
--어떤 문자열을 거꾸로 보여주는 것

SELECT 'oracle', reverse ('oracle')                 --reverse('대한민국') --한글은 에러
                                    FROM DUAL;

--replace(문자열이나 컬럼명, 문자1, 문자2)
--문자열에서 문자1이 있으면 문자 2로 바꾸어 출력하는 함수

SELECT REPLACE ('javajsp', 'j', 'J'), REPLACE ('javajsp', 'jsp', 'oracle')
  FROM DUAL;

--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표 시되게 출력 

SELECT name, REPLACE (name, SUBSTR (name, 1, 1), '#') FROM student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하 되 
--가운데 글자만 '#'으로 표시되게 출력 

SELECT name, REPLACE (name, SUBSTR (name, 2, 1), '#') 이름
  FROM student
 WHERE deptno1 = 101;



--[2] 숫자 함수
--round(숫자, 원하는 자리수) - 반올림

SELECT 12345.457,
       ROUND (12345.457),
       ROUND (12345.457, 1),
       ROUND (12345.457, 2),
       ROUND (12345.457, -1),
       ROUND (12345.457, -2),
       ROUND (12345.457, -3)
  FROM DUAL;

--12345, 12345.5, 12345.46, 12350, 12300, 12000

/*
정수로 반올림(소수 이하 첫째 자리에서 반올림)
1: 소수이하 1자리만 남긴다(소수이하 둘째 자리에서 반올림)
2: 소수이하 2자리만 남긴다
-1: 1의자리에서 반올림(자리수가 음수인 경우에는 소수 이상에서 처리)
-2: 10의자리에서 반올림
-3: 100의자리에서 반올림
*/

--trunc(숫자, 원하는 자리수) - 버림

SELECT 12345.457,
       TRUNC (12345.457),
       TRUNC (12345.457, 1),
       TRUNC (12345.457, 2),
       TRUNC (12345.457, -1),
       TRUNC (12345.457, -2),
       TRUNC (12345.457, -3)
  FROM DUAL;

--12345, 12345.4, 12345.45, 12340, 12300, 12000

SELECT first_name,
       salary,
       ROUND (salary, -3),
       TRUNC (salary, -3)                                 -- 100의 자리에서 반올림, 버림
  FROM employees;

--mod(숫자, 나누는 수) - 나머지를 구하는 함수
--ceil(소수점이 있는 실수) - 올림(주어진 숫자와 가장 근접한 큰 정수 출력)
--floor(소수점이 있는 실수) - 내림(가장 근접한 작은 정수)
--power(숫자1, 숫자2) - 숫자1의 숫자2승

SELECT MOD (13, 3), CEIL (12.3), FLOOR (17.87), POWER (3, 4) FROM DUAL;

--[3] 날짜 함수
--1) 며칠 전, 며칠 후

/*
오늘부터 100일 후, 100일 전
2020-04-17 + 100 => 날짜
2020-04-17 - 100 => 날짜
=> 더하고 빼는 기준은 일수
*/

--sysdate : 현재일자를 리턴하는 함수

SELECT SYSDATE FROM DUAL;

SELECT SYSDATE           AS 현재일자,
       SYSDATE + 100     AS "100일 후",
       SYSDATE - 100     AS "100일 전",
       SYSDATE + 1       하루후,
       SYSDATE - 1       하루전
  FROM DUAL;

--2일 1시간 5분 10초 후 날짜 구하기

SELECT SYSDATE                                                       현재일자,
       SYSDATE + 2 + 1 / 24 + 5 / (24 * 60) + 10 / (24 * 60 * 60)    "2일 1시간 5분 10초 후"
  FROM DUAL;

--3개월 후 날짜, 3개월전 날짜
--add_months(날짜, 개월수) : 해당날짜로부터 개월수 만큼 더하거나 뺀 날짜를 구한다
--=> 몇 개월 후, 몇 개월 전에 해당하는 날짜를 구할 수 있다

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 3)      AS "3개월 후",
       ADD_MONTHS (SYSDATE, -3)     "3개월 전"
  FROM DUAL;

--1년 후, 1년 전 날짜

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 12)      AS "1년 후",
       ADD_MONTHS (SYSDATE, -12)     AS "1년 전"
  FROM DUAL;

-- 2년 4개월 1일 3시간 10분 20초 후의 날짜 구하기

SELECT SYSDATE,
       ADD_MONTHS (SYSDATE, 2 * 12 + 4)
           "2년 4개월 후",
         ADD_MONTHS (SYSDATE, 2 * 12 + 4)
       + 1
       + 3 / 24
       + 10 / (24 * 60)
       + 20 / (24 * 60 * 60)
  FROM DUAL;

--to_yminterval()
--to_dsinterval()

SELECT SYSDATE,
       SYSDATE + TO_YMINTERVAL ('02-04')
           "2년 4개월 후",
       SYSDATE + TO_DSINTERVAL ('1 03:10:20')
           "1일 3시간 10분 20초 후",
       SYSDATE + TO_YMINTERVAL ('02-04') + TO_DSINTERVAL ('1 03:10:20')
           AS "2-4-1 3:10:20후"
  FROM DUAL;

--2)두 날짜 사이의 경과된 시간(일수)
--올해 1/1 부터 며칠 경과되었는지
--2020-04-17 - 2020-01-01 => 숫자

SELECT '2020-04-17' - '2020-01-01' FROM DUAL;                                                                                                                                                                                     --error

SELECT TO_DATE ('2020-04-17') - TO_DATE ('2020-01-01') FROM DUAL;

--to_date(문자) => 문자를 날짜형태로 변환해주는 함수

--어제부터 오늘까지 경과된 일수, 오늘부터 내일까지 남은 일수

SELECT TO_DATE ('2020-04-17') - TO_DATE ('2020-04-16')     "어제부터",
       TO_DATE ('2020-04-18') - TO_DATE ('2020-04-17')     "내일까지"
  FROM DUAL;

SELECT SYSDATE,
       SYSDATE - TO_DATE ('2020-04-16')     "어제부터",
       TO_DATE ('2020-04-18') - SYSDATE     "내일까지"
  FROM DUAL;                                               -- 현재일자는 시간이 포함되서 결과가 예상과 다름

--시간을 제외한 두 날짜 사이의 일수를 구하는 경우

SELECT SYSDATE,
       TRUNC (SYSDATE),
       TO_DATE ('2020-04-18') - TRUNC (SYSDATE)     "내일까지"
  FROM DUAL;                                               -- 현재일자는 시간이 포함
-- trunc(날짜) : 해당 날짜를 리턴함(시간 빼고)
-- round(날짜) : 해당 날짜를 반올림해서 리턴(정오 기준)

--두 날짜 사이의 개월 수
--months_between() - 두 날짜 사이의 개월수를 구해줌

SELECT MONTHS_BETWEEN ('2020-04-17', '2020-02-17'),
       MONTHS_BETWEEN ('2020-04-17', '2020-02-01'),
       MONTHS_BETWEEN ('2020-04-17', '2020-02-23')
  FROM DUAL;

--next_day()

/*
주어진 날짜를 기준으로 돌아오는 가장 최근 요일의 날짜를 반환해 주는 함수
요일명 대신 숫자를 입력할 수도 있다.
1:일 2:월 ... 7:토
*/

SELECT SYSDATE,
       NEXT_DAY (SYSDATE, '월'),
       NEXT_DAY (SYSDATE, '화요일'),
       NEXT_DAY (SYSDATE, 1),
       NEXT_DAY ('2020-05-01', 4)
  FROM DUAL;

--last_day()
--주어진 날짜가 속한 달의 가장 마지막 날을 출력해주는 함수

SELECT SYSDATE,
       LAST_DAY (SYSDATE),
       LAST_DAY ('2020-02-10'),
       LAST_DAY ('2020-08-05'),
       LAST_DAY ('2019-02-03')
  FROM DUAL;

-- trunc(날짜) : 해당 날짜를 리턴함(시간 빼고)
-- round(날짜) : 해당 날짜를 반올림해서 리턴(정오 기준)
-- => 둘다 시간은 제외됨

SELECT SYSDATE, ROUND (SYSDATE), TRUNC (SYSDATE) FROM DUAL;

--사원의 입사일 50일 후의 날짜 구하기

SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       HIRE_DATE + 50     "50일 후"
  FROM employees;

--입사일 3개월 후의 날짜 구하기

SELECT FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       ADD_MONTHS (HIRE_DATE, 3)     "3개월 후"
  FROM employees;

--수료일까지 남은 일수

SELECT TO_DATE ('2020-08-19') - TRUNC (SYSDATE) || '일'    "수료일까지"
  FROM DUAL;

--수료일까지 남은 개월수

SELECT    MONTHS_BETWEEN (LAST_DAY ('2020-08-19'), LAST_DAY (SYSDATE))
       || '개월'    "수료일까지"
  FROM DUAL;

--[4] 형변환 함수

/*
<오라클의 자료형>
문자 - char(고정길이형), varchar2(기변 길이형)
숫자 - number
날짜 - date

<형변환>
1) 자동 형변환
2) 명시적 형변환
to_char() - 숫자, 날짜를 문자로
to_number() - 문자를 숫자로
to_date() - 문자를 날짜로
*/

--자동 형변환

SELECT 1 + '2', 2 + '003' FROM DUAL;

-- =>숫자 형태의 문자를 연산하면 해당 문자를 숫자로 자동형변환한 후 연산함

SELECT '004', 1 + TO_NUMBER ('2'), 2 + TO_NUMBER ('003') FROM DUAL;

--(1-1) to_char(날짜, 패턴) - 날짜를 문자로 변환한다

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'yyyy'),
       TO_CHAR (SYSDATE, 'mm'),
       TO_CHAR (SYSDATE, 'dd'),
       TO_CHAR (SYSDATE, 'd')     요일
  FROM DUAL;

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'year'),
       TO_CHAR (SYSDATE, 'mon'),
       TO_CHAR (SYSDATE, 'month'),
       TO_CHAR (SYSDATE, 'day'),                            -- 요일(월요일,화요일,...)
       TO_CHAR (SYSDATE, 'dy'),                                -- 요일(월, 화,...)
       TO_CHAR (SYSDATE, 'q'),                                           -- 분기
       TO_CHAR (SYSDATE, 'ddd')                                  -- 1년 중 며칠째인지
  FROM DUAL;

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'yyyy-mm-dd'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh24:mi:ss'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss am'),
       TO_CHAR (SYSDATE, 'yyyy-mm-dd hh:mi:ss pm day')
  FROM DUAL;

--특정 날짜에서 년도만 추출, 월만 추출, 일만 추출

SELECT EXTRACT (YEAR FROM SYSDATE)      년도,
       EXTRACT (MONTH FROM SYSDATE)     월,
       EXTRACT (DAY FROM SYSDATE)       일
  FROM DUAL;

--실습) STUDENT 테이블의 birthday 칼럼을 참조하여 생일 이 3월인 학생의 이름과 birthday를 출력 

SELECT name, birthday
  FROM student
 WHERE EXTRACT (MONTH FROM birthday) = 3;

SELECT name, birthday
  FROM student
 WHERE TO_CHAR (birthday, 'mm') = 3;

--(1-2) to_char(숫자, 패턴) - 숫자를 패턴이 적용된 문자로 변환

/*
9 : 남은자리를 공백으로 채움
0 : 남은자리를 0으로 채움
*/

SELECT 1234,
       TO_CHAR (1234, '99999'),
       TO_CHAR (1234, '099999'),
       TO_CHAR (1234, '$99999'),
       TO_CHAR (1234, 'L99999'),
       TO_CHAR (1234.56, '9999.9'),
       TO_CHAR (1234, '$99,999'),
       TO_CHAR (123456789, '999,999,999'),
       TO_CHAR (1234.56, '9999')
  FROM DUAL;

--Professor 테이블을 참조하여 101번 학과 교수들 의 이름과 연봉을 출력하시오. 
--단 연봉은 (pay*12)+bonus 로 계산하고 천 단위 구분기호로 표시하시오

SELECT NAME 이름, TO_CHAR ((pay * 12) + bonus, '99,999') 연봉
  FROM professor
 WHERE DEPTNO = 101;

--(2) to_date(문자, 패턴) - 문자를 날짜로 변환

SELECT TO_DATE ('2020-05-09'),
       TO_DATE ('2020-05-09', 'yyyy-mm-dd'),
       TO_DATE ('2020/05/09', 'yyyy/mm/dd'),
       TO_DATE ('2020-05-09 16:20:35', 'yyyy-mm-dd hh24:mi:ss')
  FROM DUAL;

SELECT *
  FROM professor
 WHERE hiredate >= '1995-01-01';

SELECT '2020-04-03' - '2020-01-01' FROM DUAL;                                                                                                                                                                                     --error

SELECT TO_DATE ('2020-04-03') - TO_DATE ('2020-01-01') FROM DUAL;

--2020-03-07 ~ 2020-04-16까지의 데이터 조회

SELECT *
  FROM pd
 WHERE regdate BETWEEN '2020-03-07'
                   AND TO_DATE ('2020-04-16 23:59:59',
                                'yyyy-mm-dd hh24:mi:ss');

--등록한지 몇 시간이 지났는지 조회

SELECT PDNAME, PRICE, REGDATE, (SYSDATE - regdate) * 24 경과시간 FROM pd;


--2020-04-20월요일

--(3) to_number(문자) - 문자를 숫자로 변환

SELECT '10'                       AS 문자,
       10                         AS 숫자1,
       TO_NUMBER ('10')           AS 숫자2,
       TO_NUMBER ('003') + 20     AS 숫자3,
       '005' + 30                 AS 숫자4
  FROM DUAL;

--[실습]Professor 테이블을 사용하여 1990년 이전에 입사한 교수명과 입사일, 
--현재 연봉과 10% 인상 후 연봉을 출력하시오.      
--연봉은 상여금(bonus)를 제외한 (pay*12)로 계산하고 연봉과 인상 후 연봉은 
--천 단위 구분 기호를 추가하여 출력하시오. 

SELECT NAME,
       HIREDATE,
       TO_CHAR (PAY * 12, '9,999')           연봉,
       TO_CHAR (pay * 1.1 * 12, '9,999')     "인상 후 연봉"
  FROM professor;

--[5]일반 함수
--nvl(컬럼, 치환할 값) - 해당 컬럼이 null이면 치환할 값으로 바꾸는 함수

SELECT name,
       bonus,
       NVL (bonus, 0),
       hpage,
       NVL (hpage, '홈페이지 없음')
  FROM professor;

--Professor 테이블에서 101번 학과 교수들의 이름과 급여, bonus, 연봉을 출력하시오. 
--단, 연봉은 (pay*12+bonus)로 계산 하고 bonus가 없는 교수는 0으로 계산하시오. 

SELECT NAME                                 이름,
       pay                                  급여,
       NVL (BONUS, 0)                       bonus,
       NVL (PAY * 12 + bonus, PAY * 12)     연봉
  FROM professor;

--nvl2(col1, col2, col3) : col1의 값이 null이 아니면 col2를, null이면 col3를 출력

--nvl2 이용
--Professor 테이블에서 101번 학과 교수들의 이름과 급여, bonus, 연봉을 출력하시오. 
--단, 연봉은 (pay*12+bonus)로 계산 하고 bonus가 없는 교수는 0으로 계산하시오. 

SELECT NAME                                         이름,
       pay                                          급여,
       NVL (BONUS, 0)                               bonus,
       NVL2 (bonus, PAY * 12 + bonus, PAY * 12)     연봉
  FROM professor;

--employees
--이름(first_name - last_name), 입사일, salary(기본급), 수당퍼센트(commission_pct),
-- 연봉(기본급+기본급*수당퍼센트)*12(수당퍼센트가 null이면 연봉은 기본급*12)

SELECT FIRST_NAME || '-' || LAST_NAME                            이름,
       HIRE_DATE                                                 입사일,
       SALARY                                                    기본급,
       NVL (COMMISSION_PCT, 0)                                   수당퍼센트,
       NVL (salary * (1 + commission_pct) * 12, salary * 12)     연봉
  FROM employees;

SELECT FIRST_NAME || '-' || LAST_NAME    이름,
       HIRE_DATE                         입사일,
       SALARY                            기본급,
       NVL (COMMISSION_PCT, 0)           수당퍼센트,
       TO_CHAR (
           NVL2 (commission_pct,
                 salary * (1 + commission_pct) * 12,
                 salary * 12),
           '$999,999')                   연봉
  FROM employees;

--decode() 함수 : if문을 대신하는 함수

/*
    decode(A, B, 참, 거짓)
    => A가 B와 같으면 참을 하고, 그렇지 않으면 거짓을 처리한다.
*/
--student에서 grade가 1이면 1학년, 2이면 2학년, 3이면 3학년, 4이면 4학년을 출력

SELECT grade,
       DECODE (grade,
               1, '1학년',
               2, '2학년',
               3, '3학년',
               4, '4학년')    "학년"
  FROM student;

--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번 인 교수만 
--컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 아무것 도 출력하지 마세요. 

SELECT NAME, DEPTNO, DECODE (deptno, 101, '컴퓨터 공학과') "학과명"
  FROM professor;

-- Professor 테이블에서 교수명, 학과번호 , 학과명을 출력하되 
--deptno가 101번인 교수만 컴퓨터 공학과로 출력하고 101 번이 아닌 교수들은 학과명에 ‘기타학과 ’로 출력하세요. 

SELECT name,
       deptno,
       DECODE (deptno, 101, '컴퓨터 공학과', '기타학과')    "학과명"
  FROM professor;

-- Professor 테이블에서 교수명, 학과명을 출력하되 deptno가 101번이면 ‘컴퓨터 공학과’, 
--102번이면 ‘멀티미디어 공학과 ’, 103번이면 ‘소프트웨어 공학과’, 나머 지는 ‘기타학과’로 출력하세요. 

SELECT name,
       deptno,
       DECODE (deptno,
               101, '컴퓨터 공학과',
               102, '멀티미디어 공학과',
               103, '소프트웨어 공학과',
               '기타학과')    "학과명"
  FROM professor;

-- Professor 테이블에서 교수명, 부서번호 를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 ‘석좌 교수 후보’라고 출력하세요. 나머지는 null 값 출력. 

SELECT NAME,
       DEPTNO,
       DECODE (deptno,
               101, DECODE (name, '조인형', '석좌 교수 후보'))    "비고"
  FROM professor;

--Professor 테이블에서 교수명, 부서번호 를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 비고 란에 ‘석좌교수 후보’라고 출력하세요. 101번 학과의 조인형 교수 외에는 
--비고 란에 ‘후보아님’을 출력하고 101번 교수 가 아닐 경우는 비고란이 공란이 되도록 

SELECT NAME,
       DEPTNO,
       DECODE (
           deptno,
           101, DECODE (name,
                        '조인형', '석좌 교수 후보',
                        '후보아님'))    "비고"
  FROM professor;

--요일 출력

SELECT SYSDATE,
       TO_CHAR (SYSDATE, 'd'),
       DECODE (TO_CHAR (SYSDATE, 'd'),
               '1', '일',
               '2', '월',
               '3', '화',
               '4', '수',
               '5', '목',
               '6', '금',
               '7', '토')    "요일"
  FROM DUAL;

--Student 테이블을 사용하여 제 1전공(deptno1)이 101번인 학과 학생들의 이 름(name)과 주민번호(jumin), 
--성별을 출력하되 성별은 주민번호 칼럼을 이용 하여 7번째 숫자가 1일 경우 ‘남자’, 2일 경우 ‘여자’로 출력하세요 

SELECT name,
       jumin,
       DECODE (SUBSTR (jumin, 7, 1),  '1', '남자',  '2', '여자')    성별
  FROM student
 WHERE deptno1 = 101;

--Student 테이블에서 제 1전공(deptno1)이 101번인 학생들의 이름(name)과 전화번호(tel), 지역명을 
--출력하세요. 지역명은 지역번호가 02는 서울, 031은 경기, 051은 부산,052는 울산, 055는 경남으로 출력하세요 

SELECT name,
       tel,
       DECODE (SUBSTR (tel, 1, INSTR (tel, ')') - 1),
               '02', '서울',
               '031', '경기',
               '051', '부산',
               '052', '울산',
               '055', '경남')    "지역명"
  FROM student
 WHERE deptno1 = 101;

--case 표현식 : if문을 대신하는 함수, 조건이 범위값을 가질 때도 사용 가능

/*
[1]동일값 비교시 (=로 비교되는 경우)
    case 조건 when 결과1 then 출력1
            when 결과2 then 출력2
            else 출력3
    end "별칭"
[2]범위값 비교시
    case when 조건1 then 출력1
        when 조건2 then 출력2
        else 출력3
    end "별칭"
*/
--학년 출력하기

SELECT name,
       grade,
       CASE grade
           WHEN 1 THEN '1학년'
           WHEN 2 THEN '2학년'
           WHEN 3 THEN '3학년'
           WHEN 4 THEN '4학년'
       END                   "학년1",
       CASE grade
           WHEN 1 THEN '1학년'
           WHEN 2 THEN '2학년'
           WHEN 3 THEN '3학년'
           ELSE '4학년'
       END                   "학년2",
       DECODE (grade,
               1, '1학년',
               2, '2학년',
               3, '3학년',
               '4학년')    "학년3"
  FROM student;

--professor에서 pay가 400초과, 300~400사이, 300미만으로 구분

SELECT name,
       pay,
       CASE
           WHEN pay > 400 THEN '400초과'
           WHEN pay BETWEEN 300 AND 400 THEN '300~400사이'
           WHEN pay < 300 THEN '300미만'
       END    "급여 범위"
  FROM professor;

--지역번호, 지역명

SELECT name,
       tel,
       SUBSTR (tel, 1, INSTR (tel, ')') - 1)    "지역번호",
       CASE SUBSTR (tel, 1, INSTR (tel, ')') - 1)
           WHEN '02' THEN '서울'
           WHEN '031' THEN '경기도'
           WHEN '051' THEN '부산'
           WHEN '052' THEN '울산'
           WHEN '053' THEN '대구'
           WHEN '055' THEN '경남'
       END                                      "지역"
  FROM student;

-- Student 테이블의 JUMIN 칼럼을 참조하여 학생들의 이름과 태어난 달, 분기를 출 력하세요. 태어난 달이 
--01~03월은 1/4분기, 04~06월은 2/4분기, 07~09월은 3/4 분기, 10~12월은 4/4분기로 출력하세요

SELECT name,
       jumin,
       SUBSTR (jumin, 3, 2)    "태어난 달",
       CASE
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4분기'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4분기'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '06' AND '09' THEN '3/4분기'
           WHEN SUBSTR (jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4분기'
       END                     분기
  FROM student;

--total을 이용해서 학점 구하기
--90이상 A, 80이상 B, 70이상 C, 60이상 D, 나머지 F

SELECT studno,
       total,
       TRUNC (total / 10),
       TRUNC (total, -1),
       CASE
           WHEN total >= 90 THEN 'A'
           WHEN total >= 80 THEN 'B'
           WHEN total >= 70 THEN 'C'
           WHEN total >= 60 THEN 'D'
           ELSE 'F'
       END             학점1,
       DECODE (TRUNC (total / 10),
               10, 'A',
               9, 'A',
               8, 'B',
               7, 'C',
               6, 'D',
               'F')    학점2,
       CASE TRUNC (total, -1)
           WHEN 100 THEN 'A'
           WHEN 90 THEN 'A'
           WHEN 80 THEN 'B'
           WHEN 70 THEN 'C'
           WHEN 60 THEN 'D'
           ELSE 'F'
       END             학점3
  FROM EXAM_01;

--성별, gogak

SELECT gno,
       gname,
       jumin,
       point,
       CASE SUBSTR (jumin, 7, 1)
           WHEN '1' THEN '남'
           WHEN '3' THEN '남'
           ELSE '여'
       END                                                                       성별,
       CASE WHEN SUBSTR (jumin, 7, 1) IN ('1', '3') THEN '남' ELSE '여' END    성별2
  FROM gogak;

--나이구하기

  SELECT gno,
         gname,
         jumin,
         point,
         TO_CHAR (SYSDATE, 'yyyy')    현재연도,
           TO_CHAR (SYSDATE, 'yyyy')
         - (  SUBSTR (jumin, 1, 2)
            + CASE
                  WHEN SUBSTR (jumin, 7, 1) IN ('1', '2') THEN 1900
                  ELSE 2000
              END)
         + 1                          나이
    FROM gogak
ORDER BY 나이;

-- 매년 말일이 월급날, 토,일일경우 전 금요일에 나옴
-- 월급날짜 구하기 현재날짜, 5월, 10월
--[1] 말일의 요일

SELECT SYSDATE,
       LAST_DAY (SYSDATE),
       TO_CHAR (LAST_DAY (SYSDATE), 'd'),
       DECODE (TO_CHAR (LAST_DAY (SYSDATE), 'd'),
               '1', '일',
               '2', '토',
               '3', '토',
               '4', '토',
               '5', '토',
               '6', '토',
               '7', '토')    요일
  FROM DUAL;

--[2] 말일이 토~, 일~ 이면

SELECT SYSDATE,
       TO_CHAR (LAST_DAY (SYSDATE), 'd'),
       DECODE (TO_CHAR (LAST_DAY (SYSDATE), 'd'),
               '7', LAST_DAY (SYSDATE) - 1,
               '1', LAST_DAY (SYSDATE) - 2,
               LAST_DAY (SYSDATE))    월급날
  FROM DUAL;

SELECT '2020-05-05',
       TO_CHAR (LAST_DAY ('2020-05-05'), 'd'),
       DECODE (TO_CHAR (LAST_DAY ('2020-05-05'), 'd'),
               '7', LAST_DAY ('2020-05-05') - 1,
               '1', LAST_DAY ('2020-05-05') - 2,
               LAST_DAY ('2020-05-05'))    월급날
  FROM DUAL;

SELECT '2020-10-24',
       TO_CHAR (LAST_DAY ('2020-10-24'), 'dy')    요일,
       DECODE (TO_CHAR (LAST_DAY ('2020-10-24'), 'd'),
               '7', LAST_DAY ('2020-10-24') - 1,
               '1', LAST_DAY ('2020-10-24') - 2,
               LAST_DAY ('2020-10-24'))           월급날
  FROM DUAL;

--실습 ? Professor 테이블을 조회하여 교수의 급여액수(pay)를 기준으 로 200 미만은 4급, 
--201~300은 3급, 301~400은 2급, 401 이상은 1 급으로 표시하여 교수의 번호(profno), 
--교수이름(name), 급여(pay), 등급을 출력하세요. 단, pay 칼럼을 내림차순으로 정렬하세요. 

  SELECT profno,
         name,
         pay,
         CASE
             WHEN pay <= 200 THEN '4급'
             WHEN pay BETWEEN 201 AND 300 THEN '3급'
             WHEN pay BETWEEN 301 AND 400 THEN '2급'
             ELSE '1급'
         END    등
    FROM professor
ORDER BY pay DESC;

--emp 테이블에서 sal 이 2000 보다 크면 보너스는 1000, 1000보다 크면 500, 
--나머지는 0 으로 표시하세요 

SELECT ename,
       sal,
       CASE WHEN sal > 2000 THEN 1000 WHEN sal > 1000 THEN 500 ELSE 0 END    보너스
  FROM emp;