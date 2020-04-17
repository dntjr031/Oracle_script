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
select id, initcap(id) from student;

select 'pretty girl', initcap('pretty girl') from dual;
-- 공백 뒤의 문자도 대문자로 바꿔줌

--upper() - 대문자로 변환
--lower() - 소문자로 변환
select id, initcap(id), upper(id), lower(id) from student;

select lower('JAVA') from dual;

select * from emp where ename='SCOTT';

select * from emp where lower(ename)='scott';

--length(), lengthb() - 문자열의 길이를 리턴해주는 함수
--lengthb() - 문자열의 바이트수를 구함(한글 1글자는 2바이트나 3바이트로 처리)
--express 버젼은 3바이트로 처리

select name, id, length(name) "이름의 길이", lengthb(name) "이름 바이트수"
    , length(id) "id 길이", lengthb(id) "id의 바이트수"
from student;

--concat(문자열, 문자열) - 두 문자열을 연결해 주는 함수
-- 3개 이상의 문자열을 연결하려면 || 연산자 이용
select name || position as "교수 이름", concat(name, position) as "concat이용",
    name || ' ' || position as "|| 연산자 이용"
from professor;

--select concat(naem,' ', position) from professor; -- error

--substr() - 문자열에서 특정 길이의 문자열을 추출할 때 사용
/*
substr(문자열, 시작위치, 추출할 글자수)
-시작위치를 -(음수)로 하면 뒤에서부터 자리수를 계산함
*/
select substr('abcdefghi', 2, 3),
    substr('abcdefghi', 6),
    substr('abcdefghi', -5, 2) 
from dual;
--bcd, fghi, ef
--2번째 위치에서 3개 추출
-- 6번째 위치에서 끝까지 추출
-- 뒤에서 5번째 위치에서 2개 추출

select substr('java오라클',5,2),
    substr('java오라클',3,3),
    substr('java오라클',6),
    substr('java오라클',-3,1)
from dual;
--오라, va오, 라클, 오

--캐릭터셋 확인
select  parameter, value from nls_database_parameters
where parameter like '%CHAR%';

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101 번인 학생들의 이름과 생년월일을 출력 
select name, substr(jumin,1,6) 생년월일 from student where deptno1=101;

-- student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이 8월인 사람의 이름과 생년월일을 출력 
select name, substr(jumin,1,6) 생년월일 from student 
where substr(jumin,3,2)=8;

--substrb()
select name, substr(name,1,2), substrb(name,1,3) from student;

--instr()- 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr(문자열, 찾는 글자)
--instr(문자열, 찾는 글자, 시작위치, 몇번째인지)
--몇번째의 기본값은 1

select 'A*B*C*', instr('A*B*C*', '*'), instr('A*B*C*', '*',3)
    , instr('A*B*C*', '*',3,2) from dual;
--2,4,6
--앞에서부터 제일 처음 만나는 *의 위치(오라클에서는 위치값이 1부터 시작)
--3번째 위치 이후에 처음 만나는 *의 위치
--3번째 위치 이후에 2번째로 만나는 *의 위치

select 'A*B*C*', instr('A*B*C*', '*',-1), instr('A*B*C*', '*',-2)
    , instr('A*B*C*', '*',-2,2), instr('A*B*C*', '*',-3,2) 
    , instr('A*B*C*', '*',-3,4)from dual;
--6,4,2,2,0
--뒤에서 첫번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 두 번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 두 번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 네 번째로 만나는 *의 위치 => 없으면 0리턴

--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력 
select name, tel, instr(tel, ')') from student;

-- student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전 화번호와 지역번호를 출력. 
--단, 지역번호는 숫자만 나와야 함 
select name, tel, substr(tel, 1, instr(tel,')')-1) 지역번호 from STUDENT 
where deptno1=101;

--파일명만 추출하기
create table test_file
(
    no number,
    filepath varchar2(100)
);

insert into test_file values(1, 'c:\test\js\example.txt');
insert into test_file values(2, 'd:\css\sample\temp\abc.java');

select * from test_file;

