��ͼVIEW
��ͼ�����ݿ����֮һ����SQL�����
���ֵĽ�ɫ���һ�¡�������ͼ����һ��
��ʵ���ڵı���ֻ��һ����ѯ����Ӧ
�Ľ������
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10

DESC v_emp_10

SELECT * FROM v_emp_10

��ͼ��Ӧ���Ӳ�ѯ�е��ֶο���ָ��������
��������ͼ��Ӧ���ֶ����������������
��һ���ֶ��Ǻ������߱��ʽ����ô���ֶ�
����ָ������
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10



��ͼ���ݶ�Ӧ���Ӳ�ѯ��ͬ����Ϊ����ͼ
�͸�����ͼ
����ͼ:��Ӧ���Ӳ�ѯ�����к��������ʽ��
���飬ȥ�أ�������ѯ��
���˼���ͼ���Ǹ�����ͼ

����ͼ���Խ���DML�������Ը���ͼ�Ĳ���
���ǶԸ���ͼ������Դ�Ļ�������еĲ�����
������ͼ���������DML������
�Լ���ͼ����DML����Ҳ����Υ���������
Լ��������
����ͼ����DML��������ͼ�Ի��������ʱ��
ֻ�ܶ���ͼ�ɼ����ֶν��С�

INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',3000,10)

SELECT * FROM v_emp_10
SELECT * FROM emp

UPDATE v_emp_10
SET salary=4000
WHERE id=1001

DELETE FROM v_emp_10
WHERE id=1001


����ͼ�Ĳ���DML��������Ⱦ��������
��:����ͼ����DML��������ͼ�Ի�����
��Ӧ���ݽ��и�DML���������ǲ�������ͼ
ȴ�Ըü�¼���ɼ���
INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',3000,20)

UPDATE v_emp_10
SET deptno=20

DELETE���������Ⱦ����
DELETE FROM v_emp_10
WHERE deptno=20

Ϊ��ͼ��Ӽ��ѡ����Ա������ͼ����
�����µĶԻ����������Ⱦ��
WITH CHECK OPTION
��ѡ��Ҫ�����ͼ����DML�����󣬸ü�¼
�������ͼ�ɼ���

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION

ֻ��ѡ��
WITH READ ONLY
ֻ��ѡ��Ҫ�����ͼ���ܽ��в�ѯ����
���ܽ����κ�DML������
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY


���õ����ݿ�������ֵ�
USER_OBJECTS����¼�û����������������ݿ����
SELECT object_name,object_type 
FROM user_objects
WHERE object_type='VIEW'
AND object_name LIKE '%FANCQ'

USER_VIEWS:ר�ż�¼��������������ͼ��Ϣ
SELECT view_name,text
FROM user_views

USER_TABLES:ר�ż�¼�����������ı����Ϣ
SELECT table_name FROM user_tables

ɾ����ͼ
DROP VIEW v_emp_10

����������ͼ
����һ����ͼ������Ա�����ʼ���ز�����Ϣ
����:ÿ�����ŵ�ƽ�����ʣ������С�������ܺͣ�
�Լ���Ӧ�Ĳ������ƣ����ű�š�
CREATE OR REPLACE VIEW v_emp_salinfo
AS
SELECT AVG(e.sal) avg_sal,
       MAX(e.sal) max_sal,
       MIN(e.sal) min_sal,
       SUM(e.sal) sum_sal,
       d.deptno,d.dname,d.loc
FROM emp e,dept d
WHERE e.deptno=d.deptno
GROUP BY d.deptno,d.dname,d.loc

�鿴��ЩԱ���Ĺ��ʸ��������ڲ���ƽ������?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_emp_salinfo v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

SELECT * FROM v_emp_salinfo



����SEQUENCE
���������ݿ����֮һ�������Ǹ���ָ����
��������һϵ�����֡�ͨ��ʹ���������ɵ�
������Ϊ���е������ֶ��ṩֵʹ�á�

CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

����֧������α��:
NEXTVAL:��ȡ���е���һ�����֣��������
���������У���ô���START WITH��ʼ���ء�
֮���������ϴ����ɵ����ּ��ϲ������õ�
�������ɵ����ַ��ء�
��Ҫע�⣬�����ǲ��ܺ��˵ġ����Ҳ�������
���ơ�

CURRVAL:��ȡ����������ɵ����֣��´�����
�������ٵ���NEXTVAL����һ�����ֺ�ſ���
ʹ�á�CURRVAL���ᵼ�����в�����
SELECT seq_emp_id.NEXTVAL
FROM dual

SELECT seq_emp_id.CURRVAL
FROM dual

ʹ������ΪEMP�������ֶ��ṩֵ:
INSERT INTO emp
(empno,ename,job,sal,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK','CLERK',3000,10)

SELECT * FROM emp

ɾ��һ������
DROP SEQUENCE seq_emp_id

���е������ֵ�
SELECT * FROM USER_SEQUENCES



����INDEX
���������ݿ����֮һ����������߲�ѯЧ��
�����Ĵ���ʱ�����ݿ�������ɵģ��������ݿ�
�����ʵ���ʱ���Զ�ʹ��������

CREATE INDEX idx_emp_ename 
ON emp(ename)

����������WHERE�к�ORDER BY�е��ֶ�
Ҫ���������
����������DISTINCT������ֶ�Ҳ�������
������
��Ҫע�⣬�����ַ��������ֶΣ�����WHERE
��ʹ��LIKE���й���ʱ���ǲ����õ������ġ�


Լ��

Ψһ��Լ��
CREATE TABLE employees2 (
  eid NUMBER(6) UNIQUE,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE,
  CONSTRAINT employees_email_uk UNIQUE(email)
)

INSERT INTO employees2
(eid,name,email)
VALUES
(NULL,'jack',NULL)

SELECT * FROM employees2


����Լ��
һ�ű�ֻ����һ���ֶζ�������Լ��������
Լ��Ҫ����ֶηǿ���Ψһ
CREATE TABLE employees3 (
  eid NUMBER(6) PRIMARY KEY,
  name VARCHAR2(30),
  email VARCHAR2(50),
  salary NUMBER(7, 2),
  hiredate DATE
)
INSERT INTO employees3
(eid,name,email)
VALUES
(2,'jack','jack@tedu.cn')











