SELECT *
FROM hb.v_emp;

--synonym ���������� ������ �ȵ�
SELECT *
FROM v_emp;

--synonym ����
CREATE SYNONYM v_emp FOR hb.v_emp;

--synonym ������ ���� ��
SELECT *
FROM hb.v_emp;

