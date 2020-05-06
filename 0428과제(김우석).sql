/* Formatted on 2020/04/28 오후 7:31:30 (QP5 v5.360) */
-- 1) panmae, product 이용,

SELECT p.P_DATE,
       p.P_CODE,
       b.P_NAME,
       b.P_PRICE,
       p.P_QTY,
       b.P_PRICE * p.p_qty     total
  FROM panmae p JOIN product b ON p.P_CODE = b.P_CODE;

-- 2) 게시판(board), 한줄 답변(comments) 테이블 만들기

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

-- 3) 게시판과 한줄 답변 테이블을 이용하여 게시판번호, 작성자, 제목, 내용, 한줄답변 번호, 
--    작성자, 내 용, 작성일을 조회(조인) 각각 뷰 만들기

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

-- 1. 게시판에 글쓰기 - insert ? 

INSERT INTO board
     VALUES (seq_board.NEXTVAL,
             'java에 대해',
             'hong',
             'h123',
             'java란...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (seq_board.NEXTVAL,
             'oracle에 대해',
             'kim',
             'k123',
             'oracle란...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (3,
             'html에 대해',
             'hong',
             'h123',
             'html이란...',
             SYSDATE,
             0);

INSERT INTO board
     VALUES (4,
             'mysql에 대해',
             'kim2',
             'k123',
             'mysql이란...',
             SYSDATE,
             0);

--2. 게시판의 1번 글에 대해 한줄 답변 2개 쓰기 ?

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'lee',
             'l123',
             '좋은 정보 감사',
             1,
             SYSDATE,
             0);

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'park',
             'p123',
             '수정 부탁드려요',
             2,
             SYSDATE,
             0);
             
INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'lee',
             'l123',
             '좋은 정보 감사',
             2,
             SYSDATE,
             0);

INSERT INTO comments
     VALUES (seq_comments.NEXTVAL,
             'park',
             'p123',
             '수정 부탁드려요',
             1,
             SYSDATE,
             0);


-- 3. 한줄 답변 1개 삭제 - delete ? 

DELETE FROM comments
      WHERE no = 2;

--4. 게시판의 글 수정 - update ? 

UPDATE board
   SET main_text = 'java는 프로그래밍 언어로써...'
 WHERE no = 1;

--5. 게시판의 글 삭제 ? 한줄 답변도 같이 삭제되도록 ? 

DELETE FROM board
      WHERE no = 1;

--6. 게시판 목록 - select ? 번호 내림차순으로 전체 조회 ? 

  SELECT *
    FROM board
ORDER BY no;

--7. 게시판 목록에서 선택한 글 보기 ? 
--선택한 글만 조회 - select ? 
--선택한 글의 조회수 증가 - update ? 
--선택한 글의 한줄 답변 모두 조회 - select ? 

SELECT main_text
  FROM board
 WHERE no = 2;

UPDATE board
   SET c_num = c_num + 1
 WHERE no = 2;
 
select * from v_board_comments
where BOARD_NO=2;

--8. 제목, 내용, 작성자로 검색 - select
select * from board
where title like '%%' and main_text like '%%' and user_id like '%%';