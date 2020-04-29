/* Formatted on 2020/04/29 오후 5:32:54 (QP5 v5.360) */
--9강_pl_sql.sql
--[2020-04-28 화요일]
--PL/SQL

/*
    - Procedural language extension to Structured Query Language
    - SQL과 일반 프로그래밍 언어의 특성을 결헙한 언어
    - 변수, 상수 선언 가능
    - 조건문, 반복문 사용 가능
*/

/*
    선언부
        - declare 키워드 사용
        - 변수나 상수를 선언하는 부분
        
    실행부
        - begin ~ end 키워드 사용
        - 변수에 값 할당, 조건문, 반복문, sql문장등을 처리
        - 실행해야 할 로직을 넣는 부분
        
    예외처리부
        - exception 키워드 사용
        - 실행부에서 예외가 발생했을 때 처리하는 부분
*/

--선언부, 실행부, 예외처리부가 하나의 PL/SQL 블록을 구성하고, 오라클은 이 불록 단위로 처리함

DECLARE
    --선언부 : 변수를 선언하는 부분
    counter   NUMBER;
BEGIN
    --실행부 : 처리할 로직을 넣는 부분
    --변수에 값 할당
    counter := 1;

    --로직처리
    counter := counter / 0;

    IF counter IS NOT NULL
    THEN
        DBMS_OUTPUT.put_line ('counter=>' || counter);
    END IF;
EXCEPTION
    WHEN OTHERS
    THEN
        --예외 처리부
        DBMS_OUTPUT.put_line ('0으로 나누면 안됩니다.');
END;

--1~10까지 for문 이용하여 반복처리

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    FOR i IN 1 .. 10
    LOOP
        result := i * 2;
        DBMS_OUTPUT.put_line (result);
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--1~10까지 while문 이용하여 반복처리

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    i := 1;

    WHILE i <= 10
    LOOP
        result := i * 3;
        DBMS_OUTPUT.put_line (i || '*3 => ' || result);
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--[2020-04-29 수요일]
--변수, 상수 선언
/*
    변수명 데이터타입;          --변수 선언
    변수명 constant 데이터타입; --상수 선언
    변수명 테이블명.컬럼명%type;  --변수 선언
         => 해당 테이블의 해당 컬럼과 동일한 타입의 변수 선언
         
    예)  name    varchar2(30);
        curYear constant number := 2020;
        empno   employees.employee_id%type;
*/

SELECT * FROM employees;

--조건문

/*
    1) if문
        if 조건1 then
             문장1;
        elsif 조건2 then
               문장2;
        else 
            문장2;
        end if;
        
        2)case문
            case ...
                when 조건1 then 문장1
                when 조건2 then 문장2
                else 문장3
            end case;
*/

DECLARE
    grade    CHAR;
    result   VARCHAR2 (30);
BEGIN
    grade := 'B';

    IF grade = 'A'
    THEN
        result := 'Excellent';
    ELSIF grade = 'B'
    THEN
        result := 'Good';
    ELSIF grade = 'C'
    THEN
        result := 'Fair';
    ELSIF grade = 'D'
    THEN
        result := 'Poor';
    ELSE
        result := 'Not found!';
    END IF;

    DBMS_OUTPUT.put_line (grade || ' => ' || result);
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error');
END;

--case 문

DECLARE
    grade    CHAR;
    result   VARCHAR2 (50);
BEGIN
    grade := 'C';

    CASE grade
        WHEN 'A'
        THEN
            result := 'Excellent';
        WHEN 'B'
        THEN
            result := 'Good';
        WHEN 'C'
        THEN
            result := 'fail';
        WHEN 'D'
        THEN
            result := 'poor';
        ELSE
            result := 'not found';
    END CASE;

    DBMS_OUTPUT.put_line (grade || ' => ' || result);
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--반복문
/*
    1) (탈출조건 사용- exit when 조건)
        loop
            exit when 조건;
        end loop;
        
    2) (reverse를 넣으면 종료값에서 초기값으로 방향이 바뀜)
        for 변수 in [reverse] 초기값..종료값 loop
            처리할 문장;
        end loop;
    
    3) (변수를 초기화 후 사용)
        while 조건 loop
            처리할 문장
        ent loop;
    
*/

--loop 문 이용

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    i := 1;

    LOOP
        result := i * 2;

        EXIT WHEN result > 20;
        DBMS_OUTPUT.put_line (result);
        i := i + 1;
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--for문

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    FOR i IN 1 .. 10
    LOOP
        result := i * 5;
        DBMS_OUTPUT.put_line ('i:' || i || ', result:' || result);
    END LOOP;

    DBMS_OUTPUT.put_line ('---for문 reverse이용---');

    FOR i IN REVERSE 1 .. 10
    LOOP
        result := i * 4;
        DBMS_OUTPUT.put_line ('i:' || i || ', result:' || result);
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--while 이용

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    i := 1;
    result := 0;

    WHILE result < 20
    LOOP
        result := i * 2;
        DBMS_OUTPUT.put_line (result);
        i := i + 1;
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error!');
END;

