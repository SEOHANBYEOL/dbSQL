--synonym : ���Ǿ�
--1.��ü ��Ī�� �ο�
-- >�̸��� �����ϰ� ǥ��

--sem����ڰ� �ڽ��� ���̺� emp���̺��� ����ؼ� ���� v_emp view
--hr ����ڰ� ����� �� �ְ� �� ������ �ο�

--v_emp : �ΰ��� ���� sal, comm�� ������ view

--hr����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�
SELECT *
FROM hb.v_emp;

--hr��������
--synonym hb.v_emp -> v_emp
--v_emp == hb.v_emp

SELECT *
FROM v_emp;


--1. sem�������� v_emp�� hr �������� ��ȸ�� �� �ֵ��� ��ȸ���� �ο�
GRANT SELECT ON v_emp TO hr;

--2. hr ���� v_emp ��ȸ�ϴ°� ����(���� 1������ �޾ұ� ������)
--���� �ش� ��ü�� �����ڸ� ��� : hb.v_emp
--�����ϰ� hb.v_emp ->v_emp ����ϰ� ���� ��Ȳ
--synonym ����
-- CREATE SYNONYM �ó���̸� FOR ����ü��;
--synonym ����
-- DROP SYNONYM �ó���̸�;


--GRANT CONNECT TO hb;
--GRANT SELECT ON ��ü�� TO hr;


--synonym ���������� ������ �ȵ�
SELECT *
FROM v_emp;

--synonym ����
CREATE SYNONYM v_emp FOR hb.v_emp;

--synonym ������ ���� ��
SELECT *
FROM hb.v_emp;


--���� ����
--1. �ý��� ���� : TABLE ����, VIEW ���� ����...
--2. ��ü ���� : Ư�� ��ü�� ���� SELECT, UPDATE, INSERT, DELETE...

--ROLE : ������ ��Ƴ��� ����
--����ں��� ���� ������ �ο��ϰ� �Ǹ� ������ �δ�.
--Ư�� ROLE�� ������ �ο��ϰ� �ش� ROLE�� ����ڿ��� �ο�
--�ش� ROLE�� �����ϰ� ROLE�� ���� �ִ� ��� ����ڿ��� ����

--���� �ο�/ȸ��
--�ý��� ���� :GRANT �����̸� TO ����� | ROLE;
--�ý��� ���� ȸ�� : REVOKE �����̸� FROM ����� | ROLE;
--��ü ���� : GRANT �����̸� ON ��ü�� TO ����� | RPLE;
--          REVOKE �����̸� ON ��ü�� FROM ����� |ROLE;

--data dictionary; ����ڰ� �������� �ʰ� dbms�� ��ü������ �����ϴ� 
--                  �ý��� ������ ���� view

--data dictionary ���ξ�
--1. USER : �ش� ����ڰ� ������ ��ü
--2. ALL : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷ� ���� ������ �ο����� ��ü
--3. DBA : ��� ������� ��ü

--* V$ Ư�� VIEW;

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES;

--DICTIONARY ���� Ȯ�� : SYS.DICTIONARY;

SELECT *
FROM DICTIONARY;

--��ǥ���� dictionary
--OBJECTS : ��ü ���� ��ȸ(���̺�, �ε���, VIEW, SYNONYM...)
--TABLES : ���̺� ������ ��ȸ
--TAB_COLUMNS : ���̺��� �÷� ���� ��ȸ
--INDEXES : �ε��� ���� ��ȸ
--IND_COLUMNS : �ε��� ���� �÷� ��ȸ
--CONSTRAINTS : ���� ���� ��ȸ
--CONS_COLUMNS : ���� ���� ���� �÷� ���� ��ȸ
--TAB_COMMENTS : ���̺� �ּ�
--COL_COMMENTS : ���̺� �÷� �ּ�

SELECT *
FROM USER_OBJECTS;

--emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ
--USER_INDEXES, USER_IND_COLUMNS
--���̺��, �ε�����, �÷���, �÷� ���� (column_posisiont)
--emp ind_n_emp_04 ename
--emp ind_n_emp_04 job
SELECT *
FROM USER_INDEXES;

SELECT *
FROM USER_IND_COLUMNS;

SELECT I.TABLE_NAME, I.INDEX_NAME, C.COLUMN_NAME, C.COLUMN_POSITION
FROM USER_INDEXES I, USER_IND_COLUMNS C
WHERE I.INDEX_NAME = C.INDEX_NAME
ORDER BY I.TABLE_NAME, I.INDEX_NAME, C.COLUMN_POSITION;


--multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ� DML

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

--������ ���� ���� ���̺� ���� �Է��ϴ� multiple insert
INSERT ALL 
    INTO dept_test
    INTO dept_test2
SELECT 98, '���', '�߾ӷ�'
FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

--���̺� �Է��� �÷��� �����Ͽ� multiple insert;
ROLLBACK;
INSERT ALL
    INTO dept_test(deptno,loc) VALUES(deptno, loc)
    INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

--���̺� �Է��� �����͸� ���ǿ� ���� multiple insert;
CASE
    WHEN ���� ��� THEN
END;


ROLLBACK;
INSERT ALL
    WHEN deptno = 98 THEN
        INTO dept_test(deptno,loc) VALUES(deptno, loc)
        INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;



--������ �����ϴ� ù��° INSERT�� �����ϴ� MULTIPLE INSERT

