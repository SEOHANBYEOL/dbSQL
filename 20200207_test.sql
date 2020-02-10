
SELECT ename, hiredate
FROM emp
WHERE hiredate > TO_DATE('19820101','YYYYMMDD')
AND hiredate < TO_DATE('19830101','yyyymmdd');


SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE('%Áø%');


SELECT *
FROM emp
WHERE job = 'SALESMAN' 
AND hiredate > TO_DATE('19810601','YYYYMMDD');



SELECT rownum, a.*
FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY empno)a;
    

SELECT deptno, max(sal), min(sal), round(avg(sal), 2)
FROM emp
GROUP BY deptno;


SELECT *
FROM customer, cycle, product
WHERE customer.CID = cycle.CID
AND cycle.pid = product.pid
AND cnm IN ('brown','sally');


SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN('SMITH','WARD'));