--PL/SQL 서브 프로그램
/*
    - 데이터베이스 객체로 저장해서 필요할 때마다 호출하여 사용할 수 있는 PL/SQL블록
    
    1) 함수(function)
        - 결과값을 반환함
        - 사용자 정의 함수를 말함
        - 특정 기능을 수행한 뒤, 결과값을 반환하는 서브 프로그램
        
    2) 내장 프로시저(저장 프로시저, stored procedure)
        - 결과값을 반환하지 않음(void)
        
*/

--함수
/*
    create or replace function 함수명
        (파라미터1 데이터타입,
         파라미터2 데이터타입, ...)
            return 데이터타입
    is 또는 as
        변수 선언
    begin
        처리할 로직
        
        exception when others then
            예외처리할 문장
    end;
*/
--주민번호를 넣으면 성별을 리턴하는 함수 만들기

CREATE OR REPLACE FUNCTION get_gender (                                 --파라미터
                                       p_ssn VARCHAR2)
    RETURN VARCHAR2
--반환타입
IS
    --변수선언
    v_gender   VARCHAR2 (10);
BEGIN
    --처리할 로직
    SELECT CASE
               WHEN SUBSTR (p_ssn, 7, 1) IN (1, 3) THEN '남자'
               ELSE '여자'
           END
      INTO v_gender
      FROM DUAL;

    RETURN v_gender;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error');
END;

SELECT get_gender ('0110093122222') FROM DUAL;

SELECT LENGTH ('java') FROM DUAL;

SELECT gno, gname, jumin, get_gender (jumin) 성별 FROM gogak;

SELECT gno, gname, jumin, LENGTH (gname) 이름길이 FROM gogak;

--get_age

CREATE OR REPLACE FUNCTION get_age (jumin VARCHAR2)
    RETURN NUMBER
IS
    result   NUMBER;
BEGIN
    SELECT   EXTRACT (YEAR FROM SYSDATE)
           - (  SUBSTR (jumin, 1, 2)
              + CASE
                    WHEN SUBSTR (jumin, 7, 1) IN (1, 2) THEN 1900
                    ELSE 2000
                END)
           + 1
      INTO result
      FROM DUAL;

    RETURN result;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('error');
END;

SELECT gno, gname, jumin, get_age (jumin) 나이 FROM gogak;

-- stored procedure(저장 프로시저, 내장 프로시저)
-- 특정 기능을 수행하지만 값을 반환하지는 않는 서브 프로그램

/*
    create or replace procedure 프로시저명
    (
        파라미터1   데이터타입,
        파라미터2   데이터타입,
        ...
    )
    is[as]
        변수선언부
    begin
        처리할 로직
        
    exception when others then
        예외처리 문장
    end;
*/

SELECT * FROM pd2;

SELECT * FROM user_sequences;

--pd2 테이블에 입력하는 프로시저

CREATE OR REPLACE PROCEDURE pd2_insert (                                --파라미터
                                        --pd2 테이블에 insert할때 필요한 파라미터들
                                        p_pdcode    CHAR,
                                        p_pdname    VARCHAR2,
                                        p_price     NUMBER,
                                        p_company   VARCHAR2)
IS
--변수 선언부
BEGIN
    INSERT INTO pd2 (no,
                     pdcode,
                     pdname,
                     price,
                     company)
         VALUES (pd2_seq.NEXTVAL,
                 p_pdcode,
                 p_pdname,
                 p_price,
                 p_company);

    COMMIT;                                                          --성공하면 커밋
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('pd2 insert error!');
        ROLLBACK;                                                    --실패하면 롤백
END;

--저장 프로시저 실행시키기
/*
    execute 프로시저이름(파라미터);
    또는
    exec 프로시저이름(파라미터);
*/

EXECUTE pd2_insert('C01','마우스',34000,'삼성');

SELECT * FROM pd2;

EXEC pd2_insert('C02','모니터',470000,'LG');

--pd2 테이블 컬럼을 수정하는 프로시저 만들기

CREATE OR REPLACE PROCEDURE pd2_update (p_no        pd2.no%TYPE,
                                        p_pdcode    pd2.pdcode%TYPE,
                                        p_pdname    pd2.pdname%TYPE,
                                        p_price     pd2.price%TYPE,
                                        p_company   pd2.company%TYPE)