ROLLBACK;
INSERT FIRST
    WHEN deptno >= 98 THEN
        INTO dept_test(deptno,loc) VALUES(deptno, loc)
    WHEN deptno >= 97 THEN 
        INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;


--����Ŭ ��ü : ���̺� �������� ������ ��Ƽ������ ����
--���̺� �̸��� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������ �и��� ������ �����͸� ����

--MERGE : ����
--���̺� �����͸� �Է�/ ���� �Ϸ��� ��
--1. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
    --> ������Ʈ
--2. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �������� ������
    --> INSERT

--1.SELECT ����
--2-1.SELECT ���� ����� 0 ROW�̸� INSERT
--2-2.SELECT ���� ����� 1 ROW�̸� UPDATE

--MERGE������ ����ϰ� �Ǹ� SELECT�� ���� �ʾƵ� �ڵ����� ������ ������ ����
--INSERT Ȥ�� UPDATE�� �����Ѵ�.
--2���� ������ �ѹ����� �ٿ��ش�.

--MERGE INTO ���̺�� [alias]
--USING (TABLE | VIEW | IN_LINE-VIEW)
--ON (��������)
--WHEN MATCHED THEN 
--  UPDATE SET col1 = �÷���, col2 = �÷���...
--WHEN NOT MATCHED THEN
--  INSERT (�÷�1, �÷�2, �÷�3....)VALUES(�÷���1, �÷���2, �÷���3....);


SELECT *
FROM emp_test;

SELECT *
FROM emp;

DELETE emp_test;

--�α׸� �ȳ���� -> ������ �ȵȴ� ->������������...
TRUNCATE TABLE emp_test;

--emp ���̺��� emp_test���̺�� �����͸� ����
INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--�����Ͱ� �� �ԷµǾ����� Ȯ��
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

commit;

--emp ���̺��� ��� ������ emp_test ���̺�� ����
--emp ���̺��� ���������� emp_test���� �������� ������ insert
--emp ���̺��� �����ϰ� emp_test���� �����ϸ� ename, deptno�� update

--emp���̺� �����ϴ� 14���� �������� emp _test���� �����ϴ� 7369�� ������ 13���� �����Ͱ�
--emp_test ���̺� �űԷ� �Է��� �ǰ�
--emp_test �� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp���̺� �����ϴ� �̸��� SMITH�� ����.

MERGE INTO emp_test a
USING emp b
ON (a.empno = b.empno)
WHEN MATCHED THEN
    UPDATE SET a.ename = b.ename, 
               a.deptno = b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) VALUES(b.empno, b.ename, b.deptno);


SELECT *
FROM emp_test;


--�ش� ���̺� �����Ͱ� ������ insert, ������ update;
--emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert
--������ update
--(9999,'brown',10,'010');


INSERT INTO emp_test VALUES(9999,'brown',10,'010')
UPDATE emp_test SET ename = 'brown'
                    deptno = 10
                    hp = '010'
WHERE empno = 9999;



MERGE INTO emp_test
USING dual
ON (empno =9999)
WHEN MATCHED THEN
    UPDATE SET ename = ename || '_u',
               deptno = 10,
               hp = '010'
WHEN NOT MATCHED THEN
    INSERT VALUES(9999,'brown',10,'010');
    
SELECT *
FROM emp_test;

--MERGE , WINDOW FUNCTION(�м��Լ�)

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null,sum(sal)
FROM emp;


--I/O
--CPU CACHE > RAM> SSD > HDD > NETWORK;

--REPORT GROUP FUNCTION
--CUBE
--GROUPING

--ROLLUP
--����� : GROUP BY ROLLUP (�÷�1, �÷�2, ...)
--SUBGROUP�� �ڵ������� ����
--SUBGROUP�� �����ϴ� ��Ģ : ROLLUP�� ����� �÷��� [������]�������� �ϳ��� �����ϸ鼭 
--                          SUB GROUP�� ����

--EX : GROUP BY ROLLUP (deptno);
--> 
-- ù��° sub group : GROUP BY deptno
-- �ι�° sub group : GROUP BY NULL == > ��ü��

--GROUP_AD1�� GROUP BY ROLLUP ���� ����Ͽ� �ۼ�
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT job, deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--1. GROUP BY job, deptno : ������, �μ��� �޿���
--2. GROUP BY job : �������� �޿���
--3. GROUP BY : ��ü �޿���

SELECT job, deptno,
        GROUPING(job),GROUPING(deptno),
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP(job,deptno);


SELECT job, deptno,
        GROUPING(job),GROUPING(deptno),
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP(job,deptno);



SELECT  
CASE WHEN GROUPING(job)=1 AND GROUPING(deptno)=1 THEN '�Ѱ�'
     ELSE job
END JOB,
deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);




--GROUP_AD2 ���� �ۼ� (DECODE)
--DECODE(����(����X))
SELECT  
DECODE (GROUPING(job),1,'�Ѱ�',0,job) job,
deptno, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--GROUP_AD2-1 ���� �ۼ� (DECODE/ CASE)
SELECT  
CASE WHEN GROUPING(job)=1 AND GROUPING(deptno)=1 THEN '��'
     ELSE job
END JOB,

CASE WHEN TO_CHAR(GROUPING(job))='0' AND TO_CHAR(GROUPING(deptno))='1' THEN '�Ұ�'
     WHEN TO_CHAR(GROUPING(job))='1' AND TO_CHAR(GROUPING(deptno))='1' THEN '��'
     ELSE TO_CHAR(deptno)
END deptno,

SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);




