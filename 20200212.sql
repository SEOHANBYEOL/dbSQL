-- table full
-- index 1 : empno
-- index 2 : job
 
 
 explain plan for
 SELECT * 
 FROM emp 
 WHERE job = 'MANAGER'
 AND ename LIKE ('C%');
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 CREATE INDEX idx_n_emp_03 ON emp(job, ename);
 
 explain plan for
 SELECT *
 FROM emp
 WHERE job= 'MANAGER'
 AND ename LIKE ('C%');
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 --1. TABLE FULL
 --2. INDEX 1 : EMPNO
 --3. INDEX 2 : JOB
 --4. INDEX 3 : JOB + ENAME
 --5. INDEX 4 : ENAME +JOB
 
 --3��° �ε����� ������
 --3��°�� 4��°�� �÷������� �����ϰ� ������ �ٸ��� ���� 
 
DROP INDEX idx_n_emp_03;
 CREATE INDEX idx_n_emp_04 ON emp(ename, job);
 
 SELECT ename, job, rowid
 FROM emp
 ORDER BY ename, job;
 
 explain plan for
 SELECT * 
 FROM emp 
 WHERE job = 'MANAGER'
 AND ename LIKE ('C%');
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 -- emp-table full, pk_emp(empno)
 -- dept- table full, pk_dept(deptno)
 -- emp = table full dept- table full
 -- emp table full dept pk_dept
 -- emp pk_emp, dept- talbe full
 -- emp pk_emp, dept-pk-dept
 
-- 1 ����

--2�� ���̺� ����
--������ ���̺� �ε��� 5���� �ִٸ�
--�����̺� ���� ���� : 6

--36 * 2 = 72

 --ORACLE - �ǽð� ���� : OLTP ( ON LINE TRANSACTION PROCESSING )
         -- ��ü ó�� �ð� : OLAP( ON LINE ANALYES PROCESSING ) - ������ ������ �����ȹ�� ����µ� 30M~1H
 
 
 -- emp���� ������ dept���� ������?
 explain plan for
 SELECT ename, dname, loc
 FROM emp, dept
 WHERE emp.empno = 7788
 AND emp.deptno = dept.deptno;
 
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 
 
 --CTAS
 --�������� ���簡 NOT NULL�� �ȴ�.
 --����̳� �׽�Ʈ��
 

 CREATE TABLE dept_test2 AS 
 SELECT * FROM dept WHERE 1 = 1;
 
 
 CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
 CREATE INDEX idx_u_dept_test2_02 ON dept_test2(dname);
 CREATE INDEX idx_n_dept_test2_03 ON dept_test2(deptno, dname);


 DROP INDEX idx_u_dept_test2_01;
 DROP INDEX idx_u_dept_test2_02;
 DROP INDEX idx_n_dept_test2_03;
 
 
 
 
CREATE TABLE emp2 AS 
SELECT * FROM emp WHERE 1 = 1;
 
CREATE TABLE dept2 AS 
SELECT * FROM dept WHERE 1 = 1;
 



--�ǽ� idx3

--empno(=)

--enmae(=)

--deptno(=), empno(LIKE ������ȣ%)

--deptno(=), sal(BETWWNE)

--deptno(=) /mgr �����ϸ� ����,
--empno(=) <-�����ֳ�

--deptno, hiredate�� �ε����� �����ϸ� ����




--empno(=)
--enmae(=)
--deptno(=), empno(LIKE ������ȣ%) ==> empno, deptno <-ù��°�Ͱ� �ε������غ��� ù��°�� �������ǳ� 
--deptno(=), sal(BETWWNE)
--deptno(=) / mgr �����ϸ� ����,
--deptno, hiredate�� �ε����� �����ϸ� ����



--enmae(=)
--deptno(=), empno(LIKE ������ȣ%) ==> empno, deptno <-ù��°�Ͱ� �ε������غ��� ù��°�� �������ǳ� 
--deptno(=), sal(BETWWNE)
--deptno(=) / mgr �����ϸ� ����,
--deptno, hiredate�� �ε����� �����ϸ� ����

--deptno, sal, mgr, hiredate



--enmae(=)
--deptno(=), empno(LIKE ������ȣ%) ==> empno, deptno <-ù��°�Ͱ� �ε������غ��� ù��°�� �������ǳ� 
--deptno, sal, mgr, hiredate





--�ǽ� idx4
--empno(=)
--

 
 
 
 
 
 
 
 