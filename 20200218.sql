--�ǽ� h_2
SELECT level, dept_h.deptcd, lpad(' ',(LEVEL-1)*4, ' ') || deptnm,P_DEPTCD
FROM dept_h
START WITH deptcd = 'dept0_02' 
CONNECT BY PRIOR deptcd = p_deptcd;

--LPAD(���ڿ�, ��ü����, ������ ���̸�ŭ ä�� ����)
--LPAD(���ڿ�, ��ü����)

--����� ���� ���� (leaf --> root node(���� node))
--��ü ��带 �湮�ϴ°� �ƴ϶� �ڽ��� �θ��常 �湮�Ѵ�.(����İ� �ٸ���)

--������ : ��������
--������ : �����μ�

SELECT dept_h.*, LPAD(' ',(LEVEL-1)*4)|| deptnm
FROM dept_h
START WITH deptnm = '��������'
CONNECT BY PRIOR p_deptcd = deptcd;



create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT *
FROM h_sum;


--h_4
SELECT lpad(' ',(LEVEL-1)*4, ' ') ||h_sum.s_id s_id, h_sum.value
FROM h_sum
START WITH s_id = '0' 
CONNECT BY PRIOR s_id = ps_id;






create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);


commit;
--h_5

SELECT lpad(' ',(LEVEL-1)*4, ' ')||no_emp.org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


--������ ���� �� ���� ���� ��� ��ġ�� ���� ��� ��(pruning branch - ����ġ��)
--FROM -> START WITH, CONNECT BY --> WHERE 
--1. WHERE : ���� ������ �ϰ� ���� ���� ����
--2. CONNECT BY : ���� ������ �ϴ� �������� ���� ����

--WHERE�� ����� : �� 9���� ���� ��ȸ
SELECT lpad(' ',(LEVEL-1)*4, ' ')||no_emp.org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--WHERE�� (org_cd != '������ȹ��') : �� 8���� ���� ��ȸ
SELECT lpad(' ',(LEVEL-1)*4, ' ')||no_emp.org_cd org_cd, no_emp
FROM no_emp
WHERE org_cd != '������ȹ��'
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--CONNECT BY ���� ������ ��� : �� 6���� ���� ��ȸ
SELECT lpad(' ',(LEVEL-1)*4, ' ')||no_emp.org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd
AND org_cd != '������ȹ��';


--CONNECT_BY_ROOT(�÷�) : �ش� �÷��� �ֻ��� ���� ���� ����
--SYS_CONNECT_BY_PATH(�÷�, ������) : �ش� ���� �÷��� ���Ŀ� �÷� ���� ����, �����ڷ� �̾��ش�.
--CONNECT_BY_ISLEAF : �ش� ���� LEAF������� (����� �ڽ��� ������) ���� ���� (1: leaf, 0:no leaf) ������ ��� -> 1
SELECT lpad(' ',(LEVEL-1)*4, ' ')||no_emp.org_cd org_cd, no_emp,
        CONNECT_BY_ROOT(org_cd) root, 
        LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'), '-') path,
        CONNECT_BY_ISLEAF leaf        
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;




create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;



--�ǽ� h6

SELECT seq, lpad(' ',(LEVEL-1)*4, ' ')||title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;


--�ǽ� h7
SELECT seq, lpad(' ',(LEVEL-1)*4, ' ')||title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;


--�ǽ� h8
--���������� ����
--ORDER SIBLINGS BY 


SELECT seq, lpad(' ',(LEVEL-1)*4, ' ')||title title, parent_seq
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;




SELECT seq, lpad(' ',(LEVEL-1)*4, ' ')||title title, parent_seq
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--�׷��ȣ�� ������ �÷��� �߰�
ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN(4,5,6,7,8,10,11);

UPDATE board_test SET gn = 2
WHERE seq IN(2,3);

UPDATE board_test SET gn = 3
WHERE seq IN(1,9);

COMMIT;

SELECT gn, seq, LPAD(' ',(LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;


--subquery : ���� �ְ����� �޴� ���
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal)
            FROM emp);
            

--GROUP �Լ��� ���� : GROUP BY ���� ������������ �ٸ����� ������ �� ����.
--SELECT ename, MAX(sal)
--FROM emp;


SELECT *
FROM emp;

SELECT a.*,rownum sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (10)
order by deptno, sal DESC) a

UNION ALL

SELECT a.*,rownum sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (20)
order by deptno, sal DESC) a            

UNION ALL

SELECT a.*,rownum sal_rank
FROM
(SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (30)
order by deptno, sal DESC) a;





SELECT *
FROM
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno)b,
(SELECT LEVEL lv
FROM dual
CONNECT BY level <= 14)a
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv