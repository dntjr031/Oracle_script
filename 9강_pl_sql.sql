/* Formatted on 2020/04/29 ���� 5:32:54 (QP5 v5.360) */
--9��_pl_sql.sql
--[2020-04-28 ȭ����]
--PL/SQL

/*
    - Procedural language extension to Structured Query Language
    - SQL�� �Ϲ� ���α׷��� ����� Ư���� ������ ���
    - ����, ��� ���� ����
    - ���ǹ�, �ݺ��� ��� ����
*/

/*
    �����
        - declare Ű���� ���
        - ������ ����� �����ϴ� �κ�
        
    �����
        - begin ~ end Ű���� ���
        - ������ �� �Ҵ�, ���ǹ�, �ݺ���, sql������� ó��
        - �����ؾ� �� ������ �ִ� �κ�
        
    ����ó����
        - exception Ű���� ���
        - ����ο��� ���ܰ� �߻����� �� ó���ϴ� �κ�
*/

--�����, �����, ����ó���ΰ� �ϳ��� PL/SQL ����� �����ϰ�, ����Ŭ�� �� �ҷ� ������ ó����

DECLARE
    --����� : ������ �����ϴ� �κ�
    counter   NUMBER;
BEGIN
    --����� : ó���� ������ �ִ� �κ�
    --������ �� �Ҵ�
    counter := 1;

    --����ó��
    counter := counter / 0;

    IF counter IS NOT NULL
    THEN
        DBMS_OUTPUT.put_line ('counter=>' || counter);
    END IF;
EXCEPTION
    WHEN OTHERS
    THEN
        --���� ó����
        DBMS_OUTPUT.put_line ('0���� ������ �ȵ˴ϴ�.');
END;

--1~10���� for�� �̿��Ͽ� �ݺ�ó��

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

--1~10���� while�� �̿��Ͽ� �ݺ�ó��

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

--[2020-04-29 ������]
--����, ��� ����
/*
    ������ ������Ÿ��;          --���� ����
    ������ constant ������Ÿ��; --��� ����
    ������ ���̺��.�÷���%type;  --���� ����
         => �ش� ���̺��� �ش� �÷��� ������ Ÿ���� ���� ����
         
    ��)  name    varchar2(30);
        curYear constant number := 2020;
        empno   employees.employee_id%type;
*/

SELECT * FROM employees;

--���ǹ�

/*
    1) if��
        if ����1 then
             ����1;
        elsif ����2 then
               ����2;
        else 
            ����2;
        end if;
        
        2)case��
            case ...
                when ����1 then ����1
                when ����2 then ����2
                else ����3
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

--case ��

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

--�ݺ���
/*
    1) (Ż������ ���- exit when ����)
        loop
            exit when ����;
        end loop;
        
    2) (reverse�� ������ ���ᰪ���� �ʱⰪ���� ������ �ٲ�)
        for ���� in [reverse] �ʱⰪ..���ᰪ loop
            ó���� ����;
        end loop;
    
    3) (������ �ʱ�ȭ �� ���)
        while ���� loop
            ó���� ����
        ent loop;
    
*/

--loop �� �̿�

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

--for��

DECLARE
    i        NUMBER;
    result   NUMBER;
BEGIN
    FOR i IN 1 .. 10
    LOOP
        result := i * 5;
        DBMS_OUTPUT.put_line ('i:' || i || ', result:' || result);
    END LOOP;

    DBMS_OUTPUT.put_line ('---for�� reverse�̿�---');

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

--while �̿�

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

--PL/SQL ���� ���α׷�
/*
    - �����ͺ��̽� ��ü�� �����ؼ� �ʿ��� ������ ȣ���Ͽ� ����� �� �ִ� PL/SQL���
    
    1) �Լ�(function)
        - ������� ��ȯ��
        - ����� ���� �Լ��� ����
        - Ư�� ����� ������ ��, ������� ��ȯ�ϴ� ���� ���α׷�
        
    2) ���� ���ν���(���� ���ν���, stored procedure)
        - ������� ��ȯ���� ����(void)
        
*/

--�Լ�
/*
    create or replace function �Լ���
        (�Ķ����1 ������Ÿ��,
         �Ķ����2 ������Ÿ��, ...)
            return ������Ÿ��
    is �Ǵ� as
        ���� ����
    begin
        ó���� ����
        
        exception when others then
            ����ó���� ����
    end;
*/
--�ֹι�ȣ�� ������ ������ �����ϴ� �Լ� �����

CREATE OR REPLACE FUNCTION get_gender (                                 --�Ķ����
                                       p_ssn VARCHAR2)
    RETURN VARCHAR2