--                                                  테이블명,컬럼명%type
--                                              => 해당테이블의 해당 컬럼과 동일한 데이터 타입
IS
    v_cnt   NUMBER (3);
BEGIN
    SELECT COUNT (*)
      INTO v_cnt
      FROM pd2
     WHERE no = p_no;

    --해당 데이터가 존재하면 update
    IF v_cnt > 0
    THEN
        UPDATE pd2
           SET pdcode = p_pdcode,
               pdname = p_pdname,
               price = p_price,
               company = p_company
         WHERE no = p_no;
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('pd2 update error!');
        ROLLBACK;
END;

EXEC pd2_update(4,'B03','컴퓨터',1800000,'HP');

  SELECT *
    FROM pd2
ORDER BY no DESC;

--저장 프로시저, 함수 확인

SELECT *
  FROM user_source
 WHERE name = 'PD2_UPDATE';

-- exists 이용한 update

CREATE OR REPLACE PROCEDURE pd2_update2 (p_no        pd2.no%TYPE,
                                         p_pdcode    pd2.pdcode%TYPE,
                                         p_pdname    pd2.pdname%TYPE,
                                         p_price     pd2.price%TYPE,
                                         p_company   pd2.company%TYPE)
IS
BEGIN
    UPDATE pd2 a
       SET pdcode = p_pdcode,
           pdname = p_pdname,
           price = p_price,
           company = p_company
     WHERE EXISTS
               (SELECT 1
                  FROM pd2 b
                 WHERE a.NO = b.no AND b.no = p_no);

    COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20001, 'pd2 update error!');
        --                              사용자 정의 예외번호는 -20001 ~ -20999 까지
        ROLLBACK;
END;

EXEC pd2_update2(4,'B04','키보드',-50,'qnix');
--error, ORA-20001: pd2 update error!
--       ORA-06512: at "HR.PD2_UPDATE2", line 22
--       ORA-06512: at line 1

EXEC pd2_update2(4,'B05','키보드',19000,'qnix');

  SELECT *
    FROM pd2
ORDER BY no DESC;



--%rowtype

/*
    - %type과 유사하나, 한 개 이상의 값에 대해 적용
    - 로우타입 변수를 선언해 테이블에 있는 row(레코드) 대입 가능
*/

CREATE OR REPLACE PROCEDURE prof_info (p_profno PROFESSOR.PROFNO%TYPE)
IS
    v_prof_row   professor%ROWTYPE;
    --                  professor테이블의 한 개의 레코드 정보를 담을 수 있는 타입
    v_result     VARCHAR2 (2000);
BEGIN
    SELECT *
      INTO v_prof_row
      FROM professor
     WHERE profno = p_profno;

    v_result :=
           v_prof_row.profno
        || ' '
        || v_prof_row.name
        || ' '
        || v_prof_row.position
        || ' '
        || (v_prof_row.pay + NVL (v_prof_row.bonus, 0));

    DBMS_OUTPUT.put_line (v_result);
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20002, 'professor 조회 에러!');
END;

EXEC prof_info(1001);

SELECT * FROM professor;



--사용자 정의 예외

SELECT * FROM MEMBER;

SELECT * FROM user_sequences;

CREATE SEQUENCE member_seq INCREMENT BY 1 START WITH 1005;

CREATE OR REPLACE PROCEDURE member_insert (p_name     MEMBER.name%TYPE,
                                           p_junin    MEMBER.jumin%TYPE,
                                           p_passwd   MEMBER.passwd%TYPE,
                                           p_id       MEMBER.id%TYPE)
IS
    system_check_insert_fail   EXCEPTION;
--사용자 정의 예외
BEGIN
    --일요일 23:00:00 ~ 23:59:59 사이에는 시스템 작업으로 인해 입력 불가
    IF TO_CHAR (SYSDATE, 'd') = '1' AND TO_CHAR (SYSDATE, 'hh24') = '23'
    THEN
        RAISE system_check_insert_fail;
    --사용자 정의 예외 발생시키기
    END IF;

    --일요일 23시때가 아니면 입력가능
    INSERT INTO MEMBER (no,
                        name,
                        jumin,
                        passwd,
                        id)
         VALUES (member_seq.NEXTVAL,
                 p_name,
                 p_junin,
                 p_passwd,
                 p_id);

    COMMIT;
EXCEPTION
    WHEN system_check_insert_fail
    THEN
        raise_application_error (
            -20003,
            '일요일 23:00:00 ~ 23:59:59 사이에는 시스템 작업으로 인해 입력 불가');
        ROLLBACK;
END;

EXEC member_insert('김길동2','9905091112282','1234','kim2');

SELECT * FROM MEMBER;

