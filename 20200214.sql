--MERGE : SELECT 하고나서 데이터가 조회되면 UPDATE
--        SELECT 하고나서 데이터가 조회되지 않으면 INSERT

--SELECT + UPDATE / SELECT + INSERT ==> MERGE

--REPORT GROUP FUNCTION
--1. ROLLUP
--       - GROUP BY ROLLUP (컬럼1, 컬럼2)
--       - ROLLUP절에 기술한 컬럼을 오른쪽에서 하나씩 제거한 컬럼으로 SUBGROUP
--       - GROUP BY 컬럼1, 컬럼2
--         UNION
--         GROUP BY 컬럼1
--         UNION
--         GROUP BY
--2. CUBE
--3. GROUPING SETS

--GROUP_AD3

SELECT  deptno,job,SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

SELECT *
FROM emp;

--GROUP_AD4

SELECT dept.dname, emp.job, SUM(emp.sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job)
ORDER BY dept.DNAME, emp.job desc;


SELECT dname, job, sal
FROM
(SELECT  deptno,job,SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (deptno, job))a, dept b
WHERE a.deptno = b.deptno(+);




--GROUP_AD5
SELECT DECODE (GROUPING(dname),1, '총합', 0, dname) dname,
emp.job, SUM(emp.sal + NVL(comm,0)) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job)
ORDER BY dept.DNAME, emp.job desc;

--REPORT GROUP FUNCTION
--1. ROLLUP
--2. CUBE
--3. GROUPING SETS

--GROUPING SETS, ROLLUP >>>>>>>>>>>>>>>>>>CUBE

--GROUPING SETS
--순서와 관계없이 서브 그룹을 사용자가 직접 선언
--사용방법 : GROUP BY GROUPING SETS(col1, col2...)
--GROUP BY GROUPING SETS(col1, col2)
-->
--GROUP BY col1
--UNION ALL
--GROUP BY col2

--GROUPING SETS의 경우 컬럼 기술 순서가 결과에 영향을 미치지 않는다.
--ROLLUP은 컬럼 기술 순서가 결과에 영향을 미친다.

--GROUP BY BROUPING SETS( (col1, col2), col3, col4)
-->
--GROUP BY col1, col2
--UNION ALL
--GROUP BY col3
--UNION ALL
--GROUP BY col4;

--GROUP BY BROUPING SETS( (col1, col2), col3, col4)
--GROUP BY GROUPING SETS( col4, (col1, col2), col3)
--두개의 결과는 같다.


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);
-->
--GROUP BY job
--UNION ALL
--GROUP BY deptno

--job, deptno로 GROUP BY 한 결과와
--mgr로 GROUP BY 한 결과를 조회하는 SQL을 GROUPING SETS로 작성

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

--CUBE
--가능한 모든 조합으로 컬럼을 조합한 SUB GROUP을 생성한다.
--단 기술한 컬럼의 순서는 지킨다.

--EX : GROUP BY CUBE(col1, col2);
--(col1, col2) -->
--(null, col2) --> GROUP BY col2;
--(null, null) --> GROUP BY 전체
--(col1, null) --> GROUP BY col1
--(col1, col2) --> GROUP BY col1, col2;

--만약 컬럼 3개를 CUBE절에 기술한 경우 나올수 있는 가지수는 ??
--8개
SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);


--혼종
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, rollup(deptno), CUBE(mgr);

--GROUP BY job, deptno, mgr -->--GROUP BY job, deptno, mgr
--GROUP BY job, deptno --> --GROUP BY job, deptno
--GROUP BY job, null, mgr --> --GROUP BY job, mgr
--GROUP BY job, null, null -->-- GROUP BY job


--서브쿼리 UPDATE
--1. emp_test테이블 drop
--2. emp 테이블을 이용해서 emp_test 테이블 생성(모든 행에 대해 ctas)
--3. emp_test 테이블에 dname VARCHAR2(14)컬럼 추가
--4. emp_test.dname컬럼을 dept테이블을 이용해서 부서명을 업데이트

DROP TABLE emp_test;
CREATE TABLE emp_test AS SELECT * FROM emp;
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;


UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno);
                             
SELECT *
FROM emp_test;

commit;


DROP TABLE dept_test;
CREATE TABLE dept_test AS SELECT * FROM dept;
ALTER TABLE dept_test ADD (empcnt NUMBER);

