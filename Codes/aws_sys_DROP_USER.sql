SELECT SID,SERIAL#,USERNAME,STATUS FROM V$SESSION WHERE SCHEMANAME='HAROOTPUPPY';

--ALTER SYSTEM KILL SESSION 'SID값, SERIAL#값';
ALTER SYSTEM KILL SESSION '44, 1215';

DROP USER HAROOTPUPPY CASCADE;
--==>> User HAROOTPUPPY이(가) 삭제되었습니다.

CREATE USER HAROOTPUPPY IDENTIFIED BY java006$;
--==>> User HAROOTPUPPY이(가) 생성되었습니다.

GRANT CONNECT, RESOURCE, DBA TO HAROOTPUPPY;
--==>> Grant을(를) 성공했습니다.