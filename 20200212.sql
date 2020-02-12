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
 
 --3번째 인덱스를 지우자
 --3번째와 4번째가 컬럼구성이 동일하고 순서만 다르기 때문 
 
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
 
-- 1 순서

--2개 테이블 조인
--각가의 테이블에 인덱스 5개씩 있다면
--한테이블에 접근 전략 : 6

--36 * 2 = 72

 --ORACLE - 실시간 응답 : OLTP ( ON LINE TRANSACTION PROCESSING )
         -- 전체 처리 시간 : OLAP( ON LINE ANALYES PROCESSING ) - 복잡한 쿼리의 실행계획을 세우는데 30M~1H
 
 
 -- emp부터 읽을까 dept부터 읽을까?
 explain plan for
 SELECT ename, dname, loc
 FROM emp, dept
 WHERE emp.empno = 7788
 AND emp.deptno = dept.deptno;
 
 
 SELECT *
 FROM TABLE(dbms_xplan.display);
 
 
 
 --CTAS
 --제약조건 복사가 NOT NULL만 된다.
 --백업이나 테스트용
 

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
 



--실습 idx3

--empno(=)

--enmae(=)

--deptno(=), empno(LIKE 직원번호%)

--deptno(=), sal(BETWWNE)

--deptno(=) /mgr 동방하면 유리,
--empno(=) <-위에있네

--deptno, hiredate가 인덱스에 존재하면 유리




--empno(=)
--enmae(=)
--deptno(=), empno(LIKE 직원번호%) ==> empno, deptno <-첫번째것과 인덱스비교해보면 첫번째것 지워도되네 
--deptno(=), sal(BETWWNE)
--deptno(=) / mgr 동방하면 유리,
--deptno, hiredate가 인덱스에 존재하면 유리



--enmae(=)
--deptno(=), empno(LIKE 직원번호%) ==> empno, deptno <-첫번째것과 인덱스비교해보면 첫번째것 지워도되네 
--deptno(=), sal(BETWWNE)
--deptno(=) / mgr 동방하면 유리,
--deptno, hiredate가 인덱스에 존재하면 유리

--deptno, sal, mgr, hiredate



--enmae(=)
--deptno(=), empno(LIKE 직원번호%) ==> empno, deptno <-첫번째것과 인덱스비교해보면 첫번째것 지워도되네 
--deptno, sal, mgr, hiredate





--실습 idx4
--empno(=)
--

 
 
 
 
 
 
 
 