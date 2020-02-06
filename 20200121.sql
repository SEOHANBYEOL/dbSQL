
--prod 테이블의 모든 칼럼의 자료 조회
SELECT * 
FROM prod;

--prod 테이블에서 prod_id, prod_name 컬럼의 자료만 조회
SELECT prod_id, prod_name
FROM prod;

--lprod 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요.
SELECT *
FROM lprod;
--buyer테이블에서 buyer_id, buyer_name 칼럼만 조회하는 쿼리를 작성하세요.
SELECT buyer_id, buyer_name
FROM buyer;
--cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요.
SELECT *
FROM cart;
--member 테이블에서 mem_id, mem_pass, mem_name 칼럼만 조회하는 쿼리를 작성하세요.
SELECT mem_id, mem_pass, mem_name
FROM member;

--users 테이블 조회
SELECT *
FROM users;

--테이블에 어떤 컬럼이 있는지 확인하는 방법
--1. SELECT *
--2. TOOL의 기능 (사용자-TABLES)
--3. DESC 테이블명(DESC - DESCRIBE)
DESC users;

-- users테이블에서 userid, usernm, reg_dt 조회
-- 날짜연산 (reg_dt 컬럼은 date정보를 담을 수 있는 타입)
-- 날짜 칼럼 +(더하기연산)
-- 수학적인 사치경ㄴ산이 아닌것들(5+5)
-- SQL에서 정의된 날짜 연산 : 
-- 날짜 + 정수 = 날짜에서 정수를 일자로 취급하여 더한 날짜가 된다.(2019/01/28+5 =2019/02/02)
-- null : 값을 모르는 상태
-- null에 대한 연산 결과는 항상 null

SELECT userid AS u_id, usernm, reg_dt, reg_dt+5 AS reg_dt_after_5day
FROM users;

-- 실습문제PT56
SELECT prod_id AS id, prod_name AS name
FROM prod;
--
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;
--
SELECT buyer_id AS 바이어아이디, buyer_name AS 이름
FROM buyer;

-- 문자열 결합
-- 자바 언어에서 문자열 결합 : + ("HELLO"+"WORLD")
-- SQL에서는 : || ('HELLO'||'WORLD')
-- SQL에서는 : concat('Hello', 'world')

--userid, usernm 컬럼을 결합, 별칭은 id_name
SELECT userid || usernm AS id_name,
        CONCAT(userid, usernm) AS concat_id_name
FROM users;

-- 변수, 상수
-- int a = 5; Stirng msg = "helloworld";
-- System.out.println(msg); //변수를 이용한 출력
-- System.out.println("helloworld"); //상수를 이용한 출력

-- SQL에서의 변수는 없음(컬럼이 비슷한 역할, PL/SQL 변수 개념 존재)
-- SQL에서 문자열 상수는 싱글 쿼테이션으로 표현
-- "Hello, World"-->'Hello, World'
-- 문자열 상수와 컬럼간의 결합
--user id : brown
--user id : cony
--공백이나 대소문자 구분시 더블 쿼테이션으로 표현
SELECT 'user id : '|| userid AS "user id" 
FROM users;

--pt59
SELECT 'SELECT * FROM '|| table_name||';' AS query
FROM user_tables;

--CONCAT
SELECT CONCAT('SELECT * FORM ',CONCAT(table_name,';')) AS query
FROM user_tables;

-- SQL에서는 = (equal의 의미) JAVA에서는 =(대입의 의미)
-- SQL에서는 대입의 개념이 없다. (PL/SQL 에는 존재)

-- users의 테이블의 모든 행에 대해서 조회
-- users에는 5건의 데이터가 존재
SELECT * 
FROM users;

-- WHERE절 : 테이블에서 데이터를 조회할 때 조건에 맞는 행만 조회
-- EX : userid 칼럼의 값이 brown인 행만 조회
-- brown, 'brown' 구분
-- 컬럼, 문자열 상수
SELECT * 
FROM users
WHERE userid = 'brown';

-- uwerid가 brown이 아닌 행만 조회
SELECT *
FROM users
WHERE userid != 'brown'; -- !=, <>

-- emp 테이블에 존재하는 칼럼을 확인 해보세요
DESC emp;

--emp 테이블에서 ename 컬럼 값이 JONES인 행만 조회
--  * SQL KEY WORD는 대소문자를 가리지 않지만 
-- 컬럼의 값이나, 문자열 상수는 대소문자를 가린다.
-- 'JONES','jones'는 값이 다른 상수.
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --employee

DESC emp;

--emp 테이블에서 deptno(부서번호)가 30보다 크거나 같은 사원들만 조회해보세요.
SELECT *
FROM emp
WHERE deptno >= 30;

-- 문자열 : '문자열'
-- 숫자 : 50
-- 날짜 :  ??? -- > 함수랑 문자열 결합하여 표현
--          문자열만 이용하여 표현 가능(권장하지 않음)
--          국가별로 날짜 표기 방법
--          한국 : 년도4자리-월2자리-일2자리 
--          미국 : 월2자리-일2자리-년도4자리

SELECT *
FROM emp;

-- 입사일자가 1980년 12월 17일 직원만 조회
SELECT *
FROM emp
WHERE hiredate = '80/12/17';
-- 나라마다 표기하는 방법이 다르기때문에 위험한다 따라서 아래처럼 구현한다.
-- 문자열을 date 타입으로 변경하는 함수 사용 (TO_DATE)
-- TO_DATE(날짜형식 문자열, 첫번째 인자의 형식)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-- 범위연산
SELECT *
FROM emp;

-- sal컬럼의 값이 1000에서 2000사이인 사람
SELECT *
FROM emp
WHERE sal>=1000
AND sal<=2000
AND deptno = 30;

-- 범위연산자를 부등호 대신에 BETWEEN AND 연산자로 대체
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


--PT69
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD')AND TO_DATE('19830101','YYYYMMDD');


