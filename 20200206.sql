  --fastfood���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;
SELECT rownum, sido, sigungu, burger_score
FROM
    (SELECT sido, sigungu, ROUND((kfc+BURGERKING+mac)/lot,2)burger_score
    FROM
        (SELECT sido, sigungu,  
                NVL(SUM(DECODE(gb,'KFC',1)),0)kfc, NVL(SUM(DECODE(gb, '����ŷ',1)),0) BURGERKING,
                NVL(SUM(DECODE(gb,'�Ƶ�����',1)),0)mac, NVL(SUM(DECODE(gb, '�Ե�����',1)),1) lot
        FROM fastfood
        WHERE gb IN('KFC','����ŷ','�Ƶ�����','�Ե�����')
        GROUP BY sido, sigungu)
    ORDER BY burger_score DESC);
    
    
SELECT rownum, sido, sigungu, pri_sal     
FROM
    (SELECT sido, sigungu, ROUND(sal/people) pri_sal
    FROM tax
    ORDER BY pri_sal DESC);
    
    
    
SELECT b_score.sido,b_score.sigungu,b_score.burger_score,p_score.sido,p_score.sigungu,p_score.pri_sal
FROM (SELECT rownum num, sido, sigungu, burger_score
        FROM
        (SELECT sido, sigungu, ROUND((kfc+BURGERKING+mac)/lot,2)burger_score
        FROM
        (SELECT sido, sigungu,  
                NVL(SUM(DECODE(gb,'KFC',1)),0)kfc, NVL(SUM(DECODE(gb, '����ŷ',1)),0) BURGERKING,
                NVL(SUM(DECODE(gb,'�Ƶ�����',1)),0)mac, NVL(SUM(DECODE(gb, '�Ե�����',1)),1) lot
        FROM fastfood
        WHERE gb IN('KFC','����ŷ','�Ƶ�����','�Ե�����')
        GROUP BY sido, sigungu)
        ORDER BY burger_score DESC))b_score,
                                                (SELECT rownum num, sido, sigungu, pri_sal     
                                                FROM
                                                (SELECT sido, sigungu, ROUND(sal/people) pri_sal
                                                FROM tax
                                                ORDER BY pri_sal DESC))p_score
WHERE b_score.num = p_score.num;

--ROWNUM���� ����
--1.SELECT -> ORDER BY
--���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE-VIEW
--1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE������ ����� ����
-- ROWNUM = 1(0)
-- ROWNUM = 2(X)
-- ROWNUM < 10(0)
-- RUWNUM > 10(X)

--empno�÷��� motnull ���������� �ִ�. -intsrt�� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�.
--empno�÷��� ������ ������ �÷��� nullable�̴�.(null���� ����� �� �ִ�.)
INSERT INTO emp(empno, ename, job)
VALUES (9999,'brown',NULL);

SELECT *
FROM emp;

INSERT INTO emp(ename, job)
VALUES('sally','SALESMAN');

--���ڿ� : '���ڿ�'
--���� : 10
--��¥ : TO_DATE('20200206','YYYYMMDD'),SYSDATE

--emp���̺��� hiredate �÷��� dateŸ��
--emp���̺��� 8���� �÷��� ���� �Է�

DESC emp;
INSERT INTO emp VALUES(9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99);

ROLLBACK;

--�������� �����͸� �ѹ��� INSERT : 
--INSERT INTO ���̺��(�÷���1, �÷���2....)
--SELECT ...
--FROM;


INSERT INTO emp 
SELECT 9998,'sally','SALESMAN',NULL,SYSDATE,1000,NULL,99
FROM dual
    UNION ALL
SELECT 9999,'brown','CLERK',NULL,TO_DATE('20200205','YYYYMMDD'), 1100, NULL,99
FROM dual;

--UPDATE ����
--UPDATE ���̺�� SET �÷���1 = ������ �÷� ��1,���̺�� �÷���2 = ������ �÷� ��2 ...
--WHERE�� ���� ����
--������Ʈ ���� �ۼ��� WHERE���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��
--UPDATE, DELETE ���� WHERE���� ������ �ǵ��Ѱ� �´��� �ٽ��ѹ� Ȯ���Ѵ�

--WHERE���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT �ϴ� ������ �ۼ��Ͽ� �����ϸ�
--UPDATE ��� ���� ��ȸ �� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�.

--99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ� ��Ȳ
INSERT INTO dept VALUES(99,'ddit','daejeon');

SELECT *
FROM dept;

--99�� �μ���ȣ�� ���� �μ��� dname�÷��� ���� '���IT',loc�÷��� ���� '���κ���'���� ������Ʈ
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept
WHERE deptno = 99;

ROLLBACK;

--�Ǽ��� WHERE���� ������� ������ ���
UPDATE dept SET dname = '���IT', loc ='���κ���';

--10 ==> SUBQUERY;
--SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����
SELECT *
FROM emp
WHERE deptno IN(20,30);

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));

--UPDATE�ÿ��� ���� ���� ����� ����
INSERT INTO emp (empno,ename)VALUES(9999,'borwn');
--9999�� ��� deptno, jpb ������ SMITH ����� ���� �μ�����, ��� ������ ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               Job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp;

ROLLBACK;

--DELETE SQL : Ư�� ���� ����
--DELETE [FROM] ���̺��
--WHERE �� ���� ����
SELECT *
FROM dept;

--99�� �μ� ���� ����

DELETE dept
WHERE deptno = 99;

COMMIT;

--SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE;
--�Ŵ����� 7698 ����� ������ ���� �ϴ� ������ �ۼ�
DELETE emp
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

DELETE emp
WHERE empno IN(SELECT empno
               FROM emp
               WHERE mgr = 7698);
               
SELECT *
FROM emp;

ROLLBACK;