/*
    out 매개변수(파라미터)
    - 결과를 출력하는 용도의 매개변수
    
    in 매개변수 
    - 일반적인 매개변수, 입력용 매개변수
    - 생략하면 in 매개변수
*/

SELECT * FROM professor;

CREATE OR REPLACE PROCEDURE proc_prof (
    p_profno   IN     professor.profno%TYPE,
    o_name        OUT professor.name%TYPE,
    o_pay         OUT professor.pay%TYPE)
IS
BEGIN
    SELECT name, pay
      INTO o_name, o_pay
      FROM professor
     WHERE profno = p_profno;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20003, 'professor조회 에러!');
END;

--out 매개변수가 있는 프로시저 실행하기

DECLARE
    v_name   professor.name%TYPE;
    v_pay    professor.name%TYPE;
BEGIN
    proc_prof (1003, v_name, v_pay);

    DBMS_OUTPUT.put_line ('이름:' || v_name || ', 급여:' || v_pay);
END;



--PL/SQL 커서

CREATE OR REPLACE PROCEDURE pd2_select
IS
BEGIN
    SELECT * FROM pd2;
-- arror, an INTO clause is expected in this SELECT statement
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20003, 'pd2 select error!');
END;

/*
    커서
    - 쿼리에 의해 반환되는 결과는 메모리 상에 위치하게 되는데
      PL/SQL 에서는 커서를 사용하여 이 결과집합에 접근할 수 있다.
    - 커서를 사용하면 결과집합의 각 개별 데이터에 접근이 가능하다.
    
    ※ 명시적 커서
    - 사용자가 직접 쿼리의 결과에 접근해서 이를 사용하기 위해 명시적으로 선언한 커서
    
    - 명시적 커서를 사용하기 위한 절차
        [1] 커서 선언 - 쿼리정의
        cursor 커서명 is select 문장;
        
        [2] 커서 열기(open) - 쿼리 실행
        open 커서명;
        
        [3] 패치(fetch) - 쿼리의 결과에 접근, 루프를 돌며 개별 값들에 접근
        fetch 커서명 is 변수...;
        
        [4] 커서 닫기(close) - 메모리상에 존재하는 쿼리의 결과를 소멸시킴
        close 커서명;
*/

CREATE OR REPLACE PROCEDURE pd2_select2
IS
    --[1] 커서선언
    CURSOR pd2_csr IS SELECT no, pdcode, pdname, price FROM pd2;

    --변수선언
    pd2_rcd   pd2%ROWTYPE;
BEGIN
    --[2] 커서 열기
    OPEN pd2_csr;

    --[3] 패치(fetch)
    LOOP
        FETCH pd2_csr
            INTO pd2_rcd.no,
                 pd2_rcd.pdcode,
                 pd2_rcd.pdname,
                 pd2_rcd.price;

        EXIT WHEN pd2_csr%NOTFOUND;


        DBMS_OUTPUT.put_line (
               pd2_rcd.no
            || ' '
            || pd2_rcd.pdcode
            || ' '
            || pd2_rcd.pdname
            || ' '
            || pd2_rcd.price);
    END LOOP;

    --[4] 커서닫기
    CLOSE pd2_csr;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-2003, 'pd2 조회 에러!');
END;

/*
    %notfound
    - 커서에서만 사용 가능한 속성
    - 더이상 패치(할당)할 로우가 없음을 의미
    - 쿼리의 마지막 결과까지 패치한 후에 자동으로 루프를 빠져나가게 됨
*/

/*
    for loop cursor문
    - 커서의 for loop문을 사용하면 커서의 open, fetch, close가 자동적으로
      발생되어지기 때문에 open, fetch, close문을 기술할 필요가 없다
      
    ※ 형식
    for 변수명 in 커서명 loop
        실행문장
    end loop;
*/

CREATE OR REPLACE PROCEDURE pd2_select3
IS
    CURSOR pd2_csr IS SELECT no, pdcode, pdname, price FROM pd2;
BEGIN
    FOR pd2_row IN pd2_csr
    LOOP
        DBMS_OUTPUT.put_line (
               pd2_row.no
            || ' '
            || pd2_row.pdcode
            || ' '
            || pd2_row.pdname
            || ' '
            || pd2_row.price);
    END LOOP;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20007, 'pd2 select error!');
END;

EXEC pd2_select3;

/*
    sys_refcursor
    - 저장 프로시저의 select 결과물을 java에서 읽기 위해서는
      이를 사용해야함
*/

CREATE OR REPLACE PROCEDURE pd2_select4 (pd2_cursor OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN pd2_cursor FOR
        SELECT no, pdcode, pdname, price, company, regdate FROM pd2;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20004, 'pd2테이블 조회 중 에러!');
END;