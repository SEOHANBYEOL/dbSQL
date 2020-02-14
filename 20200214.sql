--MERGE : SELECT �ϰ��� �����Ͱ� ��ȸ�Ǹ� UPDATE
--        SELECT �ϰ��� �����Ͱ� ��ȸ���� ������ INSERT

--SELECT + UPDATE / SELECT + INSERT ==> MERGE

--REPORT GROUP FUNCTION
--1. ROLLUP
--       - GROUP BY ROLLUP (�÷�1, �÷�2)
--       - ROLLUP���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� SUBGROUP
--       - GROUP BY �÷�1, �÷�2
--         UNION
--         GROUP BY �÷�1
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
SELECT DECODE (GROUPING(dname),1, '����', 0, dname) dname,
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
--������ ������� ���� �׷��� ����ڰ� ���� ����
--����� : GROUP BY GROUPING SETS(col1, col2...)
--GROUP BY GROUPING SETS(col1, col2)
-->
--GROUP BY col1
--UNION ALL
--GROUP BY col2

--GROUPING SETS�� ��� �÷� ��� ������ ����� ������ ��ġ�� �ʴ´�.
--ROLLUP�� �÷� ��� ������ ����� ������ ��ģ��.

--GROUP BY BROUPING SETS( (col1, col2), col3, col4)
-->
--GROUP BY col1, col2
--UNION ALL
--GROUP BY col3
--UNION ALL
--GROUP BY col4;

--GROUP BY BROUPING SETS( (col1, col2), col3, col4)
--GROUP BY GROUPING SETS( col4, (col1, col2), col3)
--�ΰ��� ����� ����.


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);
-->
--GROUP BY job
--UNION ALL
--GROUP BY deptno

--job, deptno�� GROUP BY �� �����
--mgr�� GROUP BY �� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� �ۼ�

SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

--CUBE
--������ ��� �������� �÷��� ������ SUB GROUP�� �����Ѵ�.
--�� ����� �÷��� ������ ��Ų��.

--EX : GROUP BY CUBE(col1, col2);
--(col1, col2) -->
--(null, col2) --> GROUP BY col2;
--(null, null) --> GROUP BY ��ü
--(col1, null) --> GROUP BY col1
--(col1, col2) --> GROUP BY col1, col2;

--���� �÷� 3���� CUBE���� ����� ��� ���ü� �ִ� �������� ??
--8��
SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);


--ȥ��
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY job, rollup(deptno), CUBE(mgr);

--GROUP BY job, deptno, mgr -->--GROUP BY job, deptno, mgr
--GROUP BY job, deptno --> --GROUP BY job, deptno
--GROUP BY job, null, mgr --> --GROUP BY job, mgr
--GROUP BY job, null, null -->-- GROUP BY job


--�������� UPDATE
--1. emp_test���̺� drop
--2. emp ���̺��� �̿��ؼ� emp_test ���̺� ����(��� �࿡ ���� ctas)
--3. emp_test ���̺� dname VARCHAR2(14)�÷� �߰�
--4. emp_test.dname�÷��� dept���̺��� �̿��ؼ� �μ����� ������Ʈ

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
--dept_test ���̺� �ִ� �μ��߿� ������ ������ ���� �μ� ������ ����
-- dept_test.empcnt �÷��� ������� �ʰ�
-- emp���̺��� �̿��Ͽ� ����
INSERT INTO dept_test VALUES(99, 'it1','daejeon',0);
INSERT INTO dept_test VALUES(98, 'it2','daejeon',0);

--������ ������ ���� �μ� ���� ��ȸ?
--������ �ִ� ����...?
--10���μ��� ������ �ִ� ����?
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



--WITH ��
--�ϳ��� �������� �ݺ��Ǵ� SUBQUERY�� ������ 
--�ش� SUBQUERY�� ������ �����Ͽ� ����

--MAIN������ ����� �� WITH���� ������ ���� ���� �޸𸮿� �ӽ������� ����
--MAIN ������ ���ᰡ �Ǹ� �޸� ���� 

--SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���ؼ� I/O�� �ݺ������� �Ͼ����
--WITH���� ���� �����ϸ� �ѹ��� SUBQUERY�� ����ǰ� �� ����� �޸𸮿� �����س��� ����
--��, �ϳ��� �������� ������SUBQUERY�� �ݺ������� �����°Ŵ� �߸� �ۼ��� SQL�� Ȯ���� ����

--WITH ��������̸� AS(
--  ��������
--)

--SELECT *
--FROM ��������̸�;


--������ �μ��� �޿� ����� ��ȸ�ϴ� ��������� WITH���� ���� ����
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


--WITH���� �̿��� �׽�Ʈ ���̺� �ۼ�
WITH temp AS(
    SELECT sysdate -1 FROM dual UNION ALL
    SELECT sysdate -2 FROM dual UNION ALL
    SELECT sysdate -3 FROM dual)
SELECT *
FROM temp;

--�޷¸����;
--CONNECT BY LEVEL <[=] ����
--�ش� ���̺��� ���� ������ŭ �����ϰ� , ������ ���� �����ϱ� ���ؼ� LEVEL �ο� 
--LEVEL�� 1���� ����

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <=10;


SELECT dept.*, level
FROM dept
CONNECT BY LEVEL <=5;

--2020�� 2���� �޷��� ����
--1. :dt = 202002, 202003
--2. �޷�
--�� �� ȭ �� �� �� �� 
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
