--  1.PRIMARY KEY ���� ���� ������ ����Ŭ dbms�� �ش� �÷����� unique index�� �ڵ����� �����Ѵ�.
--  (**��Ȯ���� UNIQUE ���࿡ ���� UNIQUE �ε����� �ڵ����� �����ȴ�.
--      PRIMARY KEY = UNIQUE + NOT NULL)

--  index : �ش� �÷����� �̸� ������ �س��� ��ü
--  ������ �Ǿ��ֱ� ������ ã���� �ϴ� ���� �����ϴ��� ������ �� �� �� �ִ�.
--  ���࿡ �ε����� ���ٸ� ���ο� �����͸� �Է��� ��
--  �ߺ��ϴ� ���� ã�� ���ؼ� �־��� ��� ���̺��� ��� �����͸� ã�ƾ� �Ѵ�.
--  ������ �ε����� ������ �̹� ������ �Ǿ��ֱ� ������ �ش� ���� ���� ������ ������ �� �� �� �ִ�.

--  2.FOREIGN KEY �������ǵ� 
--  �����ϴ� ���̺� ���� �ִ����� Ȯ�� �ؾ��Ѵ�.
--  �׷��� �����ϴ� �÷��� �ε����� �־������ FOREIGN KEY ������ ������ ���� �ִ�.

--  FOREIGN KEY ������ �ɼ�
--  FOREIGN KEY(���� ���Ἲ) : �����ϴ� ���̺��� �÷��� �����ϴ� ���� �Է� �� �� �ֵ��� ����
--  (EX : emp���̺� ���ο� �����͸� �Է½� deptno �÷����� dept ���̺� �����ϴ� �μ���ȣ�� �Է� �� �� �ִ�.)

--  FOREIGN KEY�� �����ʿ� ���� �����͸� ������ �� ������
--  � ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵ�
--  (EX : emp.deptno ==> dept.deptno�÷��� �����ϰ� ������ 
--      �μ� ���̺��� �����͸� ���� �� ���� ����)

SELECT *
FROM emp_test;

SELECT *
FROM dept_test;

INSERT INTO dept_test VALUES (98, 'ddit2','����');
commit;

--emp : 9999,99
--dept : 98,99
-- 98�� �μ��� �����ϴ� emp���̺��� �����ʹ� ����
-- 99�� �μ��� �����ϴ� emp���̺��� �����ʹ� 9999�� brown ����� ����

-- ���࿡ DELETE dept_test WHERE deptno = 99; ������ �����ϰ� �Ǹ� ������ �߻� (�����ϴµ����Ͱ� �ֱ⶧���� ���Ἲ�� ����)
-- ���࿡ DELETE dept_test WHERE deptno = 98; ������ �����ϰ� �Ǹ�
DELETE dept_test 
WHERE deptno = 98;

--FOREIGN KEY �ɼ�
--1. ON DELETE CASCASE : �θ� ���� �ɰ�� (dept) �����ϴ� �ڽ� ������(emp)�� ���� �����Ѵ�.
--2. ON DELETE SET NULL : �θ� ���� �ɰ�� (dept) �����ϴ� �ڽ� ������(emp)�� �÷��� NULL�� �����Ѵ�.

--emp_test ���̺��� drop �� �ɼ��� ������ ���� ������ ���� �׽�Ʈ

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno) 
            REFERENCES dept_test(deptno) ON DELETE CASCADE
);

INSERT INTO emp_test VALUES(9999,'brown',99);

COMMIT;

--emp ���̺��� deptno�÷��� dept���̺��� deptno�÷��� ����(ON DELETE CASCADE)
--�ɼǿ� ���� �θ����̺� (dept_test)�� ���� �ϰ� �Ǹ� �����ϰ� �ִ� �ڽ� �����͵� ���� �����ȴ�.
DELETE dept_test
WHERE deptno = 99;

--�ɼ��� �ο����� �ʾ��� ������ ���� delete������ ������ �߻�
--�ɼǿ� ���� �����ϴ� �ڽ����̺� �����Ͱ� ���������� ���� �Ǿ����� SELECT Ȯ��

SELECT *
FROM emp_test;



-- FK ON DELETE SET NULL �ɼ� �׽�Ʈ
-- �θ� ���̺��� ������ ������ (dept_test)�ڽ����̺��� �����ϴ� �����͸� NULL�� ������Ʈ�Ѵ�.
ROLLBACK;

SELECT *
FROM dept_test;

