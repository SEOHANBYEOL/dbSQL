--1.leaf 노드(행)가 어떤 데이터인지 확인
--2.LEVEL --> 상향탐색시 그룹을 묶기 위해 필요한 값
--3. leaf 노드부터 상향 탐색, ROWNUM;

SELECT LPAD(' ',(LEVEL-1) *4) || org_cd, total
FROM
    (SELECT org_cd, parent_org_cd, SUM(total) total 
    FROM
        (SELECT org_cd, parent_org_cd, no_emp, 
                SUM(no_emp) OVER (PARTITION BY gno ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)total
        FROM
            (SELECT org_cd, parent_org_cd, lv, ROWNUM rn, lv+ROWNUM gno,
              no_emp / COUNT(*) OVER(PARTITION BY org_cd) no_emp
            FROM
                (SELECT no_emp.*, LEVEL lv, CONNECT_BY_ISLEAF leaf
                FROM no_emp
                START WITH parent_org_cd IS NULL
                CONNECT BY PRIOR org_cd = parent_org_cd)
            START WITH leaf = 1 
            CONNECT BY PRIOR parent_org_cd = org_cd))
    GROUP BY org_cd, parent_org_cd)
START WITH parent_org_cd IS NULL
CONNECT BY PRIOR org_cd = parent_org_cd;



DROP TABLE gis_dt;
CREATE TABLE gis_dt AS
SELECT SYSDATE + ROUND(DBMS_RANDOM.value(-30, 30)) dt,
       '블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다 블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다블록의 사이즈를 강제로 키우기 위한 더미 데이터 입니다' v1
FROM dual
CONNECT BY LEVEL <= 1000000;

CREATE INDEX idx_n_gis_dt_01 ON gis_dt (dt, v1);

SELECT *
FROM gis_dt;

--gis_dt의 dt컬럼에서 2020년 2월에 해당하는 날짜를 중복되지 않게 구한다. : 최대 29건의 행

SELECT dt
FROM gis_dt
GROUP BY dt
ORDER BY dt;
--WHERE TO_CHAR(dt,'MM') = '02'

SELECT TO_CHAR(dt,'yyyy-mm-dd')
FROM gis_dt
WHERE dt BETWEEN TO_DATE('20200201','YYYYMMDD') AND TO_DATE('20200229 23:59:59','YYYYMMDD hh24:mi:ss')
GROUP BY TO_CHAR(dt,'yyyy-mm-dd')
ORDER BY TO_CHAR(dt,'yyyy-mm-dd');

SELECT *
FROM
(SELECT TO_DATE('20200201','YYYYMMDD')+ LEVEL-1 dt
FROM dual
CONNECT BY LEVEL <=29)a
WHERE EXISTS (SELECT 'X'
                FROM gis_dt
                WHERE gis_dt.dt BETWEEN dt AND TO_DATE(TO_CHAR(dt,'YYYYMMDD') ||'235959','YYYYMMDDHH24MISS'));
                
                
--PL/SQL 블록 구조
--DECLARE :변수, 상수 선언[생략 가능]
--BEGIN :로직 기술 [생략 불가]
--EXCEPTION :예외 처리 [생략 가능]

--PL/SQL 연산자
--중복 되는 연산자 제외 특이점
--대입 연산자가 일반적인 프로그래밍 언어와 다르다
--JAVA =
--PL/SQL :=

--PL/SQL 변수 선언
--JAVA :타입 변수명 (String str;)
--PL/SQL :변수명 타입 (deptno NUMBER(2);)

--PL/SQL 코드라인의 끝을 기술은 JAVA와 동일하게 세미콜론을 기술한다.
--java : String str;
--pl/sql : deptno NUMBER(2);

--PL/SQL 블록의 종료 표시하는 문자열 :/
--SQL의 종료 문자열 : ;

--Hello World 출력
SET SERVEROUTPUT ON;

DECLARE
    msg VARCHAR2(50);
BEGIN
    msg := 'Hello, World!';
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/


--부서 테이블에서 10번 부서의 부서번호와, 부서 이름을 PL/SQL 변수에 저장하고 
--변수를 출력;

DESC dept;

DECLARE
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ':' ||v_dname);
END;
/



--PL/SQL 참조 타입
--부서 테이블의 부서번호, 부서명을 조회하여 변수에 담는 과정
--부서번호, 부서명의 타입은 부서 테이블에 정의가 되어 있음

--NUMBER, VARCHAR2 타입을 직접 명시하는게 아니라 해당 테이블의 컬럼의 타입을 참조하도록
--변수 타입을 선언할수 있다.

--V_deptno NUMBER(2) ==> dept.deptno%TYPE

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' ||v_dname);
END;
/


--프로시져 블록 유형
--익명 블럭(이름이 없는 블럭)
--.재사용이 불가능하다 (IN-LINE-VIEW vs VIEW)

--프로시져 (이름이 있는 블럭)
--.재사용이 가능하다
--.이름이 있다
--.프로시져를 실행할 때 함수처럼 인자를 받을 수 있다.

--함수(이름이 있는 블럭)
--.재사용 가능하다
--.이름이 있다
--.프로시져와 다른점은 리턴 값이 있다

--프로시져 형태
--CREATE OR REPLACE PROCEDURE 프로시져이름 is (IN param, OUT param, IN OUT param)
--   선언부(DECLARE절이 별도로 없다)
--   BEGIN
--   EXCEPTION (옵션)
--END;
--/

-- 부서 테이블에서 10번 부서의 부서번호와 부서 이름을 PL/SQL 변수에 저장하고
-- DBMS_OUTPUT.PUT_LINE 함수를 이용해서 화면에 출력하는 printdept 프로시져를 생성

CREATE OR REPLACE PROCEDURE printdept IS
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    BEGIN
        SELECT deptno, dname INTO v_deptno, v_dname
        FROM dept
        WHERE deptno = 10;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    END;
    /
--프로시져 실행 방법
--exec 프로시져명(인자...);
exec printdept;

--printdept_p  인자로 부서번호를 받아서
--해당 부서번호에 해당하는 부서이름과 지역정보를 콘솔에 출력하는 프로시져

CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) IS
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno ;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ',' ||v_loc);
END;
/
    
exec printdept_p(10);
exec printdept_p(20);
exec printdept_p(30);
exec printdept_p(40);



CREATE OR REPLACE PROCEDURE printemp(p_empno IN emp.empno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
    
BEGIN
    SELECT emp.ename, dept.dname INTO v_ename, v_dname
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
    AND emp.empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE(v_ename || ', ' ||v_dname);
END;
/

SET SERVEROUTPUT ON;
exec printemp(7844);





CREATE OR REPLACE PROCEDURE registdept_test(p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE) IS
    
BEGIN
   INSERT INTO dept_test(deptno, dname, loc, empcnt) VALUES(p_deptno, p_dname, p_loc, 0); 
    
END;
/

exec registdept_test(99,'ddit','daejeon')

SELECT *
FROM dept_test;