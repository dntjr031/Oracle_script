/* Formatted on 2020/04/28 오후 6:27:38 (QP5 v5.360) */
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