SELECT *
FROM emp_test;

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno) 
            REFERENCES dept_test(deptno) ON DELETE SET NULL
);

INSERT INTO emp_test VALUES(9999,'brown',99);

COMMIT;

--dept_test ���̺��� 99�� �μ��� �����ϰ� �Ǹ� (�θ� ���̺��� �����ϸ� )
--99�� �μ��� �����ϴ� emp_test ���̺��� 9999��(brown)�������� deptno �÷��� 
--FK �ɼǿ� ���� NULL�� �����Ѵ�.

DELETE dept_test
WHERE deptno = 99;

-- �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����Ͱ� NULL�� ����Ǿ����� Ȯ��
SELECT *
FROM emp_test;

-- CHECK �������� : �÷��� ���� ���� ������ ������ �� ���
-- EX : �޿� �÷��� ���ڷ� ����, �޿��� ������ �� �� ������?
--  �Ϲ����� ��� �޿����� > 0
--  CHECK ������ ����� ��� �޿����� 0���� ū������ �˻� ����.
--  EMP���̺��� JOB�÷��� ���� ���� ���� 4������ ���� ����
--  'SALESMAN','PRESIDENT','ANALYST','MANAGER'

-- ���̺� ������ �÷� ����� �Բ� CHECK �������
-- emp_test ���̺��� sal�÷��� 0���� ũ�ٴ� CHECK �������� ����

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    sal NUMBER CHECK(sal>0),
    
    CONSTRAINT pk_emp_test PRIMARY KEY(empno),
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno)
    );

INSERT INTO dept_test VALUES (99,'ddit','����');
INSERT INTO emp_test VALUES (9999,'brown',99,1000);
INSERT INTO emp_test VALUES (9998,'sally',99,-1000); --(salüũ���ǿ� ���� 0���� ū ���� �Է� ����)


--���ο� ���̺� ����
--CREATE TABLE ���̺�� (
--    �÷�1...
--    );
--CREATE TABLE ���̺�� AS
--SELECT ����� ���ο� ���̺�� ����

--emp���̺��� �̿��ؼ� �μ���ȣ�� 11�� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ�
--emp_test2���̺��� ����

CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE deptno IN(10);

SELECT *
FROM emp_test2;

--TABLE ����
--1.�÷��߰�
--2.�÷� ������ ����, Ÿ�� ����
--3.�⺻�� ����
--4.�÷����� rename
--5.�÷��� ����
--6.�������� �߰�/����

--TALBLE ���� 1. �÷��߰� (HP varchar2(20));
DROP TABLE emp_test;

CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno), 
    CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
    );
    
--ALTER TABLE ���̺�� ADD(�ű��÷��� �ű��÷� Ÿ��);

ALTER TABLE emp_test ADD(hp VARCHAR2(20));

DESC emp_test;

SELECT *
FROM emp_test;

-- TABLE ���� 2. �÷� ������ ����, Ÿ�Ժ���
-- EX : �÷� VARCHAR2(20) == > VARCHAR2(5)
-- ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� �ſ� ����
-- �Ϲ������� �����Ͱ� �������� �ʴ� ����, �� ���̺��� ������ ���Ŀ� �÷��� ������, Ÿ���� �߸� �Ȱ��
-- �÷� ������, Ÿ���� ������.
-- �����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ������ (������ �ø��°͸� ����)

DESC emp_test;
--hp varchar2(20) ==> hp varchar2(30);

--ALTER TABLE ���̺�� MODIFY (���� �÷��� �ű� �÷� Ÿ��(������));
ALTER TABLE emp_test MODIFY (hp varchar2(30));
DESC emp_test;

--�÷� Ÿ�� ����
--hp VARCHAR2(30) --> hp NUMBER;
ALTER TABLE emp_test MODIFY (hp NUMBER);
DESC emp_test;

--�÷� �⺻�� ����
--ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);
--hp number->hp(varchar2(20) default '010')
ALTER TABLE emp_test MODIFY (hp VARCHAR2(20) DEFAULT '010');
DESC emp_test;

--hp�÷����� ���� ���� �ʾ����� default ������ ���� '010'���ڿ��� �⺻������ ����ȴ�.
INSERT INTO emp_test (empno, ename, deptno) VALUES(9999, 'brown', 99);

SELECT *
FROM emp_test;

--4.TABLE ����� �÷� ����
--ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO �ű� �÷���
--hp->hp_n;
ALTER TABLE emp_test RENAME COLUMN hp TO hp_n;

DESC emp_test;

