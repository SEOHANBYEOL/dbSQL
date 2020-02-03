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

--06!!!!��!!!!!count�� �ƴϰ� sum�ε�................��

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
    

--07����
--hr(08~13)

-- �ش� ����Ŭ ������ ��ϵ� ����� ���� Ȱ��ȭ
-- SELECT *
-- FROM dba_users;

--HR������ ��й�ȣ�� JAVA�� �ʱ�ȭ
--ALTER USER HR IDENTIFIED BY java;
--ALTER USER HR ACCOUNT UNLOCK;

--OUTER JOIN
--�� ���̺��� �����Ҷ� ���� ������ ���� ��Ű�� ���ϴ� �����͸� �������� 
-- ������ ���̺��� �����͸��̶� ��ȸ �ǰԲ� �ϴ� ���� ���;

--�������� : e.mgr = m.empno : KING�� MGR�� NULL�̱� ������ ���ο� �����Ѵ�.
--EMP ���̺��� �����ʹ� �� 14��������, �Ʒ��� ���� ���������� ����� 13���� �ȴ�.(1�� ���ν���)
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--ANSI OUTER����
--1. JOIN�� �����ϴ��� ��ȸ�� �� ���̺��� ����(�Ŵ��� ������ ��� ��������� �����Բ�)

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);

--ORACLE OUTER JOIN
--�����Ͱ� ���� ���� ���̺� �÷� �ڿ�(+) ��ȣ�� �ٿ��ش�.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);


SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

--���� sql�� ANSI sql(outer join)���� �����غ�����.
--�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ.
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND m.deptno = 10); 

--�Ʒ� LEFT OUTER ������ ���������� OUTER������ �ƴϴ�
--�Ʒ� INNER���ΰ� ����� �����ϴ�.
--WHERE���� ����ϸ� OUTER JOIN�� ���� ����
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

--����Ŭ OUTER JOIN
--����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷���(+)�� �ٿ��� 
--�������� OUTER JOIN���� �����Ѵ�.
--���÷����� (+)�� �����ϸ� INNER �������� ����

--�Ʒ� ORACLE OUTER JOIN�� INNER�������� ���� :m.deptno �÷���(+)�� ���� ����
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+) AND m.deptno(+) = 10;

--��� - �Ŵ����� right outer join
SELECT empno, ename, mgr
FROM emp;

SELECT empno, ename 
FROM emp;

SELECT e.empno, e.ename, e.mgr, m.ename, m.empno 
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);


--FULL OUTER : LEFT OUTER + RIGHT OUTER - �ߺ����� -> �� 22��
--����Ŭ OUTER JOIN������ (+)��ȣ�� �̿��Ͽ� FULL OUTER ������ �������� �ʴ´�.
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




