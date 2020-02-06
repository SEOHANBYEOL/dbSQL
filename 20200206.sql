  --fastfood테이블을 한번만 읽는 방식으로 작성하기;
SELECT rownum, sido, sigungu, burger_score
FROM
    (SELECT sido, sigungu, ROUND((kfc+BURGERKING+mac)/lot,2)burger_score
    FROM
        (SELECT sido, sigungu,  
                NVL(SUM(DECODE(gb,'KFC',1)),0)kfc, NVL(SUM(DECODE(gb, '버거킹',1)),0) BURGERKING,
                NVL(SUM(DECODE(gb,'맥도날드',1)),0)mac, NVL(SUM(DECODE(gb, '롯데리아',1)),1) lot
        FROM fastfood
        WHERE gb IN('KFC','버거킹','맥도날드','롯데리아')
        GROUP BY sido, sigungu)
    ORDER BY burger_score DESC);
    
    
SELECT rownum, sido, sigungu, pri_sal     
FROM
    (SELECT sido, sigungu, ROUND(sal/people) pri_sal
    FROM tax
    ORDER BY pri_sal DESC);
    
    
    
SELECT b_score.sido,b_score.sigungu,b_score.burger_score,p_score.sido,p_score.sigungu,p_score.pri_sal
FROM (SELECT rownum num, sido, sigungu, burger_score
        FROM
        (SELECT sido, sigungu, ROUND((kfc+BURGERKING+mac)/lot,2)burger_score
        FROM
        (SELECT sido, sigungu,  
                NVL(SUM(DECODE(gb,'KFC',1)),0)kfc, NVL(SUM(DECODE(gb, '버거킹',1)),0) BURGERKING,
                NVL(SUM(DECODE(gb,'맥도날드',1)),0)mac, NVL(SUM(DECODE(gb, '롯데리아',1)),1) lot
        FROM fastfood
        WHERE gb IN('KFC','버거킹','맥도날드','롯데리아')
        GROUP BY sido, sigungu)
        ORDER BY burger_score DESC))b_score,
                                                (SELECT rownum num, sido, sigungu, pri_sal     
                                                FROM
                                                (SELECT sido, sigungu, ROUND(sal/people) pri_sal
                                                FROM tax
                                                ORDER BY pri_sal DESC))p_score
WHERE b_score.num = p_score.num;

--ROWNUM사용시 주의
--1.SELECT -> ORDER BY
--정렬된 결과에 ROWNUM을 적용하기 위해서는 INLINE-VIEW
--1번부터 순차적으로 조회가 되는 조건에 대해서만 WHERE절에서 기술이 가능
-- ROWNUM = 1(0)
-- ROWNUM = 2(X)
-- ROWNUM < 10(0)
-- RUWNUM > 10(X)

--empno컬럼은 motnull 제약조건이 있다. -intsrt시 반드시 값이 존재해야 정상적으로 입력된다.
--empno컬럼을 제외한 나머지 컬럼은 nullable이다.(null값이 저장될 수 있다.)
INSERT INTO emp(empno, ename, job)
VALUES (9999,'brown',NULL);

SELECT *
FROM emp;

INSERT INTO emp(ename, job)
VALUES('sally','SALESMAN');

--문자열 : '문자열'
--숫자 : 10
--날짜 : TO_DATE('20200206','YYYYMMDD'),SYSDATE

--emp테이블의 hiredate 컬럼은 date타입
--emp테이블의 8개의 컬럼에 값을 입력

DESC emp;
INSERT INTO emp VALUES(9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);

ROLLBACK;

--여러건의 데이터를 한번에 INSERT : 
--INSERT INTO 테이블명(컬럼명1, 컬럼명2....)
--SELECT ...
--FROM;


INSERT INTO emp 
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual
    UNION ALL
SELECT 9999,'brown','CLERK',NULL,TO_DATE('20200205','YYYYMMDD'), 1100, NULL,99
FROM dual;

--UPDATE 쿼리
--UPDATE 테이블명 SET 컬럼명1 = 갱신할 컬럼 값1,테이블명 컬럼명2 = 갱신할 컬럼 값2 ...
--WHERE행 제한 조건
--업데이트 쿼리 작성시 WHERE절이 존재하지 않으면 해당 테이블의 모든 행을 대상으로 업데이트가 일어난다
--UPDATE, DELETE 절에 WHERE절이 없으면 의도한게 맞는지 다시한번 확인한다

--WHERE절이 있다고 하더라도 해당 조건으로 해당 테이블을 SELECT 하는 쿼리를 작성하여 실행하면
--UPDATE 대상 행을 조회 할 수 있으므로 확인하고 실행하는 것도 사고 발생 방지에 도움이 된다.

--99번 부서번호를 갖는 부서 정보가 DEPT테이블에 있는 상황
INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM dept;

--99번 부서번호를 갖는 부서의 dname컬럼의 값을 '대덕IT',loc컬럼의 값을 '영민빌딩'으로 업데이트
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept
WHERE deptno = 99;

ROLLBACK;

--실수로 WHERE절을 기술하지 ㅇ낳을 경우
UPDATE dept SET dname = '대덕IT', loc ='영민빌딩';

--10 ==> SUBQUERY;
--SMITH, WARD가 속한 부서에 소속된 직원 정보
SELECT *
FROM emp
WHERE deptno IN(20,30);

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));

--UPDATE시에도 서브 쿼리 사용이 가능
INSERT INTO emp (empno,ename)VALUES(9999,'borwn');
--9999번 사원 deptno, jpb 정보를 SMITH 사원이 속한 부서정보, 담당 업무로 업데이트
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               Job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp;

ROLLBACK;

--DELETE SQL : 특정 행을 삭제
--DELETE [FROM] 테이블명
--WHERE 행 제한 조건
SELECT *
FROM dept;

--99번 부서 정보 삭제

DELETE dept
WHERE deptno = 99;

COMMIT;

--SUBQUERY를 통해서 특정 행을 제한하는 조건을 갖는 DELETE;
--매니저가 7698 사번인 직원을 삭제 하는 쿼리를 작성
DELETE emp
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

DELETE emp
WHERE empno IN(SELECT empno
               FROM emp
               WHERE mgr = 7698);
               
SELECT *
FROM emp;

ROLLBACK;