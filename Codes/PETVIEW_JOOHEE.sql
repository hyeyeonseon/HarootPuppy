SELECT USER
FROM DUAL;
--==>> HTEST


CREATE OR REPLACE VIEW PETVIEW
AS
SELECT P.PET_CODE AS PET_CODE
    , P.PET_TYPE_CODE AS PET_TYPE_CODE
    , T.PET_TYPE_NAME AS PET_TYPE_NAME
    , P.BITE_CODE AS BITE_CODE
    , B.BITE_CONTENT AS BITE_CONTENT
    , P.DESEX_CODE AS DESEX_CODE
    , S.DESEX_CONTENT AS DESEX_CONTENT
    , P.PET_SEX AS PET_SEX
    , TO_CHAR(P.PET_BIRTH, 'YYYY-MM-DD') AS PET_BIRTH 
    , P.PET_FAV_PLACE AS PET_FAV_PLACE
    , P.PET_SOCIAL AS PET_SOCIAL
    , P.PET_CHAR1_CODE AS PET_CHAR1_CODE
    , C1.PET_CHAR1_CONTENT AS PET_CHAR1_CONTENT
    , P.PET_CHAR2_CODE AS PET_CHAR2_CODE
    , C2.PET_CHAR2_CONTENT AS PET_CHAR2_CONTENT
    , P.PET_CHAR3_CODE AS PET_CHAR3_CODE
    , C3.PET_CHAR3_CONTENT AS PET_CHAR3_CONTENT
    , P.PET_CHAR4_CODE AS PET_CHAR4_CODE
    , C4.PET_CHAR4_CONTENT AS PET_CHAR4_CONTENT
    , P.PET_SIZE AS PET_SIZE
    , I.PET_INFO_CODE AS PET_INFO_CODE
    , I.PET_NAME AS PET_NAME
    , I.PET_PHOTO AS PET_PHOTO
    , I.PET_ADDR AS PET_ADDR
    , I.PET_REGNUM AS PET_REGNUM    
    , D.DISEASE_CODE AS DISEASE_CODE
    , DT.DISEASE_CONTENT AS DISEASE_CONTENT    
    , F.FAV_FOOD_CODE AS FAV_FOOD_CODE
    , FT.FAV_FOOD_CONTENT AS FAV_FOOD_CONTENT    
    , V.INJECT_TYPE_CODE AS VACCINE_CODE
    , JT.INJECT_TYPE_NAME AS INJECT_TYPE_NAME
FROM TBL_PET P
LEFT OUTER JOIN TBL_PET_INFO I ON P.PET_CODE = I.PET_CODE
LEFT OUTER JOIN TBL_PET_TYPE T ON P.PET_TYPE_CODE = T.PET_TYPE_CODE
LEFT OUTER JOIN TBL_BITE_LEG B ON P.BITE_CODE = B.BITE_CODE
LEFT OUTER JOIN TBL_DESEX_LEG S ON P.DESEX_CODE = S.DESEX_CODE
LEFT OUTER JOIN TBL_PET_CHAR1 C1 ON P.PET_CHAR1_CODE = C1.PET_CHAR1_CODE
LEFT OUTER JOIN TBL_PET_CHAR2 C2 ON P.PET_CHAR2_CODE = C2.PET_CHAR2_CODE
LEFT OUTER JOIN TBL_PET_CHAR3 C3 ON P.PET_CHAR3_CODE = C3.PET_CHAR3_CODE
LEFT OUTER JOIN TBL_PET_CHAR4 C4 ON P.PET_CHAR4_CODE = C4.PET_CHAR4_CODE
LEFT OUTER JOIN TBL_DISEASE D ON P.PET_CODE = D.PET_CODE
LEFT OUTER JOIN TBL_DISEASE_TYPE DT ON D.DISEASE_TYPE_CODE = DT.DISEASE_TYPE_CODE
LEFT OUTER JOIN TBL_FAV_FOOD F ON P.PET_CODE = F.PET_CODE
LEFT OUTER JOIN TBL_FAV_FOOD_TYPE FT ON F.FAV_FOOD_TYPE_CODE = FT.FAV_FOOD_TYPE_CODE
LEFT OUTER JOIN TBL_VACCINE V ON P.PET_CODE = V.PET_CODE
LEFT OUTER JOIN TBL_INJECT_TYPE JT ON V.INJECT_TYPE_CODE = JT.INJECT_TYPE_CODE
ORDER BY P.PET_CODE;

--==>> View PET_VIEW이(가) 생성되었습니다.

SELECT *
FROM PETVIEW;


