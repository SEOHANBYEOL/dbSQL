--TRUNCATE �׽�Ʈ
--REDO�α׸� �������� �ʱ� ������ ������ ������ ������ �Ұ��ϴ�
--DML(SELECT, INSERT, UPDATE, DELETE)�� �ƴ϶� 
--DDL�� �з�(ROLLBACK�� �Ұ�)

--�׽�Ʈ �ó����� 
--EMP���̺� ���縦 �Ͽ� EMP_COPY��� �̸����� ���̺� ����
--EMP_COPY ���̺��� ������� TRUNCATE TABLE EMP_COPY ����

--EMP_COPY ���̺� �����Ͱ� �����ϴ���(���������� ������ �Ǿ�����) Ȯ��;

--EMP_COPY ���̺� ����;

--CREATE ==> DDL (ROLLBACK�� �ȵȴ�)
CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

TRUNCATE TABLE emp_copy;

--TRUNCATE TABLE ��ɿ��� DDL�̱� ������ ROLLBACK�� �Ұ��ϴ�.
--TUNCATE �� SELECT�� �غ��� �����Ͱ� ���� ���� ���� ���� �� �� �ִ�.
ROLLBACK;

--��ȭ ����

--DDL : Data Defination Language - ������ ���Ǿ� 
--��ü�� ����, ����, ������ ���
--ROLLBACK�Ұ�
--�ڵ� COMMIT

--���̺� ����
--CREATE TABLE [��Ű����.]���̺��(
--  �÷��� �÷�Ÿ��[DEFAULT �⺻��],
--  �÷�2�� �÷�2Ÿ��[DEFAULT �⺻��],
--);
--ranger��� ���̺� ����
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

DESC ranger;

INSERT INTO ranger (ranger_no, ranger_nm) VALUES (1,'brown');
COMMIT;

SELECT *
FROM ranger;


--���̺� ���� (drop)
--DROP TABLE ���̺��;
DROP TABLE ranger;

--DDL�� �ѹ� �Ұ�
ROLLBACK;
--���̺��� �ѹ���� �������� Ȯ�� �� �� �ִ�.
SELECT *
FROM ranger;

--������ Ÿ��
--���ڿ� (varchar2 ���, charŸ�� ��� ����)
--varchar(10) : �������� ���ڿ�, ������ 1~4000byte
--              �ԷµǴ� ���� �÷� ������� �۾Ƶ� ���� ������ �������� ä���� �ʴ´�.

--char(10) : �������� ���ڿ� 
--           �ش� �÷��� ���ڿ��� 5byte�� �����ϸ� ������ 5byte �������� ä������.
--           'test'==>'test      '
--           'test'!= 'test      '

--����
--NUMBER(p,s):p- ��ü�ڸ���(38) , s- �Ҽ��� �ڸ���
--INTEGER ==> NUMBER(38,0)
--ranger_no NUMBER ==> NUMBER(38,0)

--��¥
--DATE - ���ڿ� �ð� ������ ����
--       7BYTE

--��¥ - DATE
--      VARCHAR2(8) - '20200207'
--      �� �ΰ��� Ÿ���� �ϳ��� �����ʹ� 1BYTE�� ������ ���̰� ����
--      ������ ���� ���� ���� �Ǹ� ������ �� ���� �������, ����� Ÿ�Կ� ���� ����� �ʿ�

--LOB (LargeOBject) - �ִ� 4GB
--CLOB - Character Large OBject
--      VARCHAR2�� ���� �� ���� �������� ���ڿ�(4000BYTE �ʰ� ���ڿ�)
--      ex : �� �����Ϳ� ������ html �ڵ�

--BLOB - Binary Large OBject
--       ������ �����ͺ��̽��� ���̺��� ���� �� �� 
--       �Ϲ������� �Խñ� ÷�������� ���̺� ���� �������� �ʰ�
--       ���� ÷�������� ��ũ�� Ư�� ������ �����ϰ�, �ش� [���]�� ���ڿ��� ����

