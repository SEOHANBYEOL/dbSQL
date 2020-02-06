SELECT *
FROM emp
WHERE deptno IN(10,30)
AND sal>1500
ORDER BY ename DESC;

--ROWNUM : 행번호를 나타내주는 컬럼
SELECT ROWNUM, empno,ename
FROM emp
WHERE deptno IN(10,30)
AND sal>1500
ORDER BY ename DESC;


--ROWNUM은 WHERE절에서도 사용 가능
--동작하는거 : ROWNUM=1 / ROWNUM <=2            ->ROWNUM=1 / ROWNUM <=n
--동작하지 않는것 : ROWNUM =2; / ROWNUM >= 2     ->ROWNUM =n(n은 1이 아닌 정수); / ROWNUM >= n(n은 1이 아닌 정수)
--ROWNUM 이미 읽은 데이터에다가 순서를 부여
    -- 유의점 : --읽지 않은 상태의 값들, ROWNUM이 부여하지 않은 행은 조회할 수 가 없다.
               --ORDER BY절은 SELECT절 이후에 실행
--사용용도 : 페이징 처리
--테이블에 있는 모든 행을 조회하는것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다.
-- 페이징 처리시 고려사항 : 1 페이지 해당 건수, 정렬 기준
--emp 테이블 총 row 건수 : 14
--다섯건만 조회 
-- 1pg : 1-5
-- 2pg : 6-10
-- 3pg : 11-15

SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;

--정렬된 결과에 ROWNUM을 부여 하기 위해서는 INLINE VIEW를 사용한다.
--정렬 -> ROWNUM부여

--SELECT *를 기술할 경우 다른 EXPRESSION을 표기 하기 위해서 테이블명.* 테이블명칭.*로 표기한다.

SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--ROWNUM ->rn
--1pg : rn 1-5
--2pg : rn 6-10
--3pg : rn 11-15
--npg : rn (page-1)*pageSize+1 - page*pageSize

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename
         FROM emp
         ORDER BY ename)a)
WHERE rn>=6 AND rn<=10;


SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename
         FROM emp
         ORDER BY ename)a)
WHERE rn BETWEEN (1-1)*5 +1 AND 1*5;


--pg105_row_1
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename
         FROM emp)a)
WHERE rn BETWEEN 1 AND 10;


--row_2
SELECT *
FROM
    (SELECT ROWNUM rn, empno, ename
     FROM emp)
WHERE rn BETWEEN 11 AND 20;



--row_3
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT empno, ename
          FROM emp
          ORDER BY ename)a)
WHERE rn BETWEEN (:page-1) * :pageSize + 1 AND :page * :pageSize;


SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT empno, ename
          FROM emp
          ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--DUAL 테이블 (데이터와 관계없이 함수를 테스트 해볼 목적으로 사용)
SELECT *
FROM DUAL;

SELECT LENGTH('TEST')
FROM DUAL;

--문자열의 대소문자 : LOWER UPPER INITCAP
SELECT LOWER('Hello World'),UPPER('Hello World'),INITCAP('Hello World')
FROM DUAL;

SELECT LOWER(ename),UPPER(ename),INITCAP(ename)
FROM emp;

SELECT *
FROM emp
WHERE ename = UPPER(:ename);


-- 함수 : WHERE 절에서도 사용이가능하다.
-- 사원이름이 SMITH인 사원만 조회
-- SQL 작성시 아래 형태는 지양 해야한다.
-- 테이블의 컬럼을 가공하지 않은 상태로 SQL을 작성한다.
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;

--
SELECT CONCAT('Hello', 'World') CONCAT,
       SUBSTR('Hello, World', 1, 5) SUB,
       LENGTH('Hello, World')LEN,
       INSTR('Hello, World', 'o') INS,
       INSTR('Hello, World', 'o', 6) INS2,
       LPAD('Hello, World', 15, '*') LP,
       RPAD('Hello, World', 15, '*') RP,
       REPLACE('Hello, World', 'H', 'T') REP,
       TRIM('  Hello, World  ')TR, --공백을 제거
       TRIM('d' FROM 'Hello, World')TR --공백이 아닌 소문자 d제거
FROM DUAL;

-- 숫자조작
-- ROUND 반올림 10.6을 소숫점 첫번째 자리에서 반올림 -> 11 
-- TRUNC 버림 10.6 -> 10 
-- ROUND, TRUNC : 인자 두개 
-- MOD 나눗셈의 나머지 (몫이 아니라 나누기 연산을 한 나머지 값) (13/5 -> 몫은 2, 나머지는 3)

SELECT ROUND(105.54, 1),
       ROUND(105.55, 1),
       ROUND(105.55, 0),  -- 반올림 결과가 정수부분만 (소수점 첫번째 자리에서 반올림)
       ROUND(105.55, -1), -- 반올림 결과가 십의 자리까지
       ROUND(105.55)      -- 두번째 인자를 입력하디 않은 경우 0이 적용
FROM DUAL;

SELECT TRUNC(105.54, 1), -- 소수점 첫번째 자리까지 나오도록, 소수점 둘째자리에서 절삭
       TRUNC(105.55, 1),  -- 소수점 첫번째 자리까지 나오도록, 소수점 둘째자리에서 절삭
       TRUNC(105.55, 0), -- 절삭의 결과가 정수부분(일의자리)까지 나오게 , 소수점 첫번째 자리에서 절삭
       TRUNC(105.55, -1) TR, -- 절삭의 결과가 십의자리까지 나오게, 일의자리에서 절삭 
       TRUNC(105.55)     --두번째 인자를 입력하디 않은 경우 0이 적용
FROM DUAL;

--EMP테이블에서 사원의 급여(sal)를 1000으로 나누었을때 몫 --몫을 구해보세요.
SELECT ename, sal, TRUNC(sal/1000), MOD(sal,1000)--mod의 결과는 divisor보다 항상 작다,(0~999)
FROM emp;


DESC emp;

--년도두자리/월두자리/일자두자리
SELECT ename, hiredate --도구 ->환경설정->데이터베이스 -> NLS 설정으로 날짜형식변경가능.
FROM emp;

--SYSDATE : 현재 오라클 서버의 현재날짜, 시간정보를 담은 DATE값을 반환
-- DATE + 정수 : 일자 연산 (정수 1은 하루) (1/24 -> 한시간)
-- 숫자 표기 : 숫자 --> 100
-- 문자 표기 : 싱글 쿼테이션 '문자열'
-- 날짜표기 : TO_DATE('문자열 날짜 값', '문자열 날짜 값의 표기 형식') -> TO_DATE('2020-01-28,'YYYY-MM-DD')

SELECT SYSDATE+5
FROM DUAL;

SELECT SYSDATE, SYSDATE+1/24
FROM DUAL;

       
-------------------PT 129 fn1 과제------------------
SELECT TO_DATE('19/12/31','YY/MM/DD') LASTDAY, TO_DATE('19/12/31','YY/MM/DD')-5 LASTDAY_BEFORES, SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
FROM dual;