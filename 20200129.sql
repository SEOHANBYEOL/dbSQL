SELECT  TO_DATE('19/12/31','YY/MM/DD') LASTDAY, 
        TO_DATE('19/12/31','YY/MM/DD')-5 LASTDAY_BEFORES, 
        SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
FROM dual;

--DATE : TO_DATE 문자열 -> 날짜(DATE)
--       TO_CHAR 날짜 ->문자열(날짜 포멧 지정)
-- JAVA에서는 날짜 포멧의 대소문자를 가린다 ( MM / mm -> 월, 분)
-- 주간일자 (1~7) 일요일 1, 월요일 2... 토요일 7
-- 주차 IW : ISO 표준  - 해당주의 목요일의 기준으로 주차를 산정
--          2019/12/31(화) -> 2020/01/02(목) --> 그렇기 때문에 1주차로 산정

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE, 'D'),
       TO_CHAR(SYSDATE, 'IW'),
       TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'), 'IW')
FROM dual;


--emp 테이블의 hiredate(입사일자)컬럼의 년월일 시:분:초
SELECT ename, hiredate,
       TO_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(hiredate + 1, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(hiredate + 1/24, 'YYYY-MM-DD HH24:MI:SS'),
       TO_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:SS')
FROM emp;

--fn2 ,PT 133
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')DT_DASH,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS')DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY')DT_DD_MM_YYYY
FROM dual;


--MONTHS_BETWEEN(DATE, DATE)
--인자로 들어온 두 날짜 사이의 개월수를 리턴
SELECT ename, hiredate,
        MONTHS_BETWEEN(sysdate, hiredate), 
        MONTHS_BETWEEN(TO_DATE('2020-01-17','YYYY-MM-DD'), hiredate)
       
FROM emp
WHERE ename='SMITH';

-- ADD_MONTHS(DATE, 정수-가감 할 개월수)
SELECT ADD_MONTHS(SYSDATE, 5),
        ADD_MONTHS(SYSDATE, -5)
FROM dual;

-- NEXT_DAY(DATE, 주간일자), ex : NEXT_DAY(SYSDATE, 5) --> SYSDATE이후 처음 등장하는 주간일자 5에 해당하는 일자
                        --       SYSDATE 2020/01/29(수) 이후 처음 등장하는 5(목)요일 -> 2020/01/30(목)
                    
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

-- LAST_DAY(DATE) DATE가 속한 월의 마지막 일자를 리턴
SELECT LAST_DAY(SYSDATE)
FROM dual;

--LAST_DAY를 통해 인자로 들어온 date가 속한 월의 마지막 일자를 구할 수 있는데 
--date의 첫번째 일자는 어떻게 구할까?
SELECT SYSDATE,
       LAST_DAY(SYSDATE),
       --TRUNC(SYSDATE, 'MM'),
       TO_DATE('01','DD'),
       ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM dual;

--hiredate 값을 이용하여 해당 월의 첫번째 일자로 표현

SELECT ename, hiredate, ADD_MONTHS(LAST_DAY(hiredate)+1,-1)
FROM emp;

--empno는 NUMBER 타입, 인자는 무자열
-- 타입이 맞지 않기 때문에 묵시적 형변환이 일어남.
-- 테이블 칼럼의 타입에 맞게 올바른 인자 값을 주는게 중요
SELECT *
FROM emp
WHERE empno = '7369';

--hiredate의 경우 DATE타입, 인자는 문자열로 주어졌기 대무에 묵시적 형변환이 발생
-- 날짜 문자열 보다 날짜 타입으로 명시적으로 기술하는 것이 좋음
SELECT *
FROM emp
WHERE hiredate= TO_DATE('1980/12/17','YYYY/MM/DD');

--묵시적으로 형변환이 됬지만 형을 고려하여 SQL을 작성할것.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = '7369';

--실행계획 (위에서 아래로 읽는다, 그런데 자식이있다면(들여쓰기된부분) 자식부터 읽는다.
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM table(dbms_xplan.display);


-- 숫자를 문자열로 변경하는 경우 : 포맷
-- 천단위 구분자
-- 1000이라는 숫자를
-- 한국 : 1,000.50 
-- 독일 : 1.000,50

-- emp sal(NUMBER 타입) 컬럼을 포맷팅
-- 9 : 숫자
-- 0 : 강제 자리 맞춤(0으로표기)
-- L : 통화 단뒤

SELECT ename, sal, TO_CHAR(sal, '9,999'),TO_CHAR(sal, '009,999'), TO_CHAR(sal, '0,999'), TO_CHAR(sal, 'L0,999')
FROM emp;


-- NULL에 대한 연산의 결과는 항상 NULL
-- emp 테이블의 sal컬럼에는 null데이터가 존재하지 않음(14건의 데이터에 대해)
-- emp 테이블의 comm컬럼에는 null데이터가 존재(14건의 데이터에 대해)
-- sal + comm --> comm인 null인 행에 대해서는 결과 null로 나온다.
-- 요구사항이 comm이 null이면 sal 컬럼의 값만 조회
-- 요구사항이 충족 시키지 못한다 -> SW에서는 [결함]

-- NVL(타켓, 대체값)
-- 타겟의 값이 NULL이면 대체값을 반환하고
-- 타겟의 값이 NULL이 아니면 타겟 값을 반환
-- if( 타겟 == null )
-- return 대체값
-- else
-- return  타겟;
SELECT ename, sal, comm, 
        sal+comm, 
        NVL(comm,0), 
        NVL(comm,0)+sal,
        NVL(sal+comm, 0)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(expr1 != null)
--  return expr2;
-- else
--  return expr3;

SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

-- NULLIF(expr1, expr2)
-- if(expr1 == expr2)
--    return null;
-- else
--    return expr1;

SELECT ename, sal, comm, NULLIF(sal,1250) nullif --sal 1250인 사원은 null을 리턴, 1250이 아닌 사람은 sal를 리턴
FROM emp;

-- 가변인자
-- COALESCE 인자중에 가장 처음으로 등장하는 NULL이 
-- 아닌 인자를 반환

-- COALESCE(expr1, expr2...)
-- if(expr1 != null)
--  return expr1;
-- else
--  return COALESCE(expr2, expr3...);

-- COALESCE(comm, sal) : comm이 null이 아니면 comm
--                       comm이 null이면 sal(단, sal컬럼의 값이 null이 아닐때)

SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

--fn4
SELECT empno,ename,mgr,
NVL(mgr,9999),
NVL2(mgr,mgr,9999),
COALESCE(mgr,9999)
FROM emp;


--fn5 pt160
SELECT userid, usernm, reg_dt, NVL(reg_dt,sysdate)
FROM users
WHERE userid !='brown';

-- CONDITION : 조건절
-- CASE : JAVA의 if -else if - else 
-- CASE
--     WHEN 조건 THEN 리턴값
--     WHEN 조건2 THEN 리턴값1
--     ELSE 기본값
-- END
-- emp테이블에서 job컬럼의 값이 SALESMAN 이면 SAL * 1.05 리턴
--                           MANAGER 이면 SAL * 1.1 리턴
--                           KING 이면 SAL *1.2리턴
--                           그밖의 사람들은 SAL을 리턴

SELECT ename, job, sal,
    CASE
        WHEN job = 'SALESMAN' THEN sal*1.05
        WHEN job = 'MANAGER' THEN sal*1.1
        WHEN job = 'PRESIDENT' THEN sal*1.2
        ELSE sal
    END bonus_sal
FROM emp;

-- DECODE 함수 : CASE절과 유사
-- (다른점 CASE절  : WHEN절에 조건비교가 자유롭다
--        DECODE함수 : 하나의 값에 대해서 = 비교만 허용
-- DECODE 함수 : 가변인자 (인자의 개수가 상황에 따라서 늘어날 수가 있음)
-- DECODE(col|expr, 첫째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을 경우 반환 값,
--                  첫번째 인자와 비교할 값2, 첫번째 인자와 네번째 인자가 같을 경우 반환 값 ...
--                  option - else 최종적으로 반환할 기본값

SELECT ename, job, sal,
    DECODE(job,'SALESMAN',sal*1.05,
               'MANAGER', sal*1.1,
               'PRESIDENT', sal*1.2, sal) bonus_sal
FROM emp;

-- emp테이블에서 job컬럼의 값이 SALESMAN 이면서 sal가 1400보다 크면 SAL * 1.05 리턴
--                                          sal가 1400보다 작으면 SAL * 1.1리턴
--                           MANAGER 이면 SAL * 1.1 리턴
--                           KING 이면 SAL *1.2리턴
--                           그밖의 사람들은 SAL을 리턴

--1. CASE만

SELECT ename, job, sal,
    CASE
        WHEN job='SALESMAN' AND sal >= 1400 THEN sal*1.05
        WHEN job='SALESMAN' AND sal <= 1400 THEN sal*1.1
        WHEN job='MANAGER' THEN sal*1.1
        WHEN job='PRESIDENT' THEN sal*1.2
        ELSE sal
    END bonus_sal
FROM emp;

-- emp테이블에서 job컬럼의 값이 SALESMAN 이면서 sal가 1400보다 크면 SAL * 1.05 리턴
--                                          sal가 1400보다 작으면 SAL * 1.1리턴
--                           MANAGER 이면 SAL * 1.1 리턴
--                           KING 이면 SAL *1.2리턴
--                           그밖의 사람들은 SAL을 리턴
-- 2. DECODE, CASE 혼용(과제)