-- 파일명만 추출
select no, 
    substr(filepath, instr(filepath,'\',-1)+1) 파일명
from test_file;

-- 확장자만 추출
select no, 
    substr(filepath, instr(filepath,'.',-1)+1) 확장자
from test_file;

--순수 파일명만 추출
select no, 
    substr(filepath, instr(filepath,'\',-1)+1, 
        instr(filepath, '.',-1)-instr(filepath,'\',-1)-1) "순수 파일명"
from test_file;

--lpad(문자열 또는 컬럼명, 자리수, 채울문자)
--문자열의 남은 자리수를 채울 문자로 채운다. 왼쪽부터 채워줌
--RPAD() - 오른쪽부터 채워줌

--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리 로 출력하되 
--왼쪽 빈 자리는 '$'기호로 채우세요 
select name, id, lpad(id, 10, '$') from student where deptno1=101;

-- 실습) DEPT2 테이블을 사용하여 DNAME을 다음 결과가 나오도록 쿼 리 작성하기 ? 
--dname을 총 10바이트로 출력하되 원래 dname이 나오고 나머지 빈 자리는 해당 자 리의 숫자가 나오면 됨. 
--즉, 사장실은 이름이 총 6바이트이므로 숫자가 1234까지 나 옴
select dname, lpad(dname, 10, '1234567890') from dept2;

--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기 호로 채우세요 
select name, id, rpad(id,12,'*') from student;

--ltrim(문자열이나 컬럼명, 제거할 문자)
--왼쪽에서 해당 문자를 제거한다
--제거할 문자를 생략하면 공백을 제거함

--rtrim() - 오른쪽에서 해당 문자를 제거함

select ltrim('javaoracle','j'), ltrim('javaoracle','abcdefghijvw'),
    ltrim('javaoracle','java'), rtrim('javaoracle','oracle'),
    rtrim('javaoracle','abcelmnopqr') , '|' || ltrim('   javaoracle')
    , rtrim('java oracle   ') || '|'
from dual;

 --DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력 
select dname, ltrim(dname, '영') from dept2;

 --DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력 
select dname, rtrim(dname, '부') from dept2;

--reverse()
--어떤 문자열을 거꾸로 보여주는 것
select 'oracle', reverse('oracle') 
--reverse('대한민국') --한글은 에러남
from dual;

--replace(문자열이나 컬럼명, 문자1, 문자2)
--문자열에서 문자1이 있으면 문자 2로 바꾸어 출력하는 함수

select replace('javajsp','j','J'), replace('javajsp', 'jsp', 'oracle')
from dual;

--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표 시되게 출력 
select name, replace(name, substr(name,1,1), '#') from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하 되 
--가운데 글자만 '#'으로 표시되게 출력 
select name, replace(name, substr(name,2,1),'#') 이름
from student
where deptno1=101;
 


--[2] 숫자 함수
--round(숫자, 원하는 자리수) - 반올림
select 12345.457, round(12345.457),
    round(12345.457,1),round(12345.457,2),
    round(12345.457,-1),round(12345.457,-2),
    round(12345.457,-3) from dual;
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
select 12345.457, trunc(12345.457),
    trunc(12345.457,1),trunc(12345.457,2),
    trunc(12345.457,-1),trunc(12345.457,-2),
    trunc(12345.457,-3) from dual;
--12345, 12345.4, 12345.45, 12340, 12300, 12000

select first_name, salary, round(salary, -3),
    trunc(salary, -3) from employees; -- 100의 자리에서 반올림, 버림

--mod(숫자, 나누는 수) - 나머지를 구하는 함수
--ceil(소수점이 있는 실수) - 올림(주어진 숫자와 가장 근접한 큰 정수 출력)
--floor(소수점이 있는 실수) - 내림(가장 근접한 작은 정수)
--power(숫자1, 숫자2) - 숫자1의 숫자2승
select mod(13,3), ceil(12.3), floor(17.87), power(3,4) from dual;

--[3] 날짜 함수
--1) 며칠 전, 며칠 후
/*
오늘부터 100일 후, 100일 전
2020-04-17 + 100 => 날짜
2020-04-17 - 100 => 날짜
=> 더하고 빼는 기준은 일수
*/

--sysdate : 현재일자를 리턴하는 함수
select sysdate from dual;

select sysdate as 현재일자, sysdate+100 as "100일 후",
    sysdate-100 as "100일 전", sysdate+1 하루후, sysdate-1 하루전 from dual;
    
--2일 1시간 5분 10초 후 날짜 구하기
select sysdate 현재일자, 
    sysdate+2+1/24+5/(24*60)+10/(24*60*60) "2일 1시간 5분 10초 후"
from dual;

--3개월 후 날짜, 3개월전 날짜
--add_months(날짜, 개월수) : 해당날짜로부터 개월수 만큼 더하거나 뺀 날짜를 구한다
--=> 몇 개월 후, 몇 개월 전에 해당하는 날짜를 구할 수 있다
select sysdate, add_months(sysdate, 3) as "3개월 후",
    add_months(sysdate, -3) "3개월 전" from dual;

--1년 후, 1년 전 날짜
select sysdate, add_months(sysdate, 12) as "1년 후"
    , add_months(sysdate, -12) as "1년 전" from dual;
    
-- 2년 4개월 1일 3시간 10분 20초 후의 날짜 구하기
select sysdate, add_months(sysdate, 2*12+4) "2년 4개월 후",
    add_months(sysdate, 2*12+4) + 1 + 3/24 + 10/(24*60) + 20/(24*60*60)
from dual;

--to_yminterval()
--to_dsinterval()

select sysdate, sysdate+to_yminterval('02-04') "2년 4개월 후",
    sysdate+to_dsinterval('1 03:10:20') "1일 3시간 10분 20초 후",
    sysdate + to_yminterval('02-04') + to_dsinterval('1 03:10:20')
    as "2-4-1 3:10:20후"
from dual;

--2)두 날짜 사이의 경과된 시간(일수)
--올해 1/1 부터 며칠 경과되었는지
--2020-04-17 - 2020-01-01 => 숫자
select '2020-04-17' - '2020-01-01' from dual; --error

select to_date('2020-04-17') - to_date('2020-01-01') from dual;
--to_date(문자) => 문자를 날짜형태로 변환해주는 함수

--어제부터 오늘까지 경과된 일수, 오늘부터 내일까지 남은 일수
select to_date('2020-04-17') - to_date('2020-04-16') "어제부터",
    to_date('2020-04-18') - to_date('2020-04-17') "내일까지"
from dual;

select sysdate, sysdate - to_date('2020-04-16') "어제부터",
    to_date('2020-04-18') - sysdate "내일까지"
from dual; -- 현재일자는 시간이 포함되서 결과가 예상과 다름

--시간을 제외한 두 날짜 사이의 일수를 구하는 경우
select sysdate, trunc(sysdate),
    to_date('2020-04-18') - trunc(sysdate) "내일까지"
from dual; -- 현재일자는 시간이 포함
-- trunc(날짜) : 해당 날짜를 리턴함(시간 빼고)
-- round(날짜) : 해당 날짜를 반올림해서 리턴(정오 기준)

--두 날짜 사이의 개월 수
--months_between() - 두 날짜 사이의 개월수를 구해줌
select months_between('2020-04-17', '2020-02-17'),
    months_between('2020-04-17', '2020-02-01'),
    months_between('2020-04-17', '2020-02-23')
from dual;

--next_day()
/*
주어진 날짜를 기준으로 돌아오는 가장 최근 요일의 날짜를 반환해 주는 함수
요일명 대신 숫자를 입력할 수도 있다.
1:일 2:월 ... 7:토
*/
select sysdate, next_day(sysdate,'월'),
    next_day(sysdate,'화요일'),
    next_day(sysdate,1),
    next_day('2020-05-01',4)
from dual;

--last_day()
--주어진 날짜가 속한 달의 가장 마지막 날을 출력해주는 함수
select sysdate, last_day(sysdate), last_day('2020-02-10'),
    last_day('2020-08-05'), last_day('2019-02-03')
from dual;

-- trunc(날짜) : 해당 날짜를 리턴함(시간 빼고)
-- round(날짜) : 해당 날짜를 반올림해서 리턴(정오 기준)
-- => 둘다 시간은 제외됨
select sysdate, round(sysdate), trunc(sysdate) from dual;

--사원의 입사일 50일 후의 날짜 구하기
select FIRST_NAME, LAST_NAME, HIRE_DATE, HIRE_DATE+50 "50일 후" 
from employees; 

--입사일 3개월 후의 날짜 구하기
select FIRST_NAME, LAST_NAME, HIRE_DATE, add_months(HIRE_DATE,3) "3개월 후" 
from employees; 

--수료일까지 남은 일수
select to_date('2020-08-19') - trunc(sysdate) || '일' "수료일까지" from dual;

--수료일까지 남은 개월수
select months_between(last_day('2020-08-19'), 
    last_day(sysdate)) || '개월' "수료일까지" 
from dual;

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
select 1+'2', 2+'003' from dual;
-- =>숫자 형태의 문자를 연산하면 해당 문자를 숫자로 자동형변환한 후 연산함

select '004',1+to_number('2'), 2+to_number('003') from dual;

--(1-1) to_char(날짜, 패턴) - 날짜를 문자로 변환한다
select sysdate, to_char(sysdate, 'yyyy'), to_char(sysdate,'mm'),
    to_char(sysdate, 'dd'), to_char(sysdate, 'd') 요일
from dual;

select sysdate, to_char(sysdate, 'year'), to_char(sysdate,'mon'),
    to_char(sysdate,'month'), to_char(sysdate, 'day'), -- 요일(월요일,화요일,...)
    to_char(sysdate, 'dy'), -- 요일(월, 화,...)
    to_char(sysdate, 'q'), -- 분기
    to_char(sysdate, 'ddd') -- 1년 중 며칠째인지
from dual;

select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss am'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss pm day')
from dual;

--특정 날짜에서 년도만 추출, 월만 추출, 일만 추출
select extract(year from sysdate) 년도,
    extract(month from sysdate) 월,
    extract(day from sysdate) 일
from dual;

--실습) STUDENT 테이블의 birthday 칼럼을 참조하여 생일 이 3월인 학생의 이름과 birthday를 출력 
select name, birthday from student where extract(month from birthday)=3;

