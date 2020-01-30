--COND1
 SELECT empno,ename,CASE 
                        WHEN deptno = 10 THEN 'ACCOUNTING'
                        WHEN deptno = 20 THEN 'RESEARCH'
                        WHEN deptno = 30 THEN 'SALES'
                        WHEN deptno = 40 THEN 'OPERATIONS'
                        ELSE 'DDIT'
                    END DNAME                         
 FROM emp;
 
 
SELECT empno,ename,
        DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT')dname
FROM emp;


--COND2
SELECT empno, ename, hiredate
FROM emp;

--올해년도가 짝수인지 홀수인지 확인
--DATE 타입 -> 문자열(여러가지 포맷, YYYY-MM-DD HH24:MI:SS)
SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
FROM dual;

--짝수 -> 2로 나누었을때 나머지 0
--홀수 -> 2로 나누었을때 나머지 1
SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
FROM dual;

SELECT empno, ename, hiredate,
    CASE
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)=0 AND MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=0 THEN '건강검진 대상자'
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)=1 AND MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=1 THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
    END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
    CASE
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)= MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) THEN '건강검진 대상자'
        ELSE '건강검진 비대상자'
    END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
    DECODE(MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2) , MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2), '건강검진 대상자','건강검진 비대상자')
    CONTACT_TO_DOCTOR
FROM emp;

--COND3 실습과제

SELECT *
FROM users;


SELECT userid, usernm, alias, reg_dt, 
        DECODE(MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2), MOD(TO_NUMBER(TO_CHAR(reg_dt,'YYYY')),2),'건강검진 대상자','건강검진 비대상자')
        CONTACTTODOCTOR
FROM users;







SELECT *
FROM emp;


--GROUP BY 행을 묶을 기준
--부서번호 같은 ROW끼리 묶는 경우 : GROUP BY deptno
--담당업무가 같은 ROW끼리 묶는 경우 : GROPU BY job
--MGR가 같고 담당업무가 같은 ROW끼리 묶는 경우 : GROUP BY mgr, job


-- 그룹 함수의 종류
-- SUM : 합계
-- COUNT : 갯수 - NULL값이 아닌 ROW의 갯수
-- MAX : 최댓값
-- MIN : 최소값
-- AVG : 평균

-- 그룹함수의 특징
-- 해당 컬럼에 Null값을 갖는 ROW가 존재할 경우 해당 값은 무시하고 계산한다 (NULL 연산의 결과는 null)

-- 그룹함수의 주의점
-- GROUP BY 절에 나온 컬럼이외의 다른컬럼이 SELECT절에 표현되면 에러

--부서별 급여 합
SELECT deptno, ename, 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno, ename;




-- GROUP BY 절이 없는 상태에서 그룹함수를 사용한 경우
-- 전체행을 하나의 행으로 묶는다
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(comm), -- comm컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(*)--몇건의 데이터가 있는지
FROM emp;


--GROUP BY 기준이 empno이면 결과수가 몇건?
--그룹화와 관련없는 임의의 문자열, 함수, 숫자등은 SELECT절에 나오는것이 가능
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(comm), -- comm컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(*)--몇건의 데이터가 있는지
FROM emp
GROUP BY empno;


SELECT  1,SYSDATE,'ACCOUNTING',
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(comm), -- comm컬럼의 값이 null 이 아닌 row의 갯수
        COUNT(*)--몇건의 데이터가 있는지
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION의 경우 WHERE절에서 사용하는것이 가능하나
-- MULTI ROW FUNCTION(GROUP FUNCTION)의 경우 WHERE절에서 사용하는 것이 불가능하고
-- HAVING 절에서 조건을 기술한다.

-- 부서별 급여 합 조회, 단 급여합이 9000이상인 row만 조회
-- deptno, 급여합
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) >9000;

--grp1
SELECT MAX(sal)max_sal, MIN(sal)min_sal, ROUND(AVG(sal),2)avg_sal,SUM(sal)sum_sal,COUNT(sal)count_sal,COUNT(mgr)count_mgr,COUNT(*)count_all
FROM emp;

SELECT
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
    END dname, MAX(sal)max_sal, MIN(sal)min_sal, ROUND(AVG(sal),2)avg_sal,SUM(sal)sum_sal,COUNT(sal)count_sal,COUNT(mgr)count_mgr,COUNT(*)count_all
FROM emp
GROUP BY deptno
ORDER BY deptno;

--grp4
--ORACLE 9i 이전까지는 GROUP BY 절에 기술한 컬럼으로 정렬을 보장
--ORACLE 10G 이후부터는 GROUP BY 절에 기술한 컬럼으로 정렬을 보장하지 않는다(GROUP BY 연산시 속도 UP)
SELECT TO_CHAR(hiredate,'YYYYMM')hire_yyyymm, COUNT(hiredate)cnt 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');


--grp5
SELECT TO_CHAR(hiredate,'YYYY')hire_yyyymm, COUNT(hiredate)cnt 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');
--ORDER BY TO_CHAR(hiredate,'YYYY');


--grp6
SELECT COUNT(deptno)cnt
FROM dept;


--grp7
SELECT COUNT(*) cnt
    FROM (SELECT deptno 
            FROM emp
            GROUP BY deptno);





