SELECT * 
FROM customer;

SELECT * 
FROM product;

SELECT * 
FROM cycle;

SELECT * 
FROM daily;

SELECT * 
FROM batch;

--04
SELECT customer.CID, customer.CNM, cycle.PID, cycle.DAY, CYCLE.CNT
FROM customer, cycle
WHERE customer.cid = cycle.CID AND customer.cnm != 'cony';

--05

SELECT customer.CID, customer.CNM, cycle.PID, product.PNM, cycle.DAY, cycle.CNT
FROM customer, cycle, product
WHERE CUSTOMER.CID = CYCLE.CID AND cycle.pid = product.pid AND customer.cnm != 'cony';

--06!!!!아!!!!!count가 아니고 sum인데................휴

SELECT a.cid, a.cnm, a.pid, a.pnm, sum(a.cnt)
FROM
    (SELECT customer.CID, customer.CNM, cycle.PID, product.PNM, cycle.CNT
    FROM customer, cycle, product
    WHERE CUSTOMER.CID = CYCLE.CID AND cycle.pid = product.pid)a
GROUP BY a.cid,a.CNM, a.pid,a.pnm ;



SELECT customer.CID, customer.CNM, cycle.PID, product.PNM, sum(cycle.CNT)
FROM customer, cycle, product
WHERE CUSTOMER.CID = CYCLE.CID AND cycle.pid = product.pid
GROUP BY CUSTOMER.cid,CUSTOMER.CNM, cycle.pid,product.pnm, cycle.cnt;
    

--07과제
--hr(08~13)

-- 해당 오라클 서버에 등록된 사용자 계정 활성화
-- SELECT *
-- FROM dba_users;

--HR계정의 비밀번호를 JAVA로 초기화
--ALTER USER HR IDENTIFIED BY java;
--ALTER USER HR ACCOUNT UNLOCK;

--OUTER JOIN
--두 테이블을 조인할때 연결 조건을 만족 시키지 못하는 데이터를 기준으로 
-- 지정한 테이블의 데이터만이라도 조회 되게끔 하는 조인 방식;

--연결조건 : e.mgr = m.empno : KING의 MGR은 NULL이기 때문에 조인에 실패한다.
--EMP 테이블의 데이터는 총 14건이지만, 아래와 같은 쿼리에서는 결과가 13건이 된다.(1건 조인실패)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER조인
--1. JOIN에 실패하더라도 조회가 될 테이블을 선정(매니저 정보가 없어도 사원정보는 나오게끔)

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

--ORACLE OUTER JOIN
--데이터가 없는 쪽의 테이블 컬럼 뒤에(+) 기호를 붙여준다.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--위의 sql을 ANSI sql(outer join)으로 변경해보세요.
--매니저의 부서번호가 10번인 직원만 조회.
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND m.deptno = 10); 

--아래 LEFT OUTER 조인은 실질적으로 OUTER조인이 아니다
--아래 INNER조인과 결과가 동일하다.
--WHERE절에 기술하면 OUTER JOIN이 되지 않음
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

--오라클 OUTER JOIN
--오라클 OUTER JOIN시 기준 테이블의 반대편 테이블의 모든 컬럼에(+)를 붙여야 
--정상적인 OUTER JOIN으로 동작한다.
--한컬럼에라도 (+)를 누락하면 INNER 조인으로 동작

--아래 ORACLE OUTER JOIN은 INNER조인으로 동작 :m.deptno 컬럼에(+)가 붙지 않음
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) AND m.deptno(+) = 10;

--사원 - 매니저간 right outer join
SELECT empno, ename, mgr
FROM emp;

SELECT empno, ename 
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename, m.empno 
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);


--FULL OUTER : LEFT OUTER + RIGHT OUTER - 중복제거 -> 총 22건
--오라클 OUTER JOIN에서는 (+)기호를 이용하여 FULL OUTER 문법을 지원하지 않는다.
SELECT e.empno, e.ename, e.mgr, m.ename, m.empno 
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);


--OUTERJOIN1
SELECT count(*)--148
FROM buyprod;

SELECT count(*)--74
FROM prod;

SELECT d.buy_date, d.buy_prod, i.prod_id, i.prod_name, d.buy_qty
FROM buyprod d, prod i
WHERE d.buy_prod = i.prod_id;

SELECT d.buy_date, d.buy_prod, i.prod_id, i.prod_name, d.buy_qty
FROM buyprod d, prod i
WHERE d.buy_prod = i.prod_id
AND d.buy_date = to_date('20050125','yyyymmdd');

SELECT d.buy_date, d.buy_prod, i.prod_id, i.prod_name, d.buy_qty
FROM buyprod d, prod i
WHERE d.buy_prod(+) = i.prod_id
AND d.buy_date(+) = to_date('20050125','yyyymmdd');

--outer join2
SELECT nvl(d.buy_date,to_date('20050125','yyyymmdd')), d.buy_prod, i.prod_id, i.prod_name, d.buy_qty
FROM buyprod d, prod i
WHERE d.buy_prod(+) = i.prod_id
AND d.buy_date(+) = to_date('20050125','yyyymmdd');