--���̺� ���� 5. �÷� ����
--ALTER TABLE ���̺�� DROP COLUMN �÷���;
--emp_test ���̺��� hp_n�÷� ����

SELECT *
FROM emp_test;

ALTER TABLE emp_test DROP COLUMN hp_n;

--emp_test hp_n�÷��� �����Ǿ����� Ȯ��
SELECT *
FROM emp_test;


--6. �������� �߰�/ ����;
-- ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������Ÿ��(PRIMARY KEY, FOREIGN KEY) (�ش� �÷�);
-- ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ� ;

--1. emp_test ���̺� ���� �� 
--2. �������� ���� ���̺��� ����
--3. PRIMARY KEY, FOREIGN KEY������ ALTER TABLE������ ���� ����.
--4. �ΰ��� �������ǿ� ���� �׽�Ʈ

DROP TABLE emp_test;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));
    
ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno);

--PRIMARY KEY �׽�Ʈ
INSERT INTO emp_test VALUES(9999, 'brown',99);
INSERT INTO emp_test VALUES(9999, 'sally',99); --ù��° INSERT���п� ���� �ߺ��ǹǷ� ����

--FOREIGN KEY �׽�Ʈ
INSERT INTO emp_test VALUES(9998, 'sally', 98); -- dept_test���̺� �������� �ʴ� �μ���ȣ�̹Ƿ� ����

--�������� ����
-- ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ� ;

--���� ���� ���� : PRIMARY KEY, FOREIGN KEY
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_test_dept_test;

INSERT INTO emp_test VALUES(9999, 'brown',99);
INSERT INTO emp_test VALUES(9999, 'sally',99); -- ���������� �����Ƿ� empno�� �ߺ��� ���� �� �� �ְ�,
INSERT INTO emp_test VALUES(9998, 'sally', 98); --�μ� ���̺� �������� �ʴ� deptno���� �� �� �ִ�.


--�������� Ȱ��ȭ /��Ȱ��ȭ
--ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

--1.emp_test ���̺� ����
--2.emp_test ���̺� ����
--3.ALGER TABLE PRIMARY KEY (empno), FOREIGN KEY (dept_test.deptno)�������� ����
--4.�ΰ��� ���������� ��Ȱ��ȭ
--5.��Ȱ��ȭ�� �Ǿ����� INSERT�� ���� Ȯ��
--6.���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2));

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY(empno);
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY(deptno) REFERENCES dept_test(deptno);

ALTER TABLE emp_test DISABLE CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

INSERT INTO emp_test VALUES (9999, 'brown',99);
INSERT INTO emp_test VALUES (9999, 'sally',98);

commit;

SELECT *
FROM emp_test;

--emp_test ���̺��� empno�÷��� ���� 9999���� ����� �θ� �����ϱ� ������
--PRIMARY KEY ���������� Ȱ��ȭ �� �� �� ����.
--> EMPNO �÷��� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ �� �� �ִ�.
ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test;

SELECT *
FROM emp_test;

--�ߺ������� ����
DELETE emp_test
WHERE ename IN ('brown');

--PRIMARY KEY �������� Ȱ��ȭ
ALTER TABLE emp_test ENABLE CONSTRAINT pk_emp_test;





SELECT *
FROM dept_test;

--dept_test ���̺� �������� �ʴ� �μ���ȣ 98�� emp_test���� �����
--1.dept_test���̺� 98���μ��� ����ϰų�
--2.sally�� �μ���ȣ�� 99������ �����ϰų�
--3.sally�� ����ų�
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

UPDATE emp_test SET deptno = 99
WHERE ename = 'sally';

SELECT *
FROM emp_test;

--FOREIGN KEY �������� Ȱ��ȭ
ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;

COMMIT;



--����
--DEFAULT ���� ����
--1. emp_test ���̺��� drop�� empno, ename, deptno, hp 4���� �÷����� ���̺� ����
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    hp VARCHAR2(30));
--2. empno, ename, deptno 3���� �÷����� (9999, 'brown', 99) �����ͷ� INSERT
INSERT INTO emp_test (empno, ename, deptno) VALUES(9999, 'brown', 99);
INSERT INTO emp_test (empno, ename, deptno) VALUES(9999, 'brown', 99);
INSERT INTO emp_test (empno, ename, deptno) VALUES(9999, 'brown', 99);
--3. emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
ALTER TABLE emp_test MODIFY (hp DEFAULT '010');
--4. 2�������� �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ��
SELECT *
FROM emp_test;