--       ������ �ſ� �߿��� ��� : �� ������� ���Ǽ� -> [����]�� ���̺� ����

--���� ���� : �����Ͱ� ���Ἲ�� ��Ű���� ���� ����      
-- 1.UNIQUE ���� ����
-- �ش� �÷��� ���� �ٸ� ���� �����Ϳ� �ߺ����� �ʵ��� ����
-- EX : ����� ���� ����� ���� ���� ����.

-- 2.NOT NULL ���� ���� (CHECK ��������)
--  �ش� �÷��� ���� �ݵ�� �����ؾ� �ϴ� ����
-- EX : ��� �÷��� NULL�� ����� ������ ���� ����
--    : ȸ�����Խ� �ʼ� �Է»��� (GITHUB - �̸����̶�, �̸�) 

--3.PRIMARY KEY ���� ����
--  UNIQUE + NOT NULL
--  EX : ����� ���� ����� ���� ���� ����, ����� ���� ����� ���� ���� ����
-- PRIMARY KEY ���� ������ ������ ��� �ش� �÷����� UNIQUE INDEX�� �����ȴ�

--4.FOREIGN KEY ���� ���� (�������Ἲ)
-- �ش� �÷��� �����ϴ� �ٸ� ���̺� ���� �����ϴ� ���� �־�� �Ѵ�
-- EMP ���̺��� DEPTNO�÷��� DEPT���̺��� DEPTNO �÷��� ����(����)
-- EMP ���̺��� DEPTNO�÷����� DEPT���̺� �������� �ʴ� �μ���ȣ�� �Է� �� �� ����
-- EX) ���� DEPT���̺��� �μ���ȣ�� 10, 20, 30, 40���� ������ ���
--          EMP���̺� ���ο� ���� �߰� �ϸ鼭 �μ���ȣ ���� 99������ ����� ���
--          �� �߰��� �����Ѵ�.

--5.CHECK �������� (���� üũ)
-- NOT NULL ���� ���ǵ� CHECK ���࿡ ����
-- EMP ���̺� JOB�÷��� ��� �� �� �ִ� ���� 'SALESMAN','PRESIDENT','CLERK'

--�������� ���� ���
--1. ���̺��� �����ϸ鼭 �÷��� ���
--2. ���̺��� �����ϸ鼭 �÷� ��� ���Ŀ� ������ ���������� ���
--3. ���̺� ������ ������ �߰������� ���������� �߰�

-- CREATE TABLE ���̺��(
--  �÷�1 �÷�Ÿ��[1.��������],
--  �÷�2 �÷�Ÿ��[1.��������],

--[2.TABLE_CONSTRAINT]
--);

--3.ALTER TABLE emp...;

--PRIMARY KEY ���������� �÷� ������ ����(1�� ���)
--DEPT ���̺��� �����Ͽ� DEPT_TEST ���̺��� PRIMARY KEY �������ǰ� �Բ� ����
-- ��, �̹���� ���̺��� key�÷��� �����÷��� �Ұ�, ���� �÷��� ���� ����

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    location VARCHAR2(13)
);

INSERT INTO dept_test(deptno) VALUES(99); --���������� ����;
INSERT INTO dept_test(deptno) VALUES(99); --�ٷ����� ������ ���� ���� ���� �����Ͱ� �̹� �����
DESC dept;

--������� : �츮�� ���ݱ��� ������ ����� dept ���̺��� deptno �÷�����
--UNIQUE �����̳� PRIMARY KEY ���� ������ ������ ������
--�Ʒ� �ΰ��� INSERT ������ ���������� ����ȴ�.
INSERT INTO dept(deptno) VALUES(99);
INSERT INTO dept(deptno) VALUES(99);

ROLLBACK;

--���� ���� Ȯ�� ���
--1.TOOL�� ���� Ȯ��
-- Ȯ���ϰ��� �ϴ� ���̺��� ����

--2.dictionary�� ���� Ȯ�� (USER_TABLES, USER_CONSTRAINTS);
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'SYS_C007085';


--3. �𵨸�(EX: EXERD)���� Ȯ��

--���� ���� ���� ������� ���� ��� ����Ŭ���� ���� �����̸��� ���Ƿ� �ο� (EX: SYS_C007086)
--�������� �������� ������ 
--����Ģ�����ϰ� �����ϴ°� ����, � ������ ����
--PRIMARY KEY �������� : PK_���̺��
--FOREIGN KEY �������� : FK_��� ���̺�� _ �������̺� ��

DROP TABLE dept_test;
--�÷� ������ ���������� �����ϸ鼭 �������� �̸��� �ο�
--CONSTRAINT �������Ǹ� ��������Ÿ��(PRIMARY KEY);

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    location VARCHAR2(13)
);

INSERT INTO dept_test (deptno) VALUES(99);
INSERT INTO dept_test (deptno) VALUES(99);

--2.���̺� ������ �÷� ��� ���� ������ �������� ���;
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    location VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY (deptno)
);

--NOT NULL �������� �����ϱ�
--1. �÷��� ����ϱ� (O)
--   �� �÷��� ����ϸ鼭 �������� �̸��� �ο��ϴ°� �Ұ�;
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) NOT NULL,
    location VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY (deptno)
);

--NOT NULL �������� Ȯ��;
INSERT INTO dept_test (deptno,dname) VALUES(99,NULL);

--2.���̺� ������ �÷� ��� ���Ŀ� ���� ���� �߰�
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT NN_dept_test_dname CHECK (deptno IS NOT NULL)
    );

--UNIQUE ���� : �ش� �÷��� �ߺ��Ǵ� ���� �����°��� ����, �� NULL�� �Է��� �����ϴ�
--PRIMARY KEY = UNIQUE + NOT NULL;

--1.���̺� ������ �÷� ���� UNIQUE �������� ;
-- dname �÷��� UNIQUE ��������;

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

--dept_test ���̺��� dname �÷��� ������ unique ���������� Ȯ��;
INSERT INTO dept_test VALUES (98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

--2. ���̺� ������ �÷��� �������� ���, �������� �̸� �ο�;
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14)CONSTRAINT UK_dept_test_dname UNIQUE,
    loc VARCHAR2(13)
);

--dept_test ���̺��� dname �÷��� ������ unique ���������� Ȯ��;
INSERT INTO dept_test VALUES (98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

--3. ���̺� ������ �÷� ��� ���� �������� ���� -���� �÷�(deptno-dname)(unique);
DROP TABLE dept_test;

CREATE TABLE dept_test(
deptno NUMBER(2),
dname VARCHAR2(14),
loc VARCHAR2(13),

CONSTRAINT UK_dept_test_deptno_dname UNIQUE (deptno, dname)

);

--���� �÷��� ���� UNIQUE ���� Ȯ�� (deptno, dname);
INSERT INTO dept_test VALUES(99,'ddit','daejeon');
INSERT INTO dept_test VALUES(98,'ddit','daejeon');

--FOREIGN KEY ��������
--�����ϴ� ���̺��� �÷��� �����ϴ� ���� ��� ���̺��� �÷��� �Է��� �� �ֵ��� ����
--EX: emp ���̺� dempno �÷��� ���� �Է� �� ��, dept ���̺��� deptno �÷��� �����ϴ� �μ���ȣ��
-- �Է� �� �� �ֵ��� ����
-- �������� �ʴ� �μ���ȣ�� emp ���̺��� ������� ���ϰԲ� ����


--1.dept_test���̺� ����
--2.emp_test���̺� ����
--3.emp_test���̺� ������ deptno�÷����� dept.deptno �÷��� �����ϵ��� FK�� ����

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno) 
);

DROP TABLE emp_test;
DESC emp;

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test(deptno),
    
    CONSTRAINT pk_emp_test PRIMARY KEY (empno)
);