SELECT * 
FROM dept_test;

UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*)
                                FROM emp_Test
                                WHERE EMP_TEST.DEPTNO = dept_test.deptno
                                GROUP BY deptno),0);

--sub_a2
--dept_test 테이블에 있는 부서중에 직원이 속하지 않은 부서 정보를 삭제
-- dept_test.empcnt 컬럼은 사용하지 않고
-- emp테이블을 이용하여 삭제
INSERT INTO dept_test VALUES(99, 'it1','daejeon',0);
INSERT INTO dept_test VALUES(98, 'it2','daejeon',0);

--직원이 속하지 않은 부서 정보 조회?
--직원이 있다 없다...?
--10번부서에 직원이 있다 없다?
SELECT *
FROM dept_test;




SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);
            
DELETE dept_test
WHERE 0 = (SELECT COUNT(*)
            FROM emp
            WHERE deptno = dept_test.deptno);

--sub_a3

SELECT * 
FROM emp_test
WHERE sal<(SELECT AVG(sal)
            FROM emp_test);
            
UPDATE emp_test a SET sal=sal+200 WHERE sal<(SELECT AVG(sal)
                                            FROM emp_test b
                                            WHERE a.deptno = b.deptno) ;
                                            
SELECT *
FROM EMP_TEST;

SELECT *
FROM emp;



--WITH 절
--하나의 쿼리에서 반복되는 SUBQUERY가 있을때 
--해당 SUBQUERY를 별도로 선언하여 재사용

--MAIN쿼리가 실행될 때 WITH절에 선언한 쿼리 블럭이 메모리에 임시적으로 저장
--MAIN 쿼리가 종료가 되면 메모리 해제 

--SUBQUERY 작성시에는 해당 SUBQUERY의 결과를 조회하기 위해서 I/O가 반복적으로 일어나지만
--WITH절을 통해 선언하면 한번만 SUBQUERY가 실행되고 그 결과를 메모리에 저장해놓고 재사용
--단, 하나의 쿼리에서 동일한SUBQUERY가 반복적으로 나오는거는 잘못 작성한 SQL일 확률이 높음

--WITH 쿼리블록이름 AS(
--  서브쿼리
--)

--SELECT *
--FROM 쿼리블록이름;


--직원의 부서별 급여 평균을 조회하는 쿼리블록을 WITH절을 통해 선언
WITH sal_avg_dept AS(
    SELECT deptno, ROUND(AVG(sal),2)sal
    FROM emp
    GROUP BY deptno
),
    dept_empcnt AS (
    SELECT deptno, count(*) empcnt
    FROM emp
    GROUP BY deptno)
    
SELECT *
FROM sal_avg_dept a, dept_empcnt b
WHERE a.deptno = b.deptno;


--WITH절을 이용한 테스트 테이블 작성
WITH temp AS(
    SELECT sysdate -1 FROM dual UNION ALL
    SELECT sysdate -2 FROM dual UNION ALL
    SELECT sysdate -3 FROM dual)
SELECT *
FROM temp;

--달력만들기;
--CONNECT BY LEVEL <[=] 정수
--해당 테이블의 행을 정수만큼 복제하고 , 복제된 해을 구별하기 위해서 LEVEL 부여 
--LEVEL은 1부터 시작

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <=10;


SELECT dept.*, level
FROM dept
CONNECT BY LEVEL <=5;

--2020년 2월의 달력을 생성
--1. :dt = 202002, 202003
--2. 달력
--일 월 화 수 목 금 토 
SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD')
FROM dual;


SELECT TO_DATE('202002','YYYYMM')+ (level-1),
        TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D')
       
FROM DUAL
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');



SELECT TO_DATE('202002','YYYYMM')+ (level-1),
        TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),1,TO_DATE('202002','YYYYMM')+ (level-1))s,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),2,TO_DATE('202002','YYYYMM')+ (level-1))m,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),3,TO_DATE('202002','YYYYMM')+ (level-1))t,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),4,TO_DATE('202002','YYYYMM')+ (level-1))w,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),5,TO_DATE('202002','YYYYMM')+ (level-1))t2,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),6,TO_DATE('202002','YYYYMM')+ (level-1))f,
       DECODE(TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL-1), 'D'),7,TO_DATE('202002','YYYYMM')+ (level-1))s2
       
FROM DUAL
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');