--��ȯŸ��
IS
    --��������
    v_gender   VARCHAR2 (10);
BEGIN
    --ó���� ����
    SELECT CASE
               WHEN SUBSTR (p_ssn, 7, 1) IN (1, 3) THEN '����'
               ELSE '����'
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

SELECT gno, gname, jumin, get_gender (jumin) ���� FROM gogak;

SELECT gno, gname, jumin, LENGTH (gname) �̸����� FROM gogak;

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

SELECT gno, gname, jumin, get_age (jumin) ���� FROM gogak;

-- stored procedure(���� ���ν���, ���� ���ν���)
-- Ư�� ����� ���������� ���� ��ȯ������ �ʴ� ���� ���α׷�

/*
    create or replace procedure ���ν�����
    (
        �Ķ����1   ������Ÿ��,
        �Ķ����2   ������Ÿ��,
        ...
    )
    is[as]
        ���������
    begin
        ó���� ����
        
    exception when others then
        ����ó�� ����
    end;
*/

SELECT * FROM pd2;

SELECT * FROM user_sequences;

--pd2 ���̺� �Է��ϴ� ���ν���

CREATE OR REPLACE PROCEDURE pd2_insert (                                --�Ķ����
                                        --pd2 ���̺� insert�Ҷ� �ʿ��� �Ķ���͵�
                                        p_pdcode    CHAR,
                                        p_pdname    VARCHAR2,
                                        p_price     NUMBER,
                                        p_company   VARCHAR2)
IS
--���� �����
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

    COMMIT;                                                          --�����ϸ� Ŀ��
EXCEPTION
    WHEN OTHERS
    THEN
        DBMS_OUTPUT.put_line ('pd2 insert error!');
        ROLLBACK;                                                    --�����ϸ� �ѹ�
END;

--���� ���ν��� �����Ű��
/*
    execute ���ν����̸�(�Ķ����);
    �Ǵ�
    exec ���ν����̸�(�Ķ����);
*/

EXECUTE pd2_insert('C01','���콺',34000,'�Ｚ');

SELECT * FROM pd2;

EXEC pd2_insert('C02','�����',470000,'LG');

--pd2 ���̺� �÷��� �����ϴ� ���ν��� �����

CREATE OR REPLACE PROCEDURE pd2_update (p_no        pd2.no%TYPE,
                                        p_pdcode    pd2.pdcode%TYPE,
                                        p_pdname    pd2.pdname%TYPE,
                                        p_price     pd2.price%TYPE,
                                        p_company   pd2.company%TYPE)
--                                                  ���̺��,�÷���%type
--                                              => �ش����̺��� �ش� �÷��� ������ ������ Ÿ��
IS
    v_cnt   NUMBER (3);
BEGIN
    SELECT COUNT (*)
      INTO v_cnt
      FROM pd2
     WHERE no = p_no;

    --�ش� �����Ͱ� �����ϸ� update
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

EXEC pd2_update(4,'B03','��ǻ��',1800000,'HP');

  SELECT *
    FROM pd2
ORDER BY no DESC;

--���� ���ν���, �Լ� Ȯ��

SELECT *
  FROM user_source
 WHERE name = 'PD2_UPDATE';

-- exists �̿��� update

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
        --                              ����� ���� ���ܹ�ȣ�� -20001 ~ -20999 ����
        ROLLBACK;
END;

EXEC pd2_update2(4,'B04','Ű����',-50,'qnix');
--error, ORA-20001: pd2 update error!
--       ORA-06512: at "HR.PD2_UPDATE2", line 22
--       ORA-06512: at line 1

EXEC pd2_update2(4,'B05','Ű����',19000,'qnix');

  SELECT *
    FROM pd2
ORDER BY no DESC;



--%rowtype

/*
    - %type�� �����ϳ�, �� �� �̻��� ���� ���� ����
    - �ο�Ÿ�� ������ ������ ���̺� �ִ� row(���ڵ�) ���� ����
*/

CREATE OR REPLACE PROCEDURE prof_info (p_profno PROFESSOR.PROFNO%TYPE)
IS
    v_prof_row   professor%ROWTYPE;
    --                  professor���̺��� �� ���� ���ڵ� ������ ���� �� �ִ� Ÿ��
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
        raise_application_error (-20002, 'professor ��ȸ ����!');
END;

EXEC prof_info(1001);

SELECT * FROM professor;



--����� ���� ����

SELECT * FROM MEMBER;

SELECT * FROM user_sequences;

CREATE SEQUENCE member_seq INCREMENT BY 1 START WITH 1005;

