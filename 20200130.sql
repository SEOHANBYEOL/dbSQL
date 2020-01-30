--COND1
 SELECT empno,ename,CASE 
                        WHEN deptno = 10 THEN 'ACCOUNTING'
                        WHEN deptno = 20 THEN 'RESEARCH'
                        WHEN deptno = 30 THEN 'SALES'
                        WHEN deptno = 40 THEN 'OPERATIONS'
                        ELSE 'DDIT'
                    END DNAME                         
 FROM emp;
 
 
SELECT empno,ename,
        DECODE(deptno,10,'ACCOUNTING',20,'RESEARCH',30,'SALES',40,'OPERATIONS','DDIT')dname
FROM emp;


--COND2
SELECT empno, ename, hiredate
FROM emp;

--���س⵵�� ¦������ Ȧ������ Ȯ��
--DATE Ÿ�� -> ���ڿ�(�������� ����, YYYY-MM-DD HH24:MI:SS)
SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))
FROM dual;

--¦�� -> 2�� ���������� ������ 0
--Ȧ�� -> 2�� ���������� ������ 1
SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
FROM dual;

SELECT empno, ename, hiredate,
    CASE
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)=0 AND MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=0 THEN '�ǰ����� �����'
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)=1 AND MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2)=1 THEN '�ǰ����� �����'
        ELSE '�ǰ����� ������'
    END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
    CASE
        WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)= MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) THEN '�ǰ����� �����'
        ELSE '�ǰ����� ������'
    END CONTACT_TO_DOCTOR
FROM emp;


SELECT empno, ename, hiredate,
    DECODE(MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2) , MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2), '�ǰ����� �����','�ǰ����� ������')
    CONTACT_TO_DOCTOR
FROM emp;

--COND3 �ǽ�����

SELECT *
FROM users;


SELECT userid, usernm, alias, reg_dt, 
        DECODE(MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2), MOD(TO_NUMBER(TO_CHAR(reg_dt,'YYYY')),2),'�ǰ����� �����','�ǰ����� ������')
        CONTACTTODOCTOR
FROM users;







SELECT *
FROM emp;


--GROUP BY ���� ���� ����
--�μ���ȣ ���� ROW���� ���� ��� : GROUP BY deptno
--�������� ���� ROW���� ���� ��� : GROPU BY job
--MGR�� ���� �������� ���� ROW���� ���� ��� : GROUP BY mgr, job


-- �׷� �Լ��� ����
-- SUM : �հ�
-- COUNT : ���� - NULL���� �ƴ� ROW�� ����
-- MAX : �ִ�
-- MIN : �ּҰ�
-- AVG : ���

-- �׷��Լ��� Ư¡
-- �ش� �÷��� Null���� ���� ROW�� ������ ��� �ش� ���� �����ϰ� ����Ѵ� (NULL ������ ����� null)

-- �׷��Լ��� ������
-- GROUP BY ���� ���� �÷��̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ����

--�μ��� �޿� ��
SELECT deptno, ename, 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno, ename;




-- GROUP BY ���� ���� ���¿��� �׷��Լ��� ����� ���
-- ��ü���� �ϳ��� ������ ���´�
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal�÷��� ���� null �� �ƴ� row�� ����
        COUNT(comm), -- comm�÷��� ���� null �� �ƴ� row�� ����
        COUNT(*)--����� �����Ͱ� �ִ���
FROM emp;


--GROUP BY ������ empno�̸� ������� ���?
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� �����°��� ����
SELECT 
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal�÷��� ���� null �� �ƴ� row�� ����
        COUNT(comm), -- comm�÷��� ���� null �� �ƴ� row�� ����
        COUNT(*)--����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;


SELECT  1,SYSDATE,'ACCOUNTING',
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),  -- sal�÷��� ���� null �� �ƴ� row�� ����
        COUNT(comm), -- comm�÷��� ���� null �� �ƴ� row�� ����
        COUNT(*)--����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION�� ��� WHERE������ ����ϴ°��� �����ϳ�
-- MULTI ROW FUNCTION(GROUP FUNCTION)�� ��� WHERE������ ����ϴ� ���� �Ұ����ϰ�
-- HAVING ������ ������ ����Ѵ�.

-- �μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ
-- deptno, �޿���
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) >9000;

--grp1
SELECT MAX(sal)max_sal, MIN(sal)min_sal, ROUND(AVG(sal),2)avg_sal,SUM(sal)sum_sal,COUNT(sal)count_sal,COUNT(mgr)count_mgr,COUNT(*)count_all
FROM emp;

SELECT
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
    END dname, MAX(sal)max_sal, MIN(sal)min_sal, ROUND(AVG(sal),2)avg_sal,SUM(sal)sum_sal,COUNT(sal)count_sal,COUNT(mgr)count_mgr,COUNT(*)count_all
FROM emp
GROUP BY deptno
ORDER BY deptno;

--grp4
--ORACLE 9i ���������� GROUP BY ���� ����� �÷����� ������ ����
--ORACLE 10G ���ĺ��ʹ� GROUP BY ���� ����� �÷����� ������ �������� �ʴ´�(GROUP BY ����� �ӵ� UP)
SELECT TO_CHAR(hiredate,'YYYYMM')hire_yyyymm, COUNT(hiredate)cnt 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM')
ORDER BY TO_CHAR(hiredate,'YYYYMM');


--grp5
SELECT TO_CHAR(hiredate,'YYYY')hire_yyyymm, COUNT(hiredate)cnt 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');
--ORDER BY TO_CHAR(hiredate,'YYYY');


--grp6
SELECT COUNT(deptno)cnt
FROM dept;


--grp7
SELECT COUNT(*) cnt
    FROM (SELECT deptno 
            FROM emp
            GROUP BY deptno);





