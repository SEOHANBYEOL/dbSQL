SELECT *
FROM emp;

SELECT ename, deptno
FROM emp;

SELECT *
FROM dept;

-- JOIN �� ���̺��� �����ϴ� �۾�
-- JOIN ����
-- 1. ANSI ����
-- 2. ORACLE ����

-- Natural Join
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
-- emp, dept ���̺��� deptno ��� �÷��� ���� 
SELECT *
FROM emp NATURAL JOIN dept;

-- Natural Join�� ���� ���� �÷�(deptno)�� ������(ex: ���̺��, ���̺�Ī)�� ������� �ʰ�
-- �÷����� ����Ѵ� (dept.deptno --> deptno)
SELECT emp.empno, emp.ename, dname, deptno
FROM emp NATURAL JOIN dept;

-- ���̺� ���� ��Ī�� ��밡��
SELECT e.empno, e.ename, dname, deptno
FROM emp e NATURAL JOIN dept d;

-- ORACLE JOIN
-- FROM ���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�
-- ������ ���̺��� ���������� WHERE���� ����Ѵ�
-- emp, dept ���̺� �����ϴ� deptno �÷��� "������" ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

--����Ŭ ������ ���̺� ��Ī
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;


--ANSI : join with USING
-- ���� �Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ�������
-- �ϳ��� �÷����θ� ������ �ϰ��� �Ҷ�
-- �����Ϸ��� ���� �÷��� ���;
-- emp, dept ���̺��� ���� �÷� : deptno
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING(deptno);


--JOIN WITH USING�� ORACLE�� ǥ���ϸ�?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

-- ANSI : JOIN WITH ON
-- ���� �Ϸ��� �ϴ� ���̺� �÷��� �̸��� ���� �ٸ��� 
SELECT emp.ename, dept.dname, emp.deptno
FROM emp Join dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON --> ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;


--SELF JOIN : ���� ���̺��� ����
-- �� : emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ�Ҷ�
SELECT *
FROM emp;

SELECT e.empno, e.mgr, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

--oracle�������� �ۼ�
SELECT e.empno, e.mgr, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--equal ���� : = 
--non-equal ���� : !=, >, <, BETWEEN AND ;

SELECT ename, sal
FROM emp;

SELECT *
FROM salgrade;

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش����� �޿� ����� ���غ���
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--ANSI������ �̿��Ͽ� ���� ���� ���� �ۼ�
SELECT emp.ename, emp.sal, salgrade.grade
FROM emp Join salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal );



SELECT *
FROM emp;

SELECT *
FROM dept;

--join0
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

--join0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno!= 20;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno IN(10,30);


--join0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno= d.deptno AND e.sal > 2500
ORDER BY d.deptno;

--join 0_3
SELECT *
FROM
    (SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno)a
WHERE a.sal>2500 AND a.empno>7600;

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno= d.deptno AND e.sal > 2500 AND e.empno>7600;

--join 0_4
SELECT *
FROM
    (SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno)a
WHERE a.sal>2500 AND a.empno>7600 AND dname='RESEARCH';

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno= d.deptno AND e.sal > 2500 AND e.empno>7600 AND dname='RESEARCH' ;

--PROD : PROD_LGU
--LPROD : LPROD_GU;

SELECT* 
FROM prod;

SELECT* 
FROM lprod;

--join 1
SELECT l.lprod_gu, l.lprod_nm, p.prod_id, p.prod_name
FROM prod p, lprod l
WHERE p.prod_lgu = l.lprod_gu;

SELECT *
FROM buyer;

SELECT *
FROM prod;

--join2
SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer;

--join3 ����




