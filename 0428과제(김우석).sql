/* Formatted on 2020/04/28 ���� 7:31:30 (QP5 v5.360) */
-- 1) panmae, product �̿�,

SELECT p.P_DATE,
       p.P_CODE,
       b.P_NAME,
       b.P_PRICE,
       p.P_QTY,
       b.P_PRICE * p.p_qty     total
  FROM panmae p JOIN product b ON p.P_CODE = b.P_CODE;

-- 2) �Խ���(board), ���� �亯(comments) ���̺� �����

DROP TABLE board CASCADE CONSTRAINT;

CREATE TABLE board
(
    no           NUMBER PRIMARY KEY,
    title        VARCHAR2 (50) NOT NULL,
    user_id      VARCHAR2 (30) NOT NULL,
    user_pw      VARCHAR2 (30) NOT NULL,
    main_text    CLOB,
    regdate      DATE DEFAULT SYSDATE,
    c_num        NUMBER DEFAULT 0
);

DROP TABLE comments;

CREATE TABLE comments
(
    no          NUMBER PRIMARY KEY,
    user_id     VARCHAR2 (30) UNIQUE NOT NULL,
    user_pwd    VARCHAR2 (30) NOT NULL,
    comments    VARCHAR2 (1000) NOT NULL,
    board_no    NUMBER
                   CONSTRAINT fk_comments_board_no
                       REFERENCES board (no) ON DELETE CASCADE,
    regdate     DATE DEFAULT SYSDATE,
    c_num       NUMBER DEFAULT 0
);

CREATE SEQUENCE seq_board INCREMENT BY 1 START WITH 1 NOCACHE;

CREATE SEQUENCE seq_comments INCREMENT BY 1 START WITH 1 NOCACHE;

-- 3) �Խ��ǰ� ���� �亯 ���̺��� �̿��Ͽ� �Խ��ǹ�ȣ, �ۼ���, ����, ����, ���ٴ亯 ��ȣ, 
--    �ۼ���, �� ��, �ۼ����� ��ȸ(����) ���� �� �����

CREATE OR REPLACE VIEW v_board_comments
AS
    SELECT b.NO          board_no,
           b.USER_ID     board_USER_ID,
           b.TITLE,
           b.MAIN_TEXT,
           c.NO          comments_no,
           c.USER_ID     comments_USER_ID,
           c.COMMENTS,
           c.REGDATE
      FROM board b JOIN comments c ON b.NO = c.BOARD_NO;

-- 1. �Խ��ǿ� �۾��� - insert ? 

INSERT INTO board
     VALUES (seq_board.NEXTVAL,
             'java�� ����',
             'hong',
             'h123',
             'java��...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (seq_board.NEXTVAL,
             'oracle�� ����',
             'kim',
             'k123',
             'oracle��...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (3,
             'html�� ����',
             'hong',
             'h123',
             'html�̶�...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (4,
             'mysql�� ����',
             'kim2',
             'k123',
             'mysql�̶�...',
             SYSDATE,
             0);

--2. �Խ����� 1�� �ۿ� ���� ���� �亯 2�� ���� ?

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'lee',
             'l123',
             '���� ���� ����',
             1,
             SYSDATE,
             0);

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'park',
             'p123',
             '���� ��Ź�����',
             2,
             SYSDATE,
             0);
             
INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'lee',
             'l123',
             '���� ���� ����',
             2,
             SYSDATE,
             0);

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'park',
             'p123',
             '���� ��Ź�����',
             1,
             SYSDATE,
             0);


-- 3. ���� �亯 1�� ���� - delete ? 

DELETE FROM comments
      WHERE no = 2;

--4. �Խ����� �� ���� - update ? 

UPDATE board
   SET main_text = 'java�� ���α׷��� ���ν�...'
 WHERE no = 1;

--5. �Խ����� �� ���� ? ���� �亯�� ���� �����ǵ��� ? 

DELETE FROM board
      WHERE no = 1;

--6. �Խ��� ��� - select ? ��ȣ ������������ ��ü ��ȸ ? 

  SELECT *
    FROM board
ORDER BY no;

--7. �Խ��� ��Ͽ��� ������ �� ���� ? 
--������ �۸� ��ȸ - select ? 
--������ ���� ��ȸ�� ���� - update ? 
--������ ���� ���� �亯 ��� ��ȸ - select ? 

SELECT main_text
  FROM board
 WHERE no = 2;

UPDATE board
   SET c_num = c_num + 1
 WHERE no = 2;
 
select * from v_board_comments
where BOARD_NO=2;

--8. ����, ����, �ۼ��ڷ� �˻� - select
select * from board
where title like '%%' and main_text like '%%' and user_id like '%%';