-- ������ �Է¼���
-- emp_test ���̺� �����͸� �Է��ϴ°� �����Ѱ�???
-- ���ݻ�Ȳ (dept_test, emp_test ���̺��� ��� ����- �����Ͱ� �������� ������)

 INSERT INTO emp_test VALUES(9999, 'brown', NULL); --FK�� ������ �÷��� NULL�� ���
 INSERT INTO emp_test VALUES(9998, 'sally', 10); --10�� �μ��� dept_test���̺� �������� �ʾƼ� ����;
 
 --dept_test���̺� �����͸� �غ�;
 INSERT INTO dept_test VALUES(99,'ddit','daejeon');
 INSERT INTO emp_test VALUES(9998,'sally',10); --10�� �μ��� dept_test�� �������� �����Ƿ� ����
 INSERT INTO emp_test VALUES(9998,'sally',99); --99�� �μ��� dept_test�� �����ϹǷ� ���� ����
 
 
 --2.���̺� ������ �÷� ��� ���� FOREIGN KEY �������� ����
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno) 
);

INSERT INTO dept_test VALUES (99,'ddit','daejeon');

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
);

INSERT INTO emp_test VALUES(9999,'brown',10); --dept_test���̺� 10���μ��� �������� �ʾ� ����
INSERT INTO emp_test VALUES(9999,'brown',99); --dept_test���̺� 99���μ��� �����ϹǷ� ���� ����


--����--------

CREATE TABLE tb_dept(
    d_cd VARCHAR(20) CONSTRAINT PK_tb_dept PRIMARY KEY,
    d_nm VARCHAR(50) NOT NULL,
    p_d_cd VARCHAR(20)
);

CREATE TABLE tb_grade(
    g_cd VARCHAR(20)CONSTRAINT PK_tb_grade PRIMARY KEY,
    g_nm VARCHAR(50) NOT NULL,
    ord NUMBER

);

CREATE TABLE tb_job(
    j_cd VARCHAR(20)CONSTRAINT PK_tb_job PRIMARY KEY,
    j_nm VARCHAR(50) NOT NULL,
    ord NUMBER

);


CREATE TABLE tb_emp(
    e_no NUMBER CONSTRAINT PK_tb_emp PRIMARY KEY,
    e_nm VARCHAR(50) NOT NULL,
    g_cd VARCHAR(20) NOT NULL, 
    j_cd VARCHAR(20) NOT NULL,
    d_cd VARCHAR(20) NOT NULL,
    
    CONSTRAINT FK_tb_grade_TO_tb_emp FOREIGN KEY (g_cd) REFERENCES tb_grade (g_cd),
    CONSTRAINT FK_tb_job_TO_tb_emp FOREIGN KEY (j_cd) REFERENCES tb_job (j_cd),
    CONSTRAINT FK_tb_dept_TO_tb_emp FOREIGN KEY (d_cd) REFERENCES tb_dept (d_cd)

);


CREATE TABLE tb_cs_cd(
    cs_cd VARCHAR(20)CONSTRAINT PK_tb_cs_cd PRIMARY KEY,
    cs_nm VARCHAR(50) NOT NULL,
    p_cs_cd VARCHAR(20)
 

);

CREATE TABLE tb_counsel(
    cs_id VARCHAR(20)CONSTRAINT PK_tb_counsel PRIMARY KEY,
    cs_reg_dt DATE NOT NULL,
    cs_cont VARCHAR2(40) NOT NULL,
    e_no NUMBER NOT NULL,
    cs_cd1 VARCHAR2(20) NOT NULL,
    cs_cd2 VARCHAR2(20),
    cs_cd3 VARCHAR2(20),
    CONSTRAINT FK_tb_emp_TO_tb_counsel FOREIGN KEY (e_no) REFERENCES tb_emp (e_no),
    CONSTRAINT FK_tb_cs_cd_TO_tb_counsel2 FOREIGN KEY (cs_cd2) REFERENCES tb_cs_cd (cs_cd)
    

);