CREATE OR REPLACE PROCEDURE member_insert (p_name     MEMBER.name%TYPE,
                                           p_junin    MEMBER.jumin%TYPE,
                                           p_passwd   MEMBER.passwd%TYPE,
                                           p_id       MEMBER.id%TYPE)
IS
    system_check_insert_fail   EXCEPTION;
--����� ���� ����
BEGIN
    --�Ͽ��� 23:00:00 ~ 23:59:59 ���̿��� �ý��� �۾����� ���� �Է� �Ұ�
    IF TO_CHAR (SYSDATE, 'd') = '1' AND TO_CHAR (SYSDATE, 'hh24') = '23'
    THEN
        RAISE system_check_insert_fail;
    --����� ���� ���� �߻���Ű��
    END IF;

    --�Ͽ��� 23�ö��� �ƴϸ� �Է°���
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
            '�Ͽ��� 23:00:00 ~ 23:59:59 ���̿��� �ý��� �۾����� ���� �Է� �Ұ�');
        ROLLBACK;
END;

EXEC member_insert('��浿2','9905091112282','1234','kim2');

SELECT * FROM MEMBER;

/*
    out �Ű�����(�Ķ����)
    - ����� ����ϴ� �뵵�� �Ű�����
    
    in �Ű����� 
    - �Ϲ����� �Ű�����, �Է¿� �Ű�����
    - �����ϸ� in �Ű�����
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
        raise_application_error (-20003, 'professor��ȸ ����!');
END;

--out �Ű������� �ִ� ���ν��� �����ϱ�

DECLARE
    v_name   professor.name%TYPE;
    v_pay    professor.name%TYPE;
BEGIN
    proc_prof (1003, v_name, v_pay);

    DBMS_OUTPUT.put_line ('�̸�:' || v_name || ', �޿�:' || v_pay);
END;



--PL/SQL Ŀ��

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
    Ŀ��
    - ������ ���� ��ȯ�Ǵ� ����� �޸� �� ��ġ�ϰ� �Ǵµ�
      PL/SQL ������ Ŀ���� ����Ͽ� �� ������տ� ������ �� �ִ�.
    - Ŀ���� ����ϸ� ��������� �� ���� �����Ϳ� ������ �����ϴ�.
    
    �� ����� Ŀ��
    - ����ڰ� ���� ������ ����� �����ؼ� �̸� ����ϱ� ���� ��������� ������ Ŀ��
    
    - ����� Ŀ���� ����ϱ� ���� ����
        [1] Ŀ�� ���� - ��������
        cursor Ŀ���� is select ����;
        
        [2] Ŀ�� ����(open) - ���� ����
        open Ŀ����;
        
        [3] ��ġ(fetch) - ������ ����� ����, ������ ���� ���� ���鿡 ����
        fetch Ŀ���� is ����...;
        
        [4] Ŀ�� �ݱ�(close) - �޸𸮻� �����ϴ� ������ ����� �Ҹ��Ŵ
        close Ŀ����;
*/

CREATE OR REPLACE PROCEDURE pd2_select2
IS
    --[1] Ŀ������
    CURSOR pd2_csr IS SELECT no, pdcode, pdname, price FROM pd2;

    --��������
    pd2_rcd   pd2%ROWTYPE;
BEGIN
    --[2] Ŀ�� ����
    OPEN pd2_csr;

    --[3] ��ġ(fetch)
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

    --[4] Ŀ���ݱ�
    CLOSE pd2_csr;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-2003, 'pd2 ��ȸ ����!');
END;

/*
    %notfound
    - Ŀ�������� ��� ������ �Ӽ�
    - ���̻� ��ġ(�Ҵ�)�� �ο찡 ������ �ǹ�
    - ������ ������ ������� ��ġ�� �Ŀ� �ڵ����� ������ ���������� ��
*/

/*
    for loop cursor��
    - Ŀ���� for loop���� ����ϸ� Ŀ���� open, fetch, close�� �ڵ�������
      �߻��Ǿ����� ������ open, fetch, close���� ����� �ʿ䰡 ����
      
    �� ����
    for ������ in Ŀ���� loop
        ���๮��
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
    - ���� ���ν����� select ������� java���� �б� ���ؼ���
      �̸� ����ؾ���
*/

CREATE OR REPLACE PROCEDURE pd2_select4 (pd2_cursor OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN pd2_cursor FOR
        SELECT no, pdcode, pdname, price, company, regdate FROM pd2;
EXCEPTION
    WHEN OTHERS
    THEN
        raise_application_error (-20004, 'pd2���̺� ��ȸ �� ����!');
END;