--------------------------------------------------------
--○ RELATIONVIEW 생성 (TBL_RELATION + TBL_RELATION_TYPE)
CREATE OR REPLACE VIEW RELATIONVIEW
AS
SELECT R.RELATION_CODE AS RELATIOIN_CODE
    , R.SID_CODE AS SID_CODE
    , R.PET_CODE AS PET_CODE
    , R.RELATION_TYPE_CODE AS RELATION_TYPE_CODE
    , RT.RELATION_TYPE_CONTENT AS RELATION_TYPE_CONTENT
FROM TBL_RELATION R
LEFT OUTER JOIN TBL_RELATION_TYPE RT ON R.RELATION_TYPE_CODE = RT.RELATION_TYPE_CODE
ORDER BY RELATION_CODE;


SELECT *
FROM RELATIONVIEW;


COMMIT;

-----------------------------------------------------------------
--○ PETVIEW + RELATIONVIEW (모두 합친 뷰)
CREATE OR REPLACE VIEW PETRELATION_VIEW
AS
SELECT P.PET_CODE AS PET_CODE
    , P.PET_TYPE_CODE AS PET_TYPE_CODE
    , T.PET_TYPE_NAME AS PET_TYPE_NAME
    , P.BITE_CODE AS BITE_CODE
    , B.BITE_CONTENT AS BITE_CONTENT
    , P.DESEX_CODE AS DESEX_CODE
    , S.DESEX_CONTENT AS DESEX_CONTENT
    , P.PET_SEX AS PET_SEX
    , TO_CHAR(P.PET_BIRTH, 'YYYY-MM-DD') AS PET_BIRTH 
    , P.PET_FAV_PLACE AS PET_FAV_PLACE
    , P.PET_SOCIAL AS PET_SOCIAL
    , P.PET_CHAR1_CODE AS PET_CHAR1_CODE
    , C1.PET_CHAR1_CONTENT AS PET_CHAR1_CONTENT
    , P.PET_CHAR2_CODE AS PET_CHAR2_CODE
    , C2.PET_CHAR2_CONTENT AS PET_CHAR2_CONTENT
    , P.PET_CHAR3_CODE AS PET_CHAR3_CODE
    , C3.PET_CHAR3_CONTENT AS PET_CHAR3_CONTENT
    , P.PET_CHAR4_CODE AS PET_CHAR4_CODE
    , C4.PET_CHAR4_CONTENT AS PET_CHAR4_CONTENT
    , P.PET_SIZE AS PET_SIZE
    , I.PET_INFO_CODE AS PET_INFO_CODE
    , I.PET_NAME AS PET_NAME
    , I.PET_PHOTO AS PET_PHOTO
    , I.PET_ADDR AS PET_ADDR
    , I.PET_REGNUM AS PET_REGNUM    
    , D.DISEASE_CODE AS DISEASE_CODE
    , DT.DISEASE_CONTENT AS DISEASE_CONTENT    
    , F.FAV_FOOD_CODE AS FAV_FOOD_CODE
    , FT.FAV_FOOD_CONTENT AS FAV_FOOD_CONTENT    
    , V.INJECT_TYPE_CODE AS VACCINE_CODE
    , JT.INJECT_TYPE_NAME AS INJECT_TYPE_NAME
    , R.RELATION_CODE AS RELATION_CODE
    , R.SID_CODE AS SID_CODE
    , R.RELATION_TYPE_CODE AS RELATION_TYPE_CODE
    , RT.RELATION_TYPE_CONTENT AS RELATION_TYPE_CONTENT
FROM TBL_PET P
LEFT OUTER JOIN TBL_PET_INFO I ON P.PET_CODE = I.PET_CODE
LEFT OUTER JOIN TBL_PET_TYPE T ON P.PET_TYPE_CODE = T.PET_TYPE_CODE
LEFT OUTER JOIN TBL_BITE_LEG B ON P.BITE_CODE = B.BITE_CODE
LEFT OUTER JOIN TBL_DESEX_LEG S ON P.DESEX_CODE = S.DESEX_CODE
LEFT OUTER JOIN TBL_PET_CHAR1 C1 ON P.PET_CHAR1_CODE = C1.PET_CHAR1_CODE
LEFT OUTER JOIN TBL_PET_CHAR2 C2 ON P.PET_CHAR2_CODE = C2.PET_CHAR2_CODE
LEFT OUTER JOIN TBL_PET_CHAR3 C3 ON P.PET_CHAR3_CODE = C3.PET_CHAR3_CODE
LEFT OUTER JOIN TBL_PET_CHAR4 C4 ON P.PET_CHAR4_CODE = C4.PET_CHAR4_CODE
LEFT OUTER JOIN TBL_DISEASE D ON P.PET_CODE = D.PET_CODE
LEFT OUTER JOIN TBL_DISEASE_TYPE DT ON D.DISEASE_TYPE_CODE = DT.DISEASE_TYPE_CODE
LEFT OUTER JOIN TBL_FAV_FOOD F ON P.PET_CODE = F.PET_CODE
LEFT OUTER JOIN TBL_FAV_FOOD_TYPE FT ON F.FAV_FOOD_TYPE_CODE = FT.FAV_FOOD_TYPE_CODE
LEFT OUTER JOIN TBL_VACCINE V ON P.PET_CODE = V.PET_CODE
LEFT OUTER JOIN TBL_INJECT_TYPE JT ON V.INJECT_TYPE_CODE = JT.INJECT_TYPE_CODE
LEFT OUTER JOIN TBL_RELATION R ON P.PET_CODE = R.PET_CODE
LEFT OUTER JOIN TBL_RELATION_TYPE RT ON R.RELATION_TYPE_CODE = RT.RELATION_TYPE_CODE
ORDER BY P.PET_CODE; 