select name, birthday from student where to_char(birthday, 'mm') = 3;

--(1-2) to_char(숫자, 패턴) - 숫자를 패턴이 적용된 문자로 변환
/*
9 : 남은자리를 공백으로 채움
0 : 남은자리를 0으로 채움
*/

select 1234, to_char(1234, '99999'), to_char(1234,'099999'),
    to_char(1234, '$99999'), to_char(1234, 'L99999'),
    to_char(1234.56, '9999.9'), to_char(1234, '$99,999'),
    to_char(123456789, '999,999,999'),
    to_char(1234.56, '9999')
from dual;

--Professor 테이블을 참조하여 101번 학과 교수들 의 이름과 연봉을 출력하시오. 
--단 연봉은 (pay*12)+bonus 로 계산하고 천 단위 구분기호로 표시하시오
select NAME 이름, to_char((pay*12)+bonus, '99,999')연봉 
from professor 
where DEPTNO=101;

--(2) to_date(문자, 패턴) - 문자를 날짜로 변환
select to_date('2020-05-09'), to_date('2020-05-09', 'yyyy-mm-dd')
    , to_date('2020/05/09', 'yyyy/mm/dd')
    , to_date('2020-05-09 16:20:35', 'yyyy-mm-dd hh24:mi:ss')
from dual;

select * from professor where hiredate >= '1995-01-01';
select '2020-04-03' - '2020-01-01' from dual; --error
select to_date('2020-04-03') - to_date('2020-01-01') from dual; 

--2020-03-07 ~ 2020-04-16까지의 데이터 조회
select * from pd 
where regdate 
    between '2020-03-07' 
    and 
    to_date('2020-04-16 23:59:59','yyyy-mm-dd hh24:mi:ss');
    
--등록한지 몇 시간이 지났는지 조회
select PDNAME, PRICE, REGDATE, (sysdate - regdate)*24 경과시간 from pd;

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