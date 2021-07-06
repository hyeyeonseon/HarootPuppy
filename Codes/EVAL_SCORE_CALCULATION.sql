SELECT USER
FROM DUAL;

SELECT *
FROM TBL_EVALUATION;
--==>> 
/*
EVAL_CODE	MATCH_CODE	EVAL_WRITER	EVAL_TARGET	EVAL_SCORE1	EVAL_SCORE2	EVAL_SCORE3	EVAL_SCORE4
EVAL001	    MAT001	    PAR003	    PAR001	    90	        80	        80	        85
EVAL002	    MAT001	    PAR001	    PAR003		100		
EVAL003	    MAT002	    PAR003	    PAR005	    90	        90	        90	        90
EVAL004	    MAT002	    PAR005	    PAR003	    80	        75	        80	        90
*/

UPDATE TBL_EVALUATION
SET EVAL_SCORE1 = 100
WHERE EVAL_CODE = 'EVAL002';

ROLLBACK;

SELECT *
FROM TBL_WALK_SCORE;
--==>>
/*
SCORE001	SID001		EVAL001	21/06/28
SCORE002	SID007		EVAL003	21/06/28
SCORE003	SID009		EVAL004	21/06/28
*/

SELECT *
FROM TBL_REWARD;
--==>> 
/*
1	-7	방장이 30분 전까지 매칭완료 하지 않은 경우
2	-7	방장이 최종 매칭 전 방을 나간 경우
3	-10	방장이 최종 매칭 완료 후 방을 나간 경우
4	-5	참여자가 매칭 완료 후 방을 나간 경우
*/

SELECT EVAL_TARGET, SUM((NVL(EVAL_SCORE1, 0) + NVL(EVAL_SCORE2, 0) + NVL(EVAL_SCORE3, 0) + NVL(EVAL_SCORE4, 0))/4) AS 총합
FROM TBL_WALK_SCORE S, TBL_EVALUATION E, TBL_REWARD R
WHERE S.EVAL_CODE(+) = E.EVAL_CODE
GROUP BY EVAL_TARGET;

SELECT ET.SID_CODE, SUM(ET.SSUM)/COUNT(NVL(ET.SID_CODE, 0))
FROM
(
    SELECT S.SID_CODE AS SID_CODE, E.EVAL_TARGET AS EVAL_TARGET
         , SUM((NVL(E.EVAL_SCORE1, 0) + NVL(E.EVAL_SCORE2, 0) + NVL(E.EVAL_SCORE3, 0) + NVL(E.EVAL_SCORE4, 0))/4)/COUNT(*) AS SSUM
    FROM TBL_WALK_SCORE S, TBL_EVALUATION E
    WHERE S.EVAL_CODE(+) = E.EVAL_CODE
      AND (E.EVAL_SCORE1 IS NOT NULL OR E.EVAL_SCORE2 IS NOT NULL OR E.EVAL_SCORE3 IS NOT NULL OR E.EVAL_SCORE4 IS NOT NULL)
    GROUP BY S.SID_CODE, E.EVAL_TARGET
    ORDER BY S.SID_CODE
) ET, TBL_REWARD R
GROUP BY ET.SID_CODE;
-- 여기까지가 모든 산책점수를 평균 낸 것
 


-- sid 기준으로 조회(평가 항목 없어도 조회되도록)
SELECT SI.SID_CODE AS SID_CODE, E.EVAL_TARGET AS EVAL_TARGET
     , SUM((NVL(E.EVAL_SCORE1, 0) + NVL(E.EVAL_SCORE2, 0) + NVL(E.EVAL_SCORE3, 0) + NVL(E.EVAL_SCORE4, 0))/4) AS SSUM
FROM TBL_SID SI, TBL_WALK_SCORE S, TBL_EVALUATION E,
(
    SELECT S.SID_CODE AS SID_CODE
    FROM TBL_WALK_SCORE S, TBL_EVALUATION E
    WHERE S.EVAL_CODE(+) = E.EVAL_CODE
      AND (E.EVAL_SCORE1 IS NOT NULL OR E.EVAL_SCORE2 IS NOT NULL OR E.EVAL_SCORE3 IS NOT NULL OR E.EVAL_SCORE4 IS NOT NULL)
) Z
WHERE SI.SID_CODE = S.SID_CODE(+)
  AND S.EVAL_CODE = E.EVAL_CODE(+)
  AND S.SID_CODE = Z.SID_CODE(+)
GROUP BY SI.SID_CODE, E.EVAL_TARGET, Z.SID_CODE
ORDER BY SI.SID_CODE;

SELECT *
FROM TBL_WALK_SCORE;


SELECT *
FROM TBL_EVALUATION E, TBL_WALK_SCORE S
WHERE E.EVAL_CODE = S.EVAL_CODE(+)
  AND SID_CODE = 'SID002'
ORDER BY E.EVAL_CODE;


-- 상벌점
SELECT EV.SID_CODE, EV.EVAL_AVG, 평가총합, (EV.EVAL_AVG+평가총합) AS 산책점수
FROM 
(
    SELECT ET.SID_CODE, SUM(ET.SSUM)/COUNT(NVL(ET.SID_CODE, 0)) AS EVAL_AVG
    FROM
    (
        SELECT E.EVAL_TARGET AS EVAL_TARGET, S.SID_CODE AS SID_CODE
             , SUM((NVL(EVAL_SCORE1, 0) + NVL(EVAL_SCORE2, 0) + NVL(EVAL_SCORE3, 0) + NVL(EVAL_SCORE4, 0))/4)/COUNT(*) AS SSUM
        FROM TBL_WALK_SCORE S, TBL_EVALUATION E
        WHERE S.EVAL_CODE(+) = E.EVAL_CODE
          AND (EVAL_SCORE1 IS NOT NULL OR EVAL_SCORE2 IS NOT NULL OR EVAL_SCORE3 IS NOT NULL OR EVAL_SCORE4 IS NOT NULL)
        GROUP BY S.SID_CODE, E.EVAL_TARGET
    ) ET, TBL_REWARD R
    GROUP BY ET.SID_CODE
) EV,
(
    SELECT S.SID_CODE
         , SUM(NVL(R.REWARD_SCORE, 0))/COUNT(*) AS 평가총합
    FROM TBL_WALK_SCORE S
        LEFT JOIN TBL_REWARD R
            ON R.REWARD_CODE = S.REWARD_CODE
    GROUP BY S.SID_CODE
) REW
WHERE REW.SID_CODE = EV.SID_CODE;

SELECT *
FROM TBL_SID;


-- sid 기준 산책점수 평균 조회쿼리
SELECT ET.SID_CODE AS SID_CODE, SUM(ET.SSUM)/COUNT(NVL(ET.SID_CODE, 0)) AS EVAL_AVG
FROM
(
    SELECT SI.SID_CODE AS SID_CODE, E.EVAL_TARGET AS EVAL_TARGET
         ,  SUM((NVL(E.EVAL_SCORE1, 0) + NVL(E.EVAL_SCORE2, 0) + NVL(E.EVAL_SCORE3, 0) + NVL(E.EVAL_SCORE4, 0))/4)/COUNT(*) AS SSUM
    FROM TBL_SID SI, TBL_WALK_SCORE S, TBL_EVALUATION E
    WHERE SI.SID_CODE = S.SID_CODE(+)
      AND S.EVAL_CODE = E.EVAL_CODE(+)
    GROUP BY SI.SID_CODE, E.EVAL_TARGET
    ORDER BY SI.SID_CODE
) ET, TBL_REWARD R
GROUP BY ET.SID_CODE;


SELECT EV.SID_CODE, EV.EVAL_AVG, REW.REWARD, (EV.EVAL_AVG+REW.REWARD) AS WALK_SCORE
FROM 
(
    SELECT ET.SID_CODE AS SID_CODE, SUM(ET.SSUM)/ REPLACE(COUNT(ET.EVAL_TARGET), 0, 1) AS EVAL_AVG, COUNT(ET.SID_CODE)
    FROM
    (
        SELECT SI.SID_CODE AS SID_CODE, E.EVAL_TARGET AS EVAL_TARGET
             , SUM((NVL(E.EVAL_SCORE1, 0) + NVL(E.EVAL_SCORE2, 0) + NVL(E.EVAL_SCORE3, 0) + NVL(E.EVAL_SCORE4, 0))/4) / REPLACE(COUNT(E.EVAL_CODE), 0, 1) AS SSUM
             --,  REPLACE(COUNT(E.EVAL_CODE), 0, 1)
        FROM TBL_SID SI, TBL_WALK_SCORE S, TBL_EVALUATION E
        WHERE SI.SID_CODE = S.SID_CODE(+)
          AND S.EVAL_CODE = E.EVAL_CODE(+)
        GROUP BY SI.SID_CODE, E.EVAL_TARGET
        ORDER BY SI.SID_CODE
    ) ET
    GROUP BY ET.SID_CODE
) EV,
(
    SELECT SI.SID_CODE
         , SUM(NVL(R.REWARD_SCORE, 0)) AS REWARD
    FROM TBL_SID SI 
     LEFT JOIN TBL_WALK_SCORE S
        ON SI.SID_CODE = S.SID_CODE
        LEFT JOIN TBL_REWARD R
            ON R.REWARD_CODE = S.REWARD_CODE
    GROUP BY SI.SID_CODE
) REW
WHERE EV.SID_CODE = REW.SID_CODE
ORDER BY EV.SID_CODE;

SELECT *
FROM TBL_WALK_SCORE;