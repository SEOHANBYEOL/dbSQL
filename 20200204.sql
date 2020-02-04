--CROSS JOIN => īƼ�� ���δ�Ʈ (Cartesian product)
--�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
--������ ��� ���տ� ���� ����(����)�� �õ�
--dept(4��), emp(14��)�� CROSS JOIN�� ����� 4*14=56

--dept ���̺�� emp ���̺��� ������ �ϱ����� FROM���� �ΰ��� ���̺��� ���
--WHERE���� �� ���̺��� ���� ���� ����

--ORACLE
SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp;

--ANSI
SELECT dept.dname, emp.empno, emp.ename
FROM dept CROSS JOIN emp;

--pt246 CROSS JOIN1
SELECT customer.CID, customer.CNM, product.PID, product.PNM
FROM customer, product;

SELECT customer.CID, customer.CNM, product.PID, product.PNM
FROM customer CROSS JOIN product;

--SUBQUERY : �����ȿ� �ٸ� ������ �� �ִ� ���
--SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
--SELECT�� : SCALAR SUBQUERY : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����
--FORM�� : INLINE - VIEW (VIEW)
--WHERW�� : SUBQUERY


--SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
--1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�
--2.1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�.

--1.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2.1������ ���� �μ� ��ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ
SELECT *
FROM emp
WHERE deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');

         
--SUB1
SELECT COUNT(*)
FROM emp
WHERE sal>(SELECT AVG(SAL)
            FROM emp);
    
--SUB2
SELECT *
FROM emp
WHERE sal>(SELECT AVG(SAL)
            FROM emp);

--������ ������
--IN : ���������� ���� ���� ��ġ�ϴ� ���� �����Ҷ�
--ANY [Ȱ�뵵�� �ټ� ������] : ���������� ������ �� �� ���̶� ������ ������ �� 
--ALL [Ȱ�뵵�� �ټ� ������] : ���������� �������� ��� �࿡ ���� ������ ������ �� 

--SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
--SMITH�� WARD ������ ���ϴ� �μ��� ��� ������ ��ȸ

--���������� ����� �������� ���� = �����ڸ� ������� ���Ѵ�.
SELECT * 
FROM emp
WHERE deptno IN((SELECT deptno 
                FROM emp 
                WHERE ename IN('SMITH','WARD')));

--SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿��� �ƹ��ų�)
--SMITH : 800
--WARD : 1250
--1250���� ���� ���

SELECT *
FROM emp
WHERE sal <ANY (800,1250);

SELECT *
FROM emp
WHERE sal <ANY (SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));

SELECT sal
FROM emp
WHERE ename IN('SMITH','WARD');


--SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� �� )
--SMITH : 800
--WARD : 1250
--1250 ���� ���� ����

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));

-- IN, NOT IN�� NULL�� ���õ� ���� ����
-- ������ ������ ����� 7566�̰ų�(OR) null
-- IN�����ڴ� OR�����ڷ� ġȯ ����
SELECT *
FROM emp
WHERE mgr IN(7902, null);-- ���̾ȳ���

-- null �񱳴� = �����ڰ� �ƴ϶� ISNULL�� �� �ؾ��Ѵ�.
SELECT *
FROM emp
WHERE mgr = 7902 OR mgr = null;-- ���̾ȳ���

SELECT *
FROM emp
WHERE mgr = 7902 OR mgr IS null;

--��� ��ȣ�� 7902�� �ƴϸ鼭(AND) NULL���ƴ�

SELECT *
FROM emp
WHERE empno !=7902
AND empno != NULL; -- ���̾ȳ���

SELECT *
FROM emp
WHERE empno !=7902
AND empno IS NOT NULL;

--PAIRWISE(������)
--�������� ����� ���ÿ� ���� ��ų��
SELECT *
FROM emp
WHERE (mgr, deptno ) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN(7499,7782));
                        
--MGR���� 7698�̰ų� 7839�̸鼭
--deptno�� 10�̰ų� 30���� ����
--mgr, deptno (7698,10),(7698,30),(7839,10)(7939,30)

SELECT *
FROM emp
WHERE mgr IN(SELECT mgr
            FROM emp
            WHERE empno IN(7499,7782))
AND deptno IN (SELECT deptno
               FROM emp
               WHERE empno IN(7499,7782));

--��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
--��Į�� ���������� main������ �÷��� ����ϴ°� �����ϴ�.

SELECT (SELECT SYSDATE
        FROM dual) , dept.*
FROM dept;

SELECT empno, ename, deptno, 
    (SELECT dname 
    FROM dept 
    WHERE deptno = emp.deptno ) dname
FROM emp;

--INLINE VIEW : FROM ���� ���� �������� 

--MAIN ������ �÷��� SUBQUERY���� ��� �ϴ��� ������ ���� �з�
--����� ��� : correlated subquery(��ȣ ���� ����), ���������� �ܵ����� ���� �ϴ°� �Ұ���
--             ��������� ������ �ִ� (main -->sub)

--������� ���� ��� : non-correlated subquery(���ȣ ���� ��������), ���������� �ܵ����� ���� �ϴ°� ����
--              ���� ������ ������ ���� �ʴ�.(main->sub, sub->main)

--��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT * 
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp
WHERE sal>(SELECT avg(sal)
            FROM emp
            WHERE deptno = emp.deptno); 
            
--���� ������ ������ �̿��ؼ� Ǯ���.
--1.�������̺� ���� 
-- emp, �μ��� �޿� ���(inlineview)

SELECT emp.ename, sal, emp.deptno, dept_sal.*
FROM emp, (SELECT deptno, AVG(SAL) avg_sal
            FROM emp
            GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal>dept_sal.avg_sal;

--������ �߰�
INSERT INTO dept VALUES(99,'ddit','daejeon');
COMMIT; -- Ʈ����� Ȯ��
--ROLLBACK ; -- Ʈ����� ���

--���ȣ����, not in
--SUB4
SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp
                    GROUP BY deptno);

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

                
                