
--prod ���̺��� ��� Į���� �ڷ� ��ȸ
SELECT * 
FROM prod;

--prod ���̺��� prod_id, prod_name �÷��� �ڷḸ ��ȸ
SELECT prod_id, prod_name
FROM prod;

--lprod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM lprod;
--buyer���̺��� buyer_id, buyer_name Į���� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT buyer_id, buyer_name
FROM buyer;
--cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM cart;
--member ���̺��� mem_id, mem_pass, mem_name Į���� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT mem_id, mem_pass, mem_name
FROM member;

--users ���̺� ��ȸ
SELECT *
FROM users;

--���̺� � �÷��� �ִ��� Ȯ���ϴ� ���
--1. SELECT *
--2. TOOL�� ��� (�����-TABLES)
--3. DESC ���̺��(DESC - DESCRIBE)
DESC users;

-- users���̺��� userid, usernm, reg_dt ��ȸ
-- ��¥���� (reg_dt �÷��� date������ ���� �� �ִ� Ÿ��)
-- ��¥ Į�� +(���ϱ⿬��)
-- �������� ��ġ�椤���� �ƴѰ͵�(5+5)
-- SQL���� ���ǵ� ��¥ ���� : 
-- ��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥�� �ȴ�.(2019/01/28+5 =2019/02/02)
-- null : ���� �𸣴� ����
-- null�� ���� ���� ����� �׻� null

SELECT userid AS u_id, usernm, reg_dt, reg_dt+5 AS reg_dt_after_5day
FROM users;

-- �ǽ�����PT56
SELECT prod_id AS id, prod_name AS name
FROM prod;
--
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;
--
SELECT buyer_id AS ���̾���̵�, buyer_name AS �̸�
FROM buyer;

-- ���ڿ� ����
-- �ڹ� ���� ���ڿ� ���� : + ("HELLO"+"WORLD")
-- SQL������ : || ('HELLO'||'WORLD')
-- SQL������ : concat('Hello', 'world')

--userid, usernm �÷��� ����, ��Ī�� id_name
SELECT userid || usernm AS id_name,
        CONCAT(userid, usernm) AS concat_id_name
FROM users;

-- ����, ���
-- int a = 5; Stirng msg = "helloworld";
-- System.out.println(msg); //������ �̿��� ���
-- System.out.println("helloworld"); //����� �̿��� ���

-- SQL������ ������ ����(�÷��� ����� ����, PL/SQL ���� ���� ����)
-- SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
-- "Hello, World"-->'Hello, World'
-- ���ڿ� ����� �÷����� ����
--user id : brown
--user id : cony
--�����̳� ��ҹ��� ���н� ���� �����̼����� ǥ��
SELECT 'user id : '|| userid AS "user id" 
FROM users;

--pt59
SELECT 'SELECT * FROM '|| table_name||';' AS query
FROM user_tables;

--CONCAT
SELECT CONCAT('SELECT * FORM ',CONCAT(table_name,';')) AS query
FROM user_tables;

-- SQL������ = (equal�� �ǹ�) JAVA������ =(������ �ǹ�)
-- SQL������ ������ ������ ����. (PL/SQL ���� ����)

-- users�� ���̺��� ��� �࿡ ���ؼ� ��ȸ
-- users���� 5���� �����Ͱ� ����
SELECT * 
FROM users;

-- WHERE�� : ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
-- EX : userid Į���� ���� brown�� �ุ ��ȸ
-- brown, 'brown' ����
-- �÷�, ���ڿ� ���
SELECT * 
FROM users
WHERE userid = 'brown';

-- uwerid�� brown�� �ƴ� �ุ ��ȸ
SELECT *
FROM users
WHERE userid != 'brown'; -- !=, <>

-- emp ���̺� �����ϴ� Į���� Ȯ�� �غ�����
DESC emp;

--emp ���̺��� ename �÷� ���� JONES�� �ุ ��ȸ
--  * SQL KEY WORD�� ��ҹ��ڸ� ������ ������ 
-- �÷��� ���̳�, ���ڿ� ����� ��ҹ��ڸ� ������.
-- 'JONES','jones'�� ���� �ٸ� ���.
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --employee

DESC emp;

--emp ���̺��� deptno(�μ���ȣ)�� 30���� ũ�ų� ���� ����鸸 ��ȸ�غ�����.
SELECT *
FROM emp
WHERE deptno >= 30;

-- ���ڿ� : '���ڿ�'
-- ���� : 50
-- ��¥ :  ??? -- > �Լ��� ���ڿ� �����Ͽ� ǥ��
--          ���ڿ��� �̿��Ͽ� ǥ�� ����(�������� ����)
--          �������� ��¥ ǥ�� ���
--          �ѱ� : �⵵4�ڸ�-��2�ڸ�-��2�ڸ� 
--          �̱� : ��2�ڸ�-��2�ڸ�-�⵵4�ڸ�

SELECT *
FROM emp;

-- �Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ
SELECT *
FROM emp
WHERE hiredate = '80/12/17';
-- ���󸶴� ǥ���ϴ� ����� �ٸ��⶧���� �����Ѵ� ���� �Ʒ�ó�� �����Ѵ�.
-- ���ڿ��� date Ÿ������ �����ϴ� �Լ� ��� (TO_DATE)
-- TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-- ��������
SELECT *
FROM emp;

-- sal�÷��� ���� 1000���� 2000������ ���
SELECT *
FROM emp
WHERE sal>=1000
AND sal<=2000
AND deptno = 30;

-- ���������ڸ� �ε�ȣ ��ſ� BETWEEN AND �����ڷ� ��ü
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;


--PT69
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD')AND TO_DATE('19830101','YYYYMMDD');


