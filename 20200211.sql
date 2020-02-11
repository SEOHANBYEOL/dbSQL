--���� ���� Ȯ�� ���
--1.tool
--2.dictionary view
--�������� : USER_CONSTRAINTS
--��������-�÷� : USER_CONS_COLUMNS;
--���������� ��� �÷��� ���õǾ� �ִ��� �˼� ���� ������ ���̺��� ������ �и��Ͽ� ����
-- 1������

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP','DEPT','EMP_TEST','DEPT_TEST');

--EMP , DEPT PK, FK���� �������� ����
--EMP ���̺� PK(EMPNO), FK(DEPTNO)- DEPT.DEPTNO
--dept : pk(deptno)

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_pk_emp FOREIGN KEY (deptno) REFERENCES dept(deptno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

--fk������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ� �Ѵ�.

--���̺�, �÷� �ּ� : DICTIONARY Ȯ�� ����
--���̺� �ּ� : USER_TAB_COMMENTS
--�÷� �ּ� : USER_COL_COMMENTS
--�ּ� ���� 
--���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
--�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�'

--emp : ����
--dept : �μ�

COMMENT ON TABLE emp is '����';
COMMENT ON TABLE dept is '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

--DEPT DEPTNO : �μ���ȣ
--DEPT DNAME : �μ���
--DEPT LOC : �μ���ġ
--EMP EMPNO :�����̸�
--EMP ENAME : �����̸�
--ENP JOB :������
--EMP MGR : �Ŵ��� ������ȣ
--EMP HIREDATE : �Ի����� 
--EMP SAL : �޿�
--EMP COMM : ������
--EMP DEPTNO : �ҼӺμ���ȣ


COMMENT ON COLUMN dept.deptno is '�μ���ȣ';
COMMENT ON COLUMN dept.dname is '�μ���';
COMMENT ON COLUMN dept.loc is '�μ���ġ';

COMMENT ON COLUMN emp.empno is '������ȣ';
COMMENT ON COLUMN emp.ename is '�����̸�';
COMMENT ON COLUMN emp.job is '������';
COMMENT ON COLUMN emp.mgr is '�Ŵ��� ���� ��ȣ';
COMMENT ON COLUMN emp.hiredate is '�Ի�����';
COMMENT ON COLUMN emp.sal is '�޿�';
COMMENT ON COLUMN emp.comm is '������';
COMMENT ON COLUMN emp.deptno is '�ҼӺμ���ȣ';


SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT *
FROM USER_COL_COMMENTS 
WHERE TABLE_NAME IN('EMP','DEPT');

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY');

--����
SELECT USER_TAB_COMMENTS.*, USER_COL_COMMENTS.COLUMN_NAME, USER_COL_COMMENTS.COMMENTS
FROM USER_TAB_COMMENTS, USER_COL_COMMENTS
WHERE USER_TAB_COMMENTS.TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY')AND USER_COL_COMMENTS.TABLE_NAME IN('CUSTOMER','PRODUCT','CYCLE','DAILY')
AND USER_TAB_COMMENTS.TABLE_NAME = USER_COL_COMMENTS.TABLE_NAME;


--VIEW = QUERY
--TABLEó�� DBMS�� �̸� �ۼ��� ��ü
--> �ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVIEW -->�̸��� ���� ������ ��Ȱ���� �Ұ�
--VIEW�� ���̺��̴�(X)

--������
--1.���� ����(Ư�� �÷��� �����ϰ� ������ �ܷΰ��� �����ڿ� ����)
--2.INLINE-VIEW�� VIEW�� �����Ͽ� ��Ȱ��
----���� ���� ����

--�������
--CREATE [OR REPLACE] VIEW ���Ī[(column1, column2...)] AS
--SUBQUERY;

--emp ���̺��� 8���� �÷��� sal, comm �÷��� ������ 6���� �÷��� �����ϴ� v_emp VIEW ����;

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--�ý��۰������� HB�������� VIEW �������� �߰�
--GRANT CREATE VIEW TO HB;

GRANT CREATE VIEW TO hb;

--������ ���ܼ� �����̵ȴ�.
CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--���� �ζ��� ��� �ۼ���;
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
    FROM emp);


--VIEW ��ü Ȱ��;
SELECT *
FROM v_emp;


--emp���̺��� �μ����� ���� --> dept���̺�� ������ ����ϰ� ����
--���ε� ����� view�� �����س����� �ڵ带 �����ϰ� �ۼ��ϴ°� ����

--VIEW :v_emp_dept
--dname(�μ���),empno(������ȣ), ename(�����̸�), job(������), hiredate(�Ի�����);

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�ζ��� ��� �ۼ���
SELECT *
FROM (  SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
        FROM emp, dept
        WHERE emp.deptno = dept.deptno);
        
--�� Ȱ���
SELECT *
FROM v_emp_dept;

--SMITH���� ������ v_emp_dept view�Ǽ���ȭ�� Ȯ��
DELETE emp
WHERE ename = 'SMITH';

--VIEW�� �������� �����͸� ���� �ʰ�, ������ �������� ���� ����(SQL)�̱� ������ 
--VIEW���� �����ϴ� ���̺��� �����Ͱ� ������ �Ǹ�, VIEW�� ��ȸ ����� ������ �޴´�.

--VIEW�� �����ϴ� ���̺��� �����ϸ� VIEW���� ������ ��ģ��.
ROLLBACK;


--SEQUENCE : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
--CREATE SEQUENCE ������ �̸�
--[OPTION....]
--����Ģ : SEQ_���̺��;

--emp���̺��� ����� ������ ����;
CREATE SEQUENCE seq_emp;

--������ ���� �Լ�
--NEXTVAL : ���������� ������ �����ö� ���
--CURRVAL : NEXTVAL ����ϰ� ���� ���� �о� ���� ���� ��Ȯ��

--������ ������
--ROLLBACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´�.
--NEXTVAL�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����.

SELECT seq_emp.NEXTVAL
FROM dual;

SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES(seq_emp.NEXTVAL,'james',99,'017');

SELECT ROWID, emp.*
FROM emp;

SELECT *
FROM emp
WHERE ROWID = 'AAAE5dAAFAAAACLAAH';



--�ε����� ������ empno������ ��ȸ�ϴ°��;
--emp���̺��� pk_emp ���������� �����Ͽ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ����

ALTER TABLE emp DROP CONSTRAINT pk_emp;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);



--emp���̺��� empno �÷����� pk������ �����ϰ� ������ sql�� ����
--pk : unique + not null
--      (unique �ε����� �������ش�)
--> empno�÷����� unique �ε����� ������
-- �ε����� sql�� �����ϰ� �Ǹ� �ε����� �������� ��� �ٸ��� �������� Ȯ��

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

SELECT rowid, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);

explain plan for
SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM TABLE (dbms_xplan.display);

--SELECT ��ȸ �÷��� ���̺� ���ٿ� ��ġ�� ����
--SELECT * FROM emp WHERE empno = 7782
-->
--explain plan for
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_xplan.display);


--UNIQUE VS NON-UNIQUE �ε����� ���� Ȯ��
--1. PK_EMP ����
--2. EMPNO �÷����� NON-UNIQUE �ε��� ����
--3. �����ȹ Ȯ��

ALTER TABLE emp DROP CONSTRAINT pk_emp;
CREATE INDEX idx_n_emp_01 ON emp(empno);

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique�ε����� ����

CREATE INDEX idx_n_emp_02 ON emp(job);


SELECT job, rowid
FROM emp
ORDER BY job;

--���û���
--1. EMP���̺��� ��ü �б�
--2. idx_n_emp_01 �ε��� Ȱ��
--3. idx_n_emp_02 �ε��� Ȱ��

explain plan for
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);



