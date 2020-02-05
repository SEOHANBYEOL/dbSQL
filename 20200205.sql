--SUB4
--dept테이블에는 5건의 데이터가 존재
--emp테입르에는 14명의 직원이 있고, 직원은 하나의 부서 속해 있다.(deptno)
--부서 중 직원이 속해 있지 않은 부서 정보를 조회
--서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);         

--SUB5
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM product
WHERE PID NOT IN (SELECT PID
                FROM cycle
                WHERE cid = 1);
                
--SUB6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid=2);

 
 
--SUB7

SELECT *
FROM customer;
 
SELECT *
FROM product;
 
--ORACLE
SELECT customer.cid,customer.cnm,product.pid,product.pnm,a.day,a.cnt
FROM    
    (SELECT *
     FROM cycle
     WHERE cid = 1
     AND pid IN(SELECT pid
                FROM cycle
                WHERE cid=2))a, customer,product
WHERE a.cid = customer.cid
AND a.pid = product.pid;
                
                
--ANSI              
SELECT customer.cid,customer.cnm,product.pid,product.pnm,a.day,a.cnt
FROM    
    (SELECT *
     FROM cycle
     WHERE cid = 1
     AND pid IN(SELECT pid
                FROM cycle
                WHERE cid=2))a JOIN customer ON (a.cid = customer.cid)
                                JOIN product ON (a.pid = product.pid);
                                


--sub7
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN(SELECT pid
                FROM cycle
                WHERE cid=2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

--매니저가 존재하는 직원을 조회(king을 제외한 13명의 데이터가 조회)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자
--다른 연산자와 다르게 WHERE절에 컬럼을 기술하지 않는다
-- WHERE empno=7369
-- WHERE EXISTS (SELECT 'X'
--                FROM ...);
--매니저가 존재하는 직원을 EXIST연산자를 통해 조회
--매니저도 직원

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
                
                
--pt275
SELECT *
FROM cycle ;

SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle 
              WHERE cid = 1
              AND product.PID = cycle.PID);
              
--sub10
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle 
              WHERE cid = 1
              AND product.PID = cycle.PID);   
              
--집합연산
--합집합 : UNION - 중복제거(집합개념) /UNION ALL -중복을 제거하지 않음 (속도 향상)
--교집합 : INTERSECT (집합개념)
--차집합 : MINUS (집합개념)
--집합연산 공통사항
--두 집합의 컬럼의 개수, 타입이 일치 해야 한다.

--동일한 집합을 합집합하기 때문에 중복되는 데이터는 한번만 적용된다
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


--UNION ALL 연산자는 UNION 연산자와 다르게 중복을 허용한다.
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--INTERSECT(교집합) : 위, 아래 집합에서 값이 같은 행만 조회
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--MINUS(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--집합의 기술 순서가 영향이 가는 집합 연산자
--A UNION B =               B UNION A       ==>같음
--A UNION ALL B             B UNION ALL A   ==>같음(집합)
--A INTERSECT B             B INTERSECT A   ==>같음
--A MINUS B                 B MINUS A       ==>다름

--집합 연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다
SELECT 'X' fir, 'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

--정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION 

SELECT *
FROM dept
WHERE deptno IN (30,40)
ORDER BY deptno;



--햄버거 도시 발전지수;
SELECT *
FROM fastfood;

--시도, 시군구, 버거지수
--시도의 맥도날드+kfc+버거킹 /롯데리아
--버거지수 값이 높은 도시가 먼저 나오도록 정렬

    
    SELECT sido, sigungu, count(*)
    FROM fastfood
    WHERE gb = '맥도날드' OR gb = 'KFC' OR gb = '버거킹'
    GROUP BY sido, sigungu;
    
    SELECT sido, sigungu, count(*)
    FROM fastfood
    WHERE gb = '롯데리아'
    GROUP BY sido, sigungu;
    
    
    SELECT ff.sido,ff.sigungu,ff.ct,lot.sido, lot.sigungu,lot.ct, ff.ct/lot.ct
    FROM (SELECT sido, sigungu, count(*)ct
          FROM fastfood
          WHERE gb = '롯데리아'
          GROUP BY sido, sigungu)lot,
                                        (SELECT sido, sigungu, count(*)ct
                                        FROM fastfood
                                        WHERE gb = '맥도날드' OR gb = 'KFC' OR gb = '버거킹'
                                        GROUP BY sido, sigungu)ff
    WHERE ff.sido = lot.sido AND ff.sigungu = lot.sigungu;
    
   
  
    
    
    
    
    
    
    
    
    
    
        
        
