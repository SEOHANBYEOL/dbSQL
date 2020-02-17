--:dt ==> 202002;

SELECT DECODE (d,1,iw+1, iw)i,
        MIN(DECODE(d,1,dt)) sun,
        MIN(DECODE(d,2,dt)) mon,
        MIN(DECODE(d,3,dt)) tue,
        MIN(DECODE(d,4,dt)) wed,
        MIN(DECODE(d,5,dt)) tur,
        MIN(DECODE(d,6,dt)) fri,
        MIN(DECODE(d,7,dt)) sat
FROM
    (SELECT TO_DATE(:dt, 'yyyymm') +(LEVEL-1) dt,
            TO_CHAR(TO_DATE(:dt, 'yyyymm') +(LEVEL-1),'D')d, 
            TO_CHAR(TO_DATE(:dt, 'yyyymm') +(LEVEL-1),'iw')iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'DD'))
    GROUP BY DECODE (d,1,iw+1, iw)
    ORDER BY DECODE (d,1,iw+1, iw);
    
    --1. �ش� ���� 1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
    --2. �ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ�
    --3 2-1�� �Ͽ� �� �ϼ����ϱ�
    
    
    
    SELECT NEXT_DAY(TO_DATE(:dt,'yyyymm'),1)-7 ,NEXT_DAY(LAST_DAY(TO_DATE(:dt,'yyyymm')),7)
    FROM dual;
    
 
 
--���� : �������� 1��, ��������¥ : �ش���� ������ ����;
 SELECT TO_DATE('202002','YYYYMM')+(LEVEL-1)
 FROM dual
 CONNECT BY LEVEL <=29;
 
--���� : �������� : �ش���� 1���ڰ� ���� ���� �Ͽ���
--      ��������¥ : �ش���� ���������ڰ� ���� ���� �����

SELECT TO_DATE('20200126','YYYYMMDD')+(LEVEL-1)
FROM dual
CONNECT BY LEVEL <=35;
 
 
 
 
 --����
 
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);    
    
    --1. �ش� ���� 1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
    --2. �ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ�
    --3 2-1�� �Ͽ� �� �ϼ����ϱ�
    
     
    SELECT NEXT_DAY(TO_DATE(:dt,'yyyymm'),1)-7 ,
            NEXT_DAY(LAST_DAY(TO_DATE(:dt,'yyyymm')),7) ,
            (NEXT_DAY(LAST_DAY(TO_DATE(:dt,'yyyymm')),7))-(NEXT_DAY(TO_DATE(:dt,'yyyymm'),1)-7)+1
        FROM dual;
 
 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;    






create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;




--1.dt(����) ->��, �������� sum(sales) --> ���� ����ŭ ���� ���������.
SELECT SUM(jan) jan, SUM(feb) feb, nvl(SUM(mar),0) mar, SUM(apr) apr, SUM(may) may, SUM(jun) jun
FROM
(SELECT DECODE(TO_CHAR(dt,'MM'),'01',SUM(SALES)) JAN,
       DECODE(TO_CHAR(dt,'MM'),'02',SUM(SALES)) FEB,
       DECODE(TO_CHAR(dt,'MM'),'03',SUM(SALES)) MAR,
       DECODE(TO_CHAR(dt,'MM'),'04',SUM(SALES)) APR,
       DECODE(TO_CHAR(dt,'MM'),'05',SUM(SALES)) MAY,
       DECODE(TO_CHAR(dt,'MM'),'06',SUM(SALES)) JUN
FROM sales
GROUP BY TO_CHAR(dt,'MM'));




--����������--
create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

commit;

SELECT *
FROM dept_h;

--����Ŭ ���� �� ���� ����
--SELECT ..
--FROM ..
--WHERE
--START WITH ���� : � ���� ���������� ������ 

--CONNECT BY ��� ���� �����ϴ� ����
--          PRIOR : �̹� ���� ��, 
--          "   " : ������ ���� ��
--����� : ���� �������� �ڽ� ���� ���� ( �� --> �Ʒ�);
--XXȸ�� (�ֻ��� ����)���� �����Ͽ� ���� �μ��� �������� ���� ����;

SELECT *
FROM dept_h
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd; -- ��� �࿡ ���� ���� ����(PRIOR XXȸ�� - 3���� ��(�����κ�, ������ȹ��, �����ý��ۺ�)


--START WITH deptnm = 'XXȸ��'
--START WITH p_deptcd IS NULL

--prior XXȸ��.deptcd = �����κ�.p_deptcd
--prior �����κ�.p_deptcd = ��������. p_deptcd

--prior XXȸ��.deptcd = ������ȹ��.p_deptcd
--prior ������ȹ��.deptcd = ��ȹ��.p_deptcd
--prior ��ȹ��.deptcd = ��ȹ��Ʈ.p_dept_cd

--prior xxȸ��. deptcd = �����ý��ۺ�.p_deptcd (���� 1��, ����2��)
--prior �����ý��ۺ�.p_deptcd = ���� 1��.p_deptcd
--prior ���� 1��.p_deptcd != ...
--prior �����ý��ۺ�.p_deptcd = ���� 2��.p_deptcd
--prior ���� 2��.p_deptcd != ...

 
 
 SELECT LPAD(' ' ,4,'*')
 FROM dual;
 
--LPAD�Լ� �̿��ϱ�
SELECT dept_h.*, level, lpad(' ',(LEVEL-1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0' 
CONNECT BY PRIOR deptcd = p_deptcd;

--CONNECT BY p_deptcd = PRIOR deptcd; <-- �̷��� �ᵵ��




 
 --201912 //������ �Ͽ��ϱ��ؼ�/....?..
 
SELECT DECODE (d,1,iw+1, iw)i,
        MIN(DECODE(d,1,dt)) sun,
        MIN(DECODE(d,2,dt)) mon,
        MIN(DECODE(d,3,dt)) tue,
        MIN(DECODE(d,4,dt)) wed,
        MIN(DECODE(d,5,dt)) tur,
        MIN(DECODE(d,6,dt)) fri,
        MIN(DECODE(d,7,dt)) sat
FROM
    (SELECT TO_DATE(:dt, 'yyyymm') +(LEVEL-1) dt,
            TO_CHAR(TO_DATE(:dt, 'yyyymm') +(LEVEL-1),'D')d, 
            TO_CHAR(TO_DATE(:dt, 'yyyymm') +(LEVEL-1),'iw')iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'DD'))
    GROUP BY DECODE (d,1,iw+1, iw)
    ORDER BY DECODE (d,1,iw+1, iw);
    
    
