--pt 69
-- where���� ����ϴ� ������ ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
-- sql�� ������ ������ �˰� �ִ�.(���� ������ ����.)
-- ���̺��� ������ ������� �ʴ´�.(SELECT ����� ������ �ٸ����� ���� �����ϸ� �������� �����Ѵ�.)
-- ���Ŀ� ���� �κ��� ORDER BY��� ������ �����Ѵ�.

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');

-- IN ������
-- Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
-- �μ���ȣ�� 10�� Ȥ��(OR) 20���� ���ϴ� ���� ��ȯ
SELECT ename, deptno
FROM emp
WHERE deptno IN (10, 20);

SELECT ename, deptno
FROM emp
WHERE deptno = 10 
OR deptno = 20;

--emp���̺��� ����̸��� SMITH, JONES�� ������ ��ȸ (empno, ename, deptno)
--OR �̶� AND �� ����!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';


SELECT *
FROM users;

--pt71
SELECT userid AS ���̵�, usernm AS �̸�, alias AS ����
FROM users
WHERE userid IN('brown','cony','sally');

--���ڿ� ��Ī ������ : LIKE, %, _
--������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
--�̸��� BR�� �����ϴ� ����� ��ȸ
--�̸��� R���ڿ��� ���� ����� ��ȸ

--��� �̸��� S�� �����ϴ� ��� ��ȸ
-- % � ���ڿ�(�ѱ���, ���� �������� �ְ�, ���� ���ڿ��� �ü��� �ִ�.)
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--���ڼ� ������ ���� ��Ī
--_��Ȯ�� �ѹ���
--���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5������ ����
SELECT *
FROM emp
WHERE ename LIKE 'S____';

--��� �̸��� S���ڰ� ���� �����ȸ
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--PT73
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE'��%';

--PT74
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

-- NULL �� ����(IS)
-- comm �÷��� ���� null�� �����͸� ��ȸ (WHERE comm IS NULL)
SELECT *
FROM emp
WHERE comm IS NULL;

-- PT76
SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT *
FROM emp
WHERE comm >=0;

--����� �����ڰ� 7698, 7839 �׸��� NULL�� �ƴ� ������ ��ȸ
--**NOT IN �����ڿ����� NULL�� ���� ��Ű�� �ȵȴ�!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN(7698, 7839)
AND mgr IS NOT NULL;

--PT80 _7
SELECT *
FROM emp
WHERE job ='SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT81_8
SELECT *
FROM emp
WHERE DEPTNO != 10
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT82_9
SELECT *
FROM emp
WHERE DEPTNO NOT IN (10)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT83_10
SELECT *
FROM emp
WHERE deptno IN (20,30)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT84_11
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601','YYYYMMDD');

--PT85_12
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

--PT86_13
SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR (empno >=7800 AND empno <7900);


-- ������ �켱����
-- */ �����ڰ� +,-���� �켱������ ����
-- �켱���� ���� : ()
-- AND > OR

-- emp ���̺��� ��� �̸��� SMITH �̰ų� 
--               ��� �̸��� ALLEN �̸鼭 �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename = 'SMITH' 
OR (ename = 'ALLEN' AND job ='SALESMAN');

-- ��� �̸��� SMITH�̰ų� ALLEN�̸鼭 
-- �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--PT90 WHERE14
SELECT *
FROM emp
WHERE job='SALESMAN' 
OR ((empno >=7800 AND empno <7900) AND hiredate >= TO_DATE('19810601','YYYYMMDD'));

-- ����
-- SELECT *
-- FROM table
-- [WHERE]
-- ORDER BY {�÷�|��Ī|�÷��ε��� [ASC || DESC], ...}

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ�ϼ���.
SELECT *
FROM emp
ORDER BY ename;

-- emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ�ϼ���.

SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp; -- DESC : DESCRIBE
--ORDER BY ename DESC; -- DESC : DESCENDING (����)

--emp ���̺��� ��� ������ ename �÷����� ��������, ename���� ������� mgr �÷����� �������� ����
SELECT *
FROM emp
ORDER BY ename DESC, mgr;

-- ���Ľ� ��Ī�� ���
SELECT empno, ename AS nm
FROM emp
ORDER BY nm;

SELECT empno, ename AS nm, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

-- �÷� �ε����� ����
-- java array[0]
-- SQL COLUMN INDEX : 1���� ����
SELECT empno, ename AS nm, sal*12 AS year_sal
FROM emp
ORDER BY 3;


--PT95 ORDERBTY 1
SELECT *
FROM dept;

SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--PT96
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE comm IS NOT NULL AND comm !=0
ORDER BY comm DESC, empno;

--PT97
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;


