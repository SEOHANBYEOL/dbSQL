--pt 69
-- where절에 기술하는 조건의 순서는 조회 결과에 영향을 미치지 않는다.
-- sql은 집합의 개념을 알고 있다.(절차 개념이 없다.)
-- 테이블에는 순서가 보장되지 않는다.(SELECT 결과가 순서가 다르더라도 값이 동일하면 정답으로 간주한다.)
-- 정렬에 대한 부분은 ORDER BY라는 개념을 적용한다.

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');

-- IN 연산자
-- 특정 집합에 포함되는지 여부를 확인
-- 부서번호가 10번 혹은(OR) 20번에 속하는 직원 소환
SELECT ename, deptno
FROM emp
WHERE deptno IN (10, 20);

SELECT ename, deptno
FROM emp
WHERE deptno = 10 
OR deptno = 20;

--emp테이블에서 사원이름이 SMITH, JONES인 직원만 조회 (empno, ename, deptno)
--OR 이랑 AND 잘 구분!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';


SELECT *
FROM users;

--pt71
SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid IN('brown','cony','sally');

--문자열 매칭 연산자 : LIKE, %, _
--위에서 연습한 조건은 문자열 일치에 대해서 다룸
--이름이 BR로 시작하는 사람만 조회
--이름이 R문자열이 들어가는 사람만 조회

--사원 이름이 S로 시작하는 사원 조회
-- % 어떤 문자열(한글자, 글자 없을수도 있고, 여러 문자열이 올수도 있다.)
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--글자수 제한한 패턴 매칭
--_정확히 한문자
--직원 이름이 S로 시작하고 이름의 전체 길이가 5글자인 직원
SELECT *
FROM emp
WHERE ename LIKE 'S____';

--사원 이름에 S글자가 들어가는 사원조회
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--PT73
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE'신%';

--PT74
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

-- NULL 비교 연산(IS)
-- comm 컬럼의 값이 null인 데이터를 조회 (WHERE comm IS NULL)
SELECT *
FROM emp
WHERE comm IS NULL;

-- PT76
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE comm >=0;

--사원의 관리자가 7698, 7839 그리고 NULL이 아닌 직원만 조회
--**NOT IN 연산자에서는 NULL을 포함 시키면 안된다!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839)
AND mgr IS NOT NULL;

--PT80 _7
SELECT *
FROM emp
WHERE job ='SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT81_8
SELECT *
FROM emp
WHERE DEPTNO != 10
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT82_9
SELECT *
FROM emp
WHERE DEPTNO NOT IN (10)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT83_10
SELECT *
FROM emp
WHERE deptno IN (20,30)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT84_11
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT85_12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

--PT86_13
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR (empno >=7800 AND empno <7900);


-- 연산자 우선순위
-- */ 연산자가 +,-보다 우선순위가 높다
-- 우선순위 변경 : ()
-- AND > OR

-- emp 테이블에서 사원 이름이 SMITH 이거나 
--               사원 이름이 ALLEN 이면서 담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEN' AND job ='SALESMAN');

-- 사원 이름이 SMITH이거나 ALLEN이면서 
-- 담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--PT90 WHERE14
SELECT *
FROM emp
WHERE job='SALESMAN' 
OR ((empno >=7800 AND empno <7900) AND hiredate >= TO_DATE('19810601','YYYYMMDD'));

-- 정렬
-- SELECT *
-- FROM table
-- [WHERE]
-- ORDER BY {컬럼|별칭|컬럼인덱스 [ASC || DESC], ...}

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 오름 차순 정렬한 결과를 조회하세요.
SELECT *
FROM emp
ORDER BY ename;

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 내림 차순 정렬한 결과를 조회하세요.

SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE
--ORDER BY ename DESC; -- DESC : DESCENDING (내림)

--emp 테이블에서 사원 정보를 ename 컬럼으로 내림차순, ename값이 같을경우 mgr 컬럼으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename DESC, mgr;

-- 정렬시 별칭을 사용
SELECT empno, ename AS nm
FROM emp
ORDER BY nm;

SELECT empno, ename AS nm, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

-- 컬럼 인덱스로 정렬
-- java array[0]
-- SQL COLUMN INDEX : 1부터 시작
SELECT empno, ename AS nm, sal*12 AS year_sal
FROM emp
ORDER BY 3;


--PT95 ORDERBTY 1
SELECT *
FROM dept;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--PT96
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm !=0
ORDER BY comm DESC, empno;

--PT97
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;


