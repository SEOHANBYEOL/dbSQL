--SUB4
--dept���̺��� 5���� �����Ͱ� ����
--emp���Ը����� 14���� ������ �ְ�, ������ �ϳ��� �μ� ���� �ִ�.(deptno)
--�μ� �� ������ ���� ���� ���� �μ� ������ ��ȸ
--������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�

SELECT *
FROM dept
WHERE deptno NOT IN (SELECT deptno
                    FROM emp);         

--SUB5
SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT *
FROM product
WHERE PID NOT IN (SELECT PID
                FROM cycle
                WHERE cid = 1);
                
--SUB6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN(SELECT pid
            FROM cycle
            WHERE cid=2);

 
 
--SUB7

SELECT *
FROM customer;
 
SELECT *
FROM product;
 
--ORACLE
SELECT customer.cid,customer.cnm,product.pid,product.pnm,a.day,a.cnt
FROM    
    (SELECT *
     FROM cycle
     WHERE cid = 1
     AND pid IN(SELECT pid
                FROM cycle
                WHERE cid=2))a, customer,product
WHERE a.cid = customer.cid
AND a.pid = product.pid;
                
                
--ANSI              
SELECT customer.cid,customer.cnm,product.pid,product.pnm,a.day,a.cnt
FROM    
    (SELECT *
     FROM cycle
     WHERE cid = 1
     AND pid IN(SELECT pid
                FROM cycle
                WHERE cid=2))a JOIN customer ON (a.cid = customer.cid)
                                JOIN product ON (a.pid = product.pid);
                                


--sub7
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN(SELECT pid
                FROM cycle
                WHERE cid=2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

--�Ŵ����� �����ϴ� ������ ��ȸ(king�� ������ 13���� �����Ͱ� ��ȸ)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������
--�ٸ� �����ڿ� �ٸ��� WHERE���� �÷��� ������� �ʴ´�
-- WHERE empno=7369
-- WHERE EXISTS (SELECT 'X'
--                FROM ...);
--�Ŵ����� �����ϴ� ������ EXIST�����ڸ� ���� ��ȸ
--�Ŵ����� ����

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
                
                
--pt275
SELECT *
FROM cycle ;

SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle 
              WHERE cid = 1
              AND product.PID = cycle.PID);
              
--sub10
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle 
              WHERE cid = 1
              AND product.PID = cycle.PID);   
              
--���տ���
--������ : UNION - �ߺ�����(���հ���) /UNION ALL -�ߺ��� �������� ���� (�ӵ� ���)
--������ : INTERSECT (���հ���)
--������ : MINUS (���հ���)
--���տ��� �������
--�� ������ �÷��� ����, Ÿ���� ��ġ �ؾ� �Ѵ�.

--������ ������ �������ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


--UNION ALL �����ڴ� UNION �����ڿ� �ٸ��� �ߺ��� ����Ѵ�.
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--INTERSECT(������) : ��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--MINUS(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--������ ��� ������ ������ ���� ���� ������
--A UNION B =               B UNION A       ==>����
--A UNION ALL B             B UNION ALL A   ==>����(����)
--A INTERSECT B             B INTERSECT A   ==>����
--A MINUS B                 B MINUS A       ==>�ٸ�

--���� ������ ��� �÷� �̸��� ù��° ������ �÷����� ������
SELECT 'X' fir, 'B' sec
FROM dual

UNION

SELECT 'Y','A'
FROM dual;

--����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ���
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION 

SELECT *
FROM dept
WHERE deptno IN (30,40)
ORDER BY deptno;



--�ܹ��� ���� ��������;
SELECT *
FROM fastfood;

--�õ�, �ñ���, ��������
--�õ��� �Ƶ�����+kfc+����ŷ /�Ե�����
--�������� ���� ���� ���ð� ���� �������� ����

    
    SELECT sido, sigungu, count(*)
    FROM fastfood
    WHERE gb = '�Ƶ�����' OR gb = 'KFC' OR gb = '����ŷ'
    GROUP BY sido, sigungu;
    
    SELECT sido, sigungu, count(*)
    FROM fastfood
    WHERE gb = '�Ե�����'
    GROUP BY sido, sigungu;
    
    
    SELECT ff.sido,ff.sigungu,ff.ct,lot.sido, lot.sigungu,lot.ct, ff.ct/lot.ct
    FROM (SELECT sido, sigungu, count(*)ct
          FROM fastfood
          WHERE gb = '�Ե�����'
          GROUP BY sido, sigungu)lot,
                                        (SELECT sido, sigungu, count(*)ct
                                        FROM fastfood
                                        WHERE gb = '�Ƶ�����' OR gb = 'KFC' OR gb = '����ŷ'
                                        GROUP BY sido, sigungu)ff
    WHERE ff.sido = lot.sido AND ff.sigungu = lot.sigungu;
    
   
  
    
    
    
    
    
    
    
    
    
    
        
        
