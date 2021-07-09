--○ PRC_MEMBER_INSERT
CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_MEM_ID              IN TBL_MEMBER.MEM_ID%TYPE
, V_MEM_PW              IN TBL_MEMBER.MEM_PW%TYPE
, V_MEM_NAME            IN TBL_MEMBER.MEM_NAME%TYPE
, V_MEM_BIRTH           IN TBL_MEMBER.MEM_BIRTH%TYPE
, V_MEM_GENDER          IN TBL_MEMBER.MEM_GENDER%TYPE
, V_MEM_TEL             IN TBL_MEMBER.MEM_TEL%TYPE
, V_MEM_ADDR            IN TBL_MEMBER.MEM_ADDR%TYPE
, V_MEM_NICKNAME        IN TBL_MEMBER.MEM_NICKNAME%TYPE
, V_WALK_AGREE_CHECK    IN TBL_WALK_AGREE.WALK_AGREE_CHECK%TYPE
)
IS
    V_MEM_CODE            TBL_MEMBER.MEM_CODE%TYPE;
    V_SID_CODE            TBL_SID.SID_CODE%TYPE;
    V_WALK_AGREE_CODE     TBL_WALK_AGREE.WALK_AGREE_CODE%TYPE;
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- MEM_CODE 자동입력
    SELECT CONCAT('MEM', NVL(MAX(TO_NUMBER(SUBSTR(MEM_CODE, 4, 6))), 0) + 1) INTO V_MEM_CODE
    FROM TBL_MEMBER;
    
    -- INSERT MEMBER 쿼리문
    INSERT INTO TBL_MEMBER(MEM_CODE, MEM_ID, MEM_PW, MEM_NAME
    , MEM_BIRTH, MEM_GENDER, MEM_TEL
    , MEM_ADDR, MEM_REGDATE, MEM_NICKNAME)
    VALUES (V_MEM_CODE, V_MEM_ID, CRYPTPACK.ENCRYPT(V_MEM_PW, V_MEM_ID), V_MEM_NAME
    , TO_DATE(V_MEM_BIRTH, 'YYYY-MM-DD'),  V_MEM_GENDER
    , (SUBSTR(V_MEM_TEL, 1, 3) || '-' || SUBSTR(V_MEM_TEL, 5, 8) || SUBSTR(V_MEM_TEL, 10, 13))
    , V_MEM_ADDR
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS')
    , V_MEM_NICKNAME);
    
    
     — SID_CODE 자동입력
    SELECT CONCAT('SID', NVL(MAX(TO_NUMBER(SUBSTR(SID_CODE, 4, 6))),0) + 1) INTO V_SID_CODE
    FROM TBL_SID;   
    
    — INSERT SID 쿼리문
    INSERT INTO TBL_SID(SID_CODE, MEM_CODE)
    VALUES(V_SID_CODE, V_MEM_CODE);
    
    
     — WALK_AGREE_CODE 자동입력
    SELECT CONCAT('AGR', NVL(MAX(TO_NUMBER(SUBSTR(WALK_AGREE_CODE, 4, 6))), 0) + 1) INTO V_WALK_AGREE_CODE
    FROM TBL_WALK_AGREE;   
    
    — INSERT WALK_AGREE 쿼리문
    INSERT INTO TBL_WALK_AGREE(WALK_AGREE_CODE, SID_CODE, WALK_AGREE_CHECK, WALK_AGREE_DATE)
    VALUES(V_WALK_AGREE_CODE, V_SID_CODE, V_WALK_AGREE_CHECK
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS'));
        
    
END;