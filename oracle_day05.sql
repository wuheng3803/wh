视图VIEW
视图是数据库对象之一，在SQL语句中
体现的角色与表一致。但是视图并非一张
真实存在的表，它只是一个查询语句对应
的结果集。
CREATE VIEW v_emp_10
AS
SELECT empno, ename, sal, deptno 
FROM emp 
WHERE deptno = 10

DESC v_emp_10

SELECT * FROM v_emp_10

视图对应的子查询中的字段可以指定别名，
这样该视图对应的字段名就是这个别名。
当一个字段是函数或者表达式，那么该字段
必须指定别名
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10



视图根据对应的子查询不同，分为简单视图
和复杂视图
简单视图:对应的子查询不含有函数，表达式，
分组，去重，关联查询。
除了简单视图就是复杂视图

简单视图可以进行DML操作，对该视图的操作
就是对该视图数据来源的基础表进行的操作。
复杂视图不允许进行DML操作。
对简单视图进行DML操作也不能违反基础表的
约束条件。
对视图进行DML操作，视图对基础表操作时，
只能对视图可见的字段进行。

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


对视图的不当DML操作会污染基表数据
即:对视图进行DML操作后，视图对基础表
对应数据进行该DML操作，但是操作后视图
却对该记录不可见。
INSERT INTO v_emp_10
(id,name,salary,deptno)
VALUES
(1001,'JACK',3000,20)

UPDATE v_emp_10
SET deptno=20

DELETE不会产生污染现象。
DELETE FROM v_emp_10
WHERE deptno=20

为视图添加检查选项，可以避免对视图操作
而导致的对基表的数据污染。
WITH CHECK OPTION
该选项要求对视图进行DML操作后，该记录
必须对视图可见。

CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH CHECK OPTION

只读选项
WITH READ ONLY
只读选项要求对视图仅能进行查询操作
不能进行任何DML操作。
CREATE OR REPLACE VIEW v_emp_10
AS
SELECT empno id,ename name,
       sal salary,deptno
FROM emp
WHERE deptno=10
WITH READ ONLY


常用的数据库的数据字典
USER_OBJECTS：记录用户创建过的所有数据库对象
SELECT object_name,object_type 
FROM user_objects
WHERE object_type='VIEW'
AND object_name LIKE '%FANCQ'

USER_VIEWS:专门记录曾经创建过的视图信息
SELECT view_name,text
FROM user_views

USER_TABLES:专门记录曾经创建过的表的信息
SELECT table_name FROM user_tables

删除视图
DROP VIEW v_emp_10

创建复杂视图
创建一张视图，包含员工工资及相关部门信息
包含:每个部门的平均工资，最大，最小，工资总和，
以及对应的部门名称，部门编号。
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

查看哪些员工的工资高于其所在部门平均工资?
SELECT e.ename,e.sal,e.deptno
FROM emp e,v_emp_salinfo v
WHERE e.deptno=v.deptno
AND e.sal>v.avg_sal

SELECT * FROM v_emp_salinfo



序列SEQUENCE
序列是数据库对象之一，作用是根据指定的
规则生成一系列数字。通常使用序列生成的
数字是为表中的主键字段提供值使用。

CREATE SEQUENCE seq_emp_id
START WITH 1
INCREMENT BY 1

序列支持两个伪列:
NEXTVAL:获取序列的下一个数字，如果是新
创建的序列，那么会从START WITH开始返回。
之后则是用上次生成的数字加上步长来得到
本次生成的数字返回。
需要注意，序列是不能后退的。并且不受事务
控制。

CURRVAL:获取序列最后生成的数字，新创建的
序列至少调用NEXTVAL生成一个数字后才可以
使用。CURRVAL不会导致序列步进。
SELECT seq_emp_id.NEXTVAL
FROM dual

SELECT seq_emp_id.CURRVAL
FROM dual

使用序列为EMP表主键字段提供值:
INSERT INTO emp
(empno,ename,job,sal,deptno)
VALUES
(seq_emp_id.NEXTVAL,'JACK','CLERK',3000,10)

SELECT * FROM emp

删除一个序列
DROP SEQUENCE seq_emp_id

序列的数据字典
SELECT * FROM USER_SEQUENCES



索引INDEX
索引是数据库对象之一，作用是提高查询效率
索引的创建时是数据库自行完成的，并且数据库
会在适当的时候自动使用索引。

CREATE INDEX idx_emp_ename 
ON emp(ename)

经常出现在WHERE中和ORDER BY中的字段
要添加索引。
经常出现在DISTINCT后面的字段也可以添加
索引。
需要注意，对于字符串类型字段，若在WHERE
中使用LIKE进行过滤时，是不会用到索引的。


约束

唯一性约束
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


主键约束
一张表只能有一个字段定义主键约束，主键
约束要求该字段非空且唯一
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











