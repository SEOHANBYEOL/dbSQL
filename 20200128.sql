SELECT *
FROM emp
WHERE deptno IN(10,30)
AND sal>1500
ORDER BY ename DESC;

--ROWNUM : ���ȣ�� ��Ÿ���ִ� �÷�
SELECT ROWNUM, empno,ename
FROM emp
WHERE deptno IN(10,30)
AND sal>1500
ORDER BY ename DESC;


--ROWNUM�� WHERE�������� ��� ����
--�����ϴ°� : ROWNUM=1 / ROWNUM <=2            ->ROWNUM=1 / ROWNUM <=n
--�������� �ʴ°� : ROWNUM =2; / ROWNUM >= 2     ->ROWNUM =n(n�� 1�� �ƴ� ����); / ROWNUM >= n(n�� 1�� �ƴ� ����)
--ROWNUM �̹� ���� �����Ϳ��ٰ� ������ �ο�
    -- ������ : --���� ���� ������ ����, ROWNUM�� �ο����� ���� ���� ��ȸ�� �� �� ����.
               --ORDER BY���� SELECT�� ���Ŀ� ����
--���뵵 : ����¡ ó��
--���̺� �ִ� ��� ���� ��ȸ�ϴ°��� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�� �Ѵ�.
-- ����¡ ó���� ������� : 1 ������ �ش� �Ǽ�, ���� ����
--emp ���̺� �� row �Ǽ� : 14
--�ټ��Ǹ� ��ȸ 
-- 1pg : 1-5
-- 2pg : 6-10
-- 3pg : 11-15

SELECT ROWNUM rn, empno, ename
FROM emp
ORDER BY ename;

--���ĵ� ����� ROWNUM�� �ο� �ϱ� ���ؼ��� INLINE VIEW�� ����Ѵ�.
--���� -> ROWNUM�ο�

--SELECT *�� ����� ��� �ٸ� EXPRESSION�� ǥ�� �ϱ� ���ؼ� ���̺��.* ���̺��Ī.*�� ǥ���Ѵ�.

SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--ROWNUM ->rn
--1pg : rn 1-5
--2pg : rn 6-10
--3pg : rn 11-15
--npg : rn (page-1)*pageSize+1 - page*pageSize

SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename
         FROM emp
         ORDER BY ename)a)
WHERE rn>=6 AND rn<=10;


SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename
         FROM emp
         ORDER BY ename)a)
WHERE rn BETWEEN (1-1)*5 +1 AND 1*5;


--pg105_row_1
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename
         FROM emp)a)
WHERE rn BETWEEN 1 AND 10;


--row_2
SELECT *
FROM
    (SELECT ROWNUM rn, empno, ename
     FROM emp)
WHERE rn BETWEEN 11 AND 20;



--row_3
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT empno, ename
          FROM emp
          ORDER BY ename)a)
WHERE rn BETWEEN (:page-1) * :pageSize + 1 AND :page * :pageSize;


SELECT *
FROM
    (SELECT ROWNUM rn, a.*
     FROM
         (SELECT empno, ename
          FROM emp
          ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--DUAL ���̺� (�����Ϳ� ������� �Լ��� �׽�Ʈ �غ� �������� ���)
SELECT *
FROM DUAL;

SELECT LENGTH('TEST')
FROM DUAL;

--���ڿ��� ��ҹ��� : LOWER UPPER INITCAP
SELECT LOWER('Hello World'),UPPER('Hello World'),INITCAP('Hello World')
FROM DUAL;

SELECT LOWER(ename),UPPER(ename),INITCAP(ename)
FROM emp;

SELECT *
FROM emp
WHERE ename = UPPER(:ename);


-- �Լ� : WHERE �������� ����̰����ϴ�.
-- ����̸��� SMITH�� ����� ��ȸ
-- SQL �ۼ��� �Ʒ� ���´� ���� �ؾ��Ѵ�.
-- ���̺��� �÷��� �������� ���� ���·� SQL�� �ۼ��Ѵ�.
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;

--
SELECT CONCAT('Hello', 'World') CONCAT,
       SUBSTR('Hello, World', 1, 5) SUB,
       LENGTH('Hello, World')LEN,
       INSTR('Hello, World', 'o') INS,
       INSTR('Hello, World', 'o', 6) INS2,
       LPAD('Hello, World', 15, '*') LP,
       RPAD('Hello, World', 15, '*') RP,
       REPLACE('Hello, World', 'H', 'T') REP,
       TRIM('  Hello, World  ')TR, --������ ����
       TRIM('d' FROM 'Hello, World')TR --������ �ƴ� �ҹ��� d����
FROM DUAL;

-- ��������
-- ROUND �ݿø� 10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� -> 11 
-- TRUNC ���� 10.6 -> 10 
-- ROUND, TRUNC : ���� �ΰ� 
-- MOD �������� ������ (���� �ƴ϶� ������ ������ �� ������ ��) (13/5 -> ���� 2, �������� 3)

SELECT ROUND(105.54, 1),
       ROUND(105.55, 1),
       ROUND(105.55, 0),  -- �ݿø� ����� �����κи� (�Ҽ��� ù��° �ڸ����� �ݿø�)
       ROUND(105.55, -1), -- �ݿø� ����� ���� �ڸ�����
       ROUND(105.55)      -- �ι�° ���ڸ� �Է��ϵ� ���� ��� 0�� ����
FROM DUAL;

SELECT TRUNC(105.54, 1), -- �Ҽ��� ù��° �ڸ����� ��������, �Ҽ��� ��°�ڸ����� ����
       TRUNC(105.55, 1),  -- �Ҽ��� ù��° �ڸ����� ��������, �Ҽ��� ��°�ڸ����� ����
       TRUNC(105.55, 0), -- ������ ����� �����κ�(�����ڸ�)���� ������ , �Ҽ��� ù��° �ڸ����� ����
       TRUNC(105.55, -1) TR, -- ������ ����� �����ڸ����� ������, �����ڸ����� ���� 
       TRUNC(105.55)     --�ι�° ���ڸ� �Է��ϵ� ���� ��� 0�� ����
FROM DUAL;

--EMP���̺��� ����� �޿�(sal)�� 1000���� ���������� �� --���� ���غ�����.
SELECT ename, sal, TRUNC(sal/1000), MOD(sal,1000)--mod�� ����� divisor���� �׻� �۴�,(0~999)
FROM emp;


DESC emp;

--�⵵���ڸ�/�����ڸ�/���ڵ��ڸ�
SELECT ename, hiredate --���� ->ȯ�漳��->�����ͺ��̽� -> NLS �������� ��¥���ĺ��氡��.
FROM emp;

--SYSDATE : ���� ����Ŭ ������ ���糯¥, �ð������� ���� DATE���� ��ȯ
-- DATE + ���� : ���� ���� (���� 1�� �Ϸ�) (1/24 -> �ѽð�)
-- ���� ǥ�� : ���� --> 100
-- ���� ǥ�� : �̱� �����̼� '���ڿ�'
-- ��¥ǥ�� : TO_DATE('���ڿ� ��¥ ��', '���ڿ� ��¥ ���� ǥ�� ����') -> TO_DATE('2020-01-28,'YYYY-MM-DD')

SELECT SYSDATE+5
FROM DUAL;

SELECT SYSDATE, SYSDATE+1/24
FROM DUAL;

       
-------------------PT 129 fn1 ����------------------
SELECT TO_DATE('19/12/31','YY/MM/DD') LASTDAY, TO_DATE('19/12/31','YY/MM/DD')-5 LASTDAY_BEFORES, SYSDATE NOW, SYSDATE-3 NOW_BEFORE3
FROM dual;