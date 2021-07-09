SELECT USER
FROM DUAL;
--==>> HAROOTPUPPY

-- 산책방 정보 뷰 
SELECT WALKROOM_CODE, WALKROOM_TITLE, WALKROOM_WORDS, WALKROOM_MIN, WALKROOM_MAX, WALKROOM_GENDATE
     , WALKROOM_START, WALKROOM_END, WALKROOM_PLACE, WALKROOM_LATITUDE, WALKROOM_LONGTITUDE
     ,PARTICIPANTS_CODE, SID_CODE, MEM_ID, MEM_NICKNAME, WALKROOM_LEADER
     , PET_CODE, PET_NAME, PET_PHOTO, PET_BITE_CODE, PET_BITE_CONTENT, PET_DESEX_CODE, PET_DESEX_CONTENT
     , PET_CHAR1_CODE, PET_CHAR1_CONTENT, PET_CHAR2_CODE, PET_CHAR2_CONTENT, PET_CHAR3_CODE, PET_CHAR3_CONTENT
     , PET_CHAR4_CODE, PET_CHAR4_CONTENT, RELATION_CODE, MATCH_STATE, WALK_STATE, MATCH_CODE, MATCH_DATE
     , AUTO_CODE, AUTO_CONTENT, STYLE_CODE, STYLE_CONTENT, BITE_CODE, BITE_CONTENT
     , DESEX_CODE, DESEX_CONTENT, SAMESEX_CODE, SAMESEX_CONTENT
FROM WALKROOMVIEW;

-- 산책 점수 뷰
SELECT SID_CODE, EVAL_AVG, REWARDS, WALK_SCORE
FROM WALKSCOREVIEW;


-- 신고당한 방을 제외한 산책방 리스트 출력 뷰
CREATE OR REPLACE VIEW WALKROOMLISTVIEW
AS
SELECT W.WALKROOM_CODE, W.WALKROOM_LEADER, W.AUTO_CODE
     , SL.STYLE_CONTENT, BL.BITE_CONTENT, DL.DESEX_CONTENT, SSL.SAMESEX_CONTENT
     , W.WALKROOM_MIN, W.WALKROOM_MAX
     , TO_CHAR(W.WALKROOM_START, 'YYYY-MM-DD HH24:MI') AS WALKROOM_START
     , TO_CHAR(W.WALKROOM_END, 'YYYY-MM-DD HH24:MI') AS WALKROOM_END
     , TO_CHAR(W.WALKROOM_
     , TO_CHAR(W.WALKROOM_START, 'HH24:MI') AS START_TIME
     , TO_CHAR(W.WALKROOM_END, 'HH24:MI') AS END_TIME
     , W.WALKROOM_TITLE, W.WALKROOM_WORDS, W.WALKROOM_PLACE, W.WALKROOM_LATITUDE, W.WALKROOM_LONGITUDE
     , TO_CHAR(W.WALKROOM_GENDATE, 'YYYY-MM-DD HH24:MI:SS') AS WALKROOM_GENDATE
     , M.MEM_NICKNAME, C.PARTI_COUNT
FROM TBL_WALKROOM W, TBL_SID S, TBL_MEMBER M
   , TBL_STYLE_LEG SL, TBL_BITE_LEG BL, TBL_DESEX_LEG DL, TBL_SAMESEX_LEG SSL
   , (SELECT W.WALKROOM_CODE AS WALKROOM_CODE
           , COUNT(*) AS PARTI_COUNT
      FROM TBL_WALKROOM W, TBL_PARTICIPANTS P
      WHERE W.WALKROOM_CODE = P.WALKROOM_CODE(+)
      GROUP BY W.WALKROOM_CODE) C
WHERE W.WALKROOM_LEADER = S.SID_CODE(+)
  AND S.MEM_CODE = M.MEM_CODE(+)
  AND W.STYLE_CODE = SL.STYLE_CODE(+)
  AND W.BITE_CODE = BL.BITE_CODE(+)
  AND W.DESEX_CODE = DL.DESEX_CODE(+)
  AND W.SAMESEX_CODE = SSL.SAMESEX_CODE(+)
  AND W.WALKROOM_CODE = C.WALKROOM_CODE(+)
  AND W.WALKROOM_CODE NOT IN (SELECT WR.WALKROOM_CODE AS WALKROOM_CODE
                              FROM TBL_REPORT_LOG L, TBL_WALKROOM_REPORT WR
                              WHERE L.REP_LOG_CODE = WR.REP_LOG_CODE
                                AND L.REP_STATE_CODE NOT IN 2
                              GROUP BY WR.WALKROOM_CODE)
ORDER BY WALKROOM_CODE DESC;


SELECT WALKROOM_CODE, WALKROOM_LEADER, AUTO_CODE
     , STYLE_CONTENT, BITE_CONTENT, DESEX_CONTENT, SAMESEX_CONTENT
     , WALKROOM_MIN, WALKROOM_MAX, WALKROOM_START, WALKROOM_END
     , START_TIME, END_TIME
     , WALKROOM_TITLE, WALKROOM_WORDS
     , WALKROOM_PLACE, WALKROOM_LATITUDE, WALKROOM_LONGITUDE
     , WALKROOM_GENDATE, MEM_NICKNAME, PARTI_COUNT
FROM WALKROOMLISTVIEW;

-- 산책방 수 카운트 쿼리
SELECT COUNT(*) AS COUNT
FROM WALKROOMLISTVIEW;

-- 산책방 추가 쿼리
INSERT INTO TBL_WALKROOM(WALKROOM_CODE, WALKROOM_LEADER
, AUTO_CODE, STYLE_CODE, BITE_CODE, DESEX_CODE, SAMESEX_CODE
, WALKROOM_MIN, WALKROOM_MAX
, WALKROOM_START, WALKROOM_END
, WALKROOM_TITLE, WALKROOM_WORDS, WALKROOM_PLACE, WALKROOM_LATITUDE, WALKROOM_LONGITUDE
, WALKROOM_GENDATE)
VALUES(1, 'SID001'
, '1', '2', '0', '1', '0'
, 2, 4
, TO_DATE('2021-06-27 18:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2021-06-27 19:00', 'YYYY-MM-DD HH24:MI')
, '함께 산책 하실 분?', '같이가요ㅎ', '안양천 철산-가산 돌다리 앞', '37.475694', '126.876208'
, TO_DATE('2021-06-27 13:15:24', 'YYYY-MM-DD HH24:MI:SS'));

SELECT MAX(WALKROOM_CODE)
FROM TBL_WALKROOM;

SELECT MAX(WALKROOM_CODE) AS MAX_NUM
FROM WALKROOMLISTVIEW;

DELETE
FROM TBL_WALKROOM
WHERE WALKROOM_CODE=5;

COMMIT;

SELECT *
FROM TBL_PARTICIPANTS;

SELECT *
FROM TBL_MEMBER;

SELECT S.SID_CODE AS SID_CODE
     , M.MEM_CODE AS MEM_CODE
     , M.MEM_ID AS MEM_ID
     , M.MEM_NAME AS MEM_NAME
FROM TBL_SID S,
(
    SELECT MEM_CODE, MEM_ID, MEM_NAME
    FROM TBL_MEMBER
    WHERE MEM_ID = 'joohee'
    AND MEM_PW = CRYPTPACK.ENCRYPT('1224', 'joohee')
)M
WHERE S.MEM_CODE = M.MEM_CODE;

MEM_CODE	MEM_ID	MEM_PW	MEM_NAME	MEM_BIRTH	MEM_GENDER	MEM_TEL	MEM_ADDR	MEM_REGDATE	MEM_NICKNAME
MEM001	joohee	"nb��	정주희	97/12/24	F	010-1111-1111	경기도 광명시 철산동	21/05/24	주리짱
