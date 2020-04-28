/* Formatted on 2020/04/28 ���� 6:27:38 (QP5 v5.360) */
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