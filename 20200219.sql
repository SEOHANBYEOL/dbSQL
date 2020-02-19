
--�������� ��� 11��
--����¡ ó�� (�������� 10���� �Խñ�)
--1������ : 1~10
--2������ : 11~20
--���ε� ���� : page, :pageSize;


SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;

SELECT *
FROM
    (SELECT ROWNUM rn , a.*
     FROM
        (SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
        FROM board_test
        START WITH parent_seq IS NULL
        CONNECT BY PRIOR seq = parent_seq
        ORDER SIBLINGS BY root DESC, seq ASC)a)
    WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;
    

--���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�..
SELECT ename, sal, aa.deptno, bb.lv

FROM 
    (SELECT rownum rn, ename, sal, deptno
    FROM
        (SELECT *
        FROM emp
        ORDER BY deptno, sal DESC))aa,

    (SELECT rownum rn, deptno, cnt, lv
    FROM
        (SELECT deptno, cnt, lv
        FROM
            (SELECT deptno, COUNT(*) cnt
            FROM emp
            GROUP BY deptno)b,
            (SELECT LEVEL lv
            FROM dual
            CONNECT BY level <= 14)a
            WHERE b.cnt >= a.lv
            ORDER BY b.deptno, a.lv))bb
WHERE aa.rn = bb.rn;

--�����ڸ� �ٸ���� ó��
SELECT ename, sal, deptno, ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

--�����ڸ� ������� ó��
--�μ��� �޿���ŷ
SELECT ename, sal, deptno, rank() OVER(PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

--�м��Լ� ����
--�м��Լ���([����]) OVER ([PARTITION BY �÷�] [ORDER BY �÷�] [WINDOWING])
--PARITION BY �÷� : �ش� �÷��� ���� ROW���� �ϳ��� �׷����� ���´�
--ORDER BY �÷� : PARTITION  BY�� ���� ���� �׷� ������ ORDER BY �÷����� ����

--ROW_NUMBER() OVER (PARTITON BY deptno ORDER BY sal DESC) rank;
--���� ���� �м��Լ� 
--RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
--         2���� 2���̸� 3���� ���� 4����� �ļ����� �����ȴ�.
--DENSE_RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ���� �������� ����
--               2���� 2���̴��� �ļ����� 3����� ����
--ROW_NUMBER() : ROWNUM�� ���� , �ߺ��� ���� ������� ����


--�μ��� �޿� ������ 3���� ��ŷ ���� �Լ��� ����
SELECT ename, sal, deptno, 
        RANK()OVER (PARTITION BY deptno ORDER BY sal, empno) sal_rank,
        DENSE_RANK()OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
        ROW_NUMBER()OVER (PARTITION BY deptno ORDER BY sal) sal_row_rank
FROM emp;


--ana1

SELECT *
FROM emp;

SELECT ename, sal, deptno, 
        RANK()OVER (ORDER BY sal) sal_rank,
        DENSE_RANK()OVER (ORDER BY sal) sal_dense_rank,
        ROW_NUMBER()OVER (ORDER BY sal) sal_row_rank
FROM emp;




--no_ana2
SELECT empno, ename, b.deptno, cnt
FROM
    (SELECT empno, ename, deptno
    FROM emp)a,
    (SELECT deptno, COUNT(*) cnt
    FROM emp
    GROUP BY deptno)b
WHERE a.deptno = b.deptno
ORDER BY b.deptno;


--������ �м��Լ� (GROUP �Լ����� �����ϴ� �Լ� ������ ����)
--SUM(�÷�), COUNT(*), COUNT(�÷�), MIN(�÷�), MAX(�÷�), AVG(�÷�)

--no_ana2�� �м��Լ��� ����ؼ� �ۼ�
--�μ��� ���� ��
SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--ana2 :�μ��� �޿� ��� ��ȸ
SELECT empno, ename, sal, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) sal
FROM emp;

--ana3 : �μ��� �ִ� �޿� ��ȸ
SELECT empno, ename, sal, deptno, MAX(sal) OVER (PARTITION BY deptno) sal
FROM emp;

--ana4 : �μ��� �ּ� �޿� ��ȸ
SELECT empno, ename, sal, deptno, MIN(sal) OVER (PARTITION BY deptno) sal
FROM emp;

--�޿��� �������� �����ϰ�, �޿��� �������� �Ի����ڰ� ��������� ���� �켱������ �ǵ��� �����Ͽ�
--���� ���� ������(lead)�� sal�÷��� ���ϴ� ������ �ۼ�
SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC, hiredate) laed_sal
FROM emp;

--ana5
SELECT empno, ename, hiredate, sal, LAG(sal) OVER(ORDER BY sal DESC, hiredate) laed_sal
FROM emp;

--ANA6 : ��� ����� ����, ������ �� �޿� ����
--      (�޿��� ���� ��� �Ի����� ���� ����� ���� ����)
SELECT empno, ename, hiredate, sal, LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) laed_sal,job
FROM emp;


SELECT a.empno, a.ename, a.sal, SUM(b.sal) C_SUM
FROM 
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal, empno)a)a,
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal, empno)a)b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno;


    
--no_ana3�� �м��Լ��� �̿��Ͽ� SQL�ۼ�
SELECT empno, ename, sal,
       SUM(sal) OVER(ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumm_sal
FROM emp;


--�������� �������� ���� ������� ���� ������� �� 3������ sal �հ� ���ϱ�
--ORDER BY ��� �� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ����ȴ�.(= RANGE UNBOUNDED PRECEDING)
--RANGE UNBOUNDED PRECEDING

SELECT empno, ename, sal,
        SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)c_sum
FROM emp;

--ANA7
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)c_sum
FROM emp;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno)c_sum
FROM emp;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno RANGE UNBOUNDED PRECEDING )c_sum
FROM emp;



--WINDOWING�� RANGE, ROWS ��
--RANSGE : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
--ROWS : �������� ���� ����

--range : �ߺ����� ��� ���ع��� (default)
--rows : �ߺ����̶� �ϳ��� ����
SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING)row_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal range UNBOUNDED PRECEDING)range_,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ) default_
FROM emp;