SELECT *
FROM PETRELATION_VIEW;



-----------------------------------------------------------------
--○ PETVIEW + RELATIONVIEW (CHECK BOX 제외) 
-- SID_CODE 에 따른 PET_NAME 찾기 위함
CREATE OR REPLACE VIEW FORPETNAME_VIEW
AS
SELECT P.PET_CODE AS PET_CODE
    , P.PET_TYPE_CODE AS PET_TYPE_CODE
    , T.PET_TYPE_NAME AS PET_TYPE_NAME
    , P.BITE_CODE AS BITE_CODE
    , B.BITE_CONTENT AS BITE_CONTENT
    , P.DESEX_CODE AS DESEX_CODE
    , S.DESEX_CONTENT AS DESEX_CONTENT
    , P.PET_SEX AS PET_SEX
    , TO_CHAR(P.PET_BIRTH, 'YYYY-MM-DD') AS PET_BIRTH 
    , P.PET_FAV_PLACE AS PET_FAV_PLACE
    , P.PET_FAV_LAT AS PET_FAV_LAT                      -- 하림 추가(즐겨찾는 산책장소 위도)
    , P.PET_FAV_LNG AS PET_FAV_LNG                      -- 하림 추가(즐겨찾는 산책장소 경도)
    , P.PET_SOCIAL AS PET_SOCIAL
    , P.PET_CHAR1_CODE AS PET_CHAR1_CODE
    , C1.PET_CHAR1_CONTENT AS PET_CHAR1_CONTENT
    , P.PET_CHAR2_CODE AS PET_CHAR2_CODE
    , C2.PET_CHAR2_CONTENT AS PET_CHAR2_CONTENT
    , P.PET_CHAR3_CODE AS PET_CHAR3_CODE
    , C3.PET_CHAR3_CONTENT AS PET_CHAR3_CONTENT
    , P.PET_CHAR4_CODE AS PET_CHAR4_CODE
    , C4.PET_CHAR4_CONTENT AS PET_CHAR4_CONTENT
    , P.PET_SIZE AS PET_SIZE
    , I.PET_INFO_CODE AS PET_INFO_CODE
    , I.PET_NAME AS PET_NAME
    , I.PET_PHOTO AS PET_PHOTO
    , I.PET_ADDR AS PET_ADDR
    , I.PET_ADDR_LAT AS PET_ADDR_LAT                    -- 하림 추가(반려견 주소 위도) 
    , I.PET_ADDR_LNG AS PET_ADDR_LNG                    -- 하림 추가(반려견 주소 경도)
    , I.PET_REGNUM AS PET_REGNUM    
    , R.RELATION_CODE AS RELATION_CODE
    , R.SID_CODE AS SID_CODE
    , R.RELATION_TYPE_CODE AS RELATION_TYPE_CODE
    , RT.RELATION_TYPE_CONTENT AS RELATION_TYPE_CONTENT
FROM TBL_PET P
LEFT OUTER JOIN TBL_PET_INFO I ON P.PET_CODE = I.PET_CODE
LEFT OUTER JOIN TBL_PET_TYPE T ON P.PET_TYPE_CODE = T.PET_TYPE_CODE
LEFT OUTER JOIN TBL_BITE_LEG B ON P.BITE_CODE = B.BITE_CODE
LEFT OUTER JOIN TBL_DESEX_LEG S ON P.DESEX_CODE = S.DESEX_CODE
LEFT OUTER JOIN TBL_PET_CHAR1 C1 ON P.PET_CHAR1_CODE = C1.PET_CHAR1_CODE
LEFT OUTER JOIN TBL_PET_CHAR2 C2 ON P.PET_CHAR2_CODE = C2.PET_CHAR2_CODE
LEFT OUTER JOIN TBL_PET_CHAR3 C3 ON P.PET_CHAR3_CODE = C3.PET_CHAR3_CODE
LEFT OUTER JOIN TBL_PET_CHAR4 C4 ON P.PET_CHAR4_CODE = C4.PET_CHAR4_CODE
LEFT OUTER JOIN TBL_RELATION R ON P.PET_CODE = R.PET_CODE
LEFT OUTER JOIN TBL_RELATION_TYPE RT ON R.RELATION_TYPE_CODE = RT.RELATION_TYPE_CODE
ORDER BY P.PET_CODE; 

SELECT *
FROM FORPETNAME_VIEW;



-------------------------------------------------------------
--○ RELATIONVIEW DAO에 사용되는 쿼리문
-- SID로 검색
SELECT RELATION_CODE, SID_CODE, PET_CODE, RELATION_TYPE_CODE, RELATION_TYPE_CONTENT
FROM RELATIONVIEW
WHERE SID_CODE = 'SID002';

SELECT *
FROM RELATIONVIEW;


--○ PETRELATION_VIEW 에서 사용되는 쿼리문
-- SID 로 검색 → PET_NAME
SELECT SID_CODE, PET_CODE, PET_NAME, RELATION_CODE, PET_PHOTO
		FROM FORPETNAME_VIEW
		WHERE SID_CODE = 'SID001';


SELECT SID_CODE, PET_NAME, RELATION_CODE, PET_PHOTO
    , PET_CODE, PET_TYPE_CODE, PET_TYPE_NAME
    , BITE_CONTENT, DESEX_CONTENT, PET_BIRTH
    , PET_FAV_PLACE, PET_SOCIAL
    , PET_CHAR1_CONTENT, PET_CHAR2_CONTENT 
    , PET_CHAR3_CONTENT, PET_CHAR4_CONTENT
    , PET_SIZE, PET_INFO_CODE
    , PET_ADDR, PET_REGNUM
    , RELATION_TYPE_CONTENT
FROM FORPETNAME_VIEW
WHERE PET_CODE = 'PET003';

SELECT *
FROM FORPETNAME_VIEW;


SELECT PET_CODE, PET_NAME, SID_CODE, RELATION_CODE
FROM FORPETNAME_VIEW
WHERE PET_CODE = 'PET003';

commit;

------------------------------------------------------------------------------
--○ 주희-강쥐 데이터 추가 입력
SELECT *
FROM TBL_PET;

INSERT INTO TBL_PET
VALUES('PET009' , 'PETTY002', '0', '1', 'F', TO_DATE('2021-02-02'), '안양천돌다리', 5, '1', '2' ,'1' ,'2' ,'소형견'); 

INSERT INTO TBL_RELATION
VALUES('REL009', 'SID001' , 'PET009', '1');

SELECT*
FROM TBL_RELATION;

SELECT *
FROM FORPETNAME_VIEW
WHERE SID_CODE = 'SID001';

SELECT *
FROM TBL_PET_INFO;

INSERT INTO TBL_PET_INFO (PET_INFO_CODE, PET_CODE, PET_NAME, PET_PHOTO, PET_ADDR)
VALUES('PETIN009', 'PET009', '강쥐', 'C:\Users\', '경기도 광명시 철산3동');



SELECT *
FROM TBL_WALKROOM;

COMMIT;

SELECT *
FROM TBL_PET;



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--○ 쿼리문 준비
--1. 특정 회원의 양육관계 리스트 검색
SELECT SID_CODE, PET_CODE, PET_NAME, RELATION_CODE, PET_PHOTO
FROM FORPETNAME_VIEW
WHERE SID_CODE = 'SID001';

--2. 특정회원의 특정 반려견 정보 (pet_code 기반)
SELECT PET_CODE, PET_NAME, SID_CODE, RELATION_CODE
FROM FORPETNAME_VIEW
WHERE SID_CODE = 'SID001';

SELECT PET_CODE
FROM TBL_RELATION
WHERE SID_CODE = 'SID001';


--3. 반려견 정보보기 버튼을 위한 (반려견정보) 쿼리문 
SELECT PET_NAME, PET_SEX, PET_REGNUM, PET_BIRTH, PET_TYPE_NAME, PET_SIZE
    , DISEASE_CONTENT, FAV_FOOD_CONTENT, INJECT_TYPE_NAME
FROM PETVIEW
WHERE PET_CODE = 'PET003';