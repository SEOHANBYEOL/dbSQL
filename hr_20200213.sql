SELECT *
FROM hb.v_emp;

--synonym 생성전에는 실행이 안됨
SELECT *
FROM v_emp;

--synonym 생성
CREATE SYNONYM v_emp FOR hb.v_emp;

--synonym 생성후 실행 됨
SELECT *
FROM hb.v_emp;

