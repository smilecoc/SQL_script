--***********一些简单的SQL语句或者脚本汇总***********--


--1.截取字符串
	/****** SUBSTRING函数：返回字符、binary、text 或 image 表达式的一部分
	语法
	SUBSTRING ( expression , start , length )

	参数
	expression

	是字符串、二进制字符串、text、image、列或包含列的表达式。不要使用包含聚合函数的表达式。

	start

	是一个整数，指定子串的开始位置。

	length

	是一个整数，指定子串的长度（要返回的字符数或字节数）。
	******/

	/****** CHARINDEX 函数：从字符串中指定的位置处开始查找是否包含字符串，查找到则返回字符串出现的位置；反之，返回0
	语法
	CHARINDEX ( expression1 , expression2 [ , start_location ] )

	参数
		expression1 必需 ---要查找的子字符串
		expression2 必需 ---父字符串
		start_location 可选 ---指定从父字符串开始查找的位置，默认位置从1开始
	******/

SUBSTRING([ga_tracking], 
CHARINDEX('&utm_medium=',[ga_tracking])+12,
CHARINDEX('&utm_campaign=',[ga_tracking])-CHARINDEX('&utm_medium=',[ga_tracking])-12)

--2.删除，创建视图
drop view test
create view test as 



--3.防止除数为0的情况的发生

	/******NULLIF函数
	语法
　　NULLIF(Expression1,Expression2):给定两个参数Expression1和Expression2，如果两个参数相等，则返回NULL；否则就返回第一个参数。

　　等价于：Case WHEN Expression1=Expression2 Then NULL ELSE Expression1。

　　例如Select NULLIF(1,1)返回NULL，Select NULLIF(1,2)返回1。
	******/
[total_net_costrmb]/nullif(count_num,0) as est_spending


--4.使用top函数时有相同分数但因为排序问题导致取出后数据不全

	/******WITH TIES

　　与top()和order by 一起用，可以返回多于top的行。防止丢失想要的信息

	第一个语句只会取出三条数据,如果有其他数值相同的数据也不会取出
	下面的第二个语句会取出所有namez在前三的数据，
	******/

select top(3) * from table1 order by name desc
select top(3) with ties * from table1 order by name desc


--5.删除表中的行
	/******
	语法
	DELETE FROM table_name WHERE condition;
	******/
delete from art_test where [date]>'2020/5/20'


--6.增加列
	/******
	语法
	alter table table_name add column_name column_tpye 
	******/
alter table Students add Email varchar(16)

--7.修改列字段属性
	/******
	语法
	alter table table_name alter column column_name column_type 
	******/
alter table Students alter column Email varchar(255)

--8.更改字段名称
	/******
	SQL Server:
	sp_rename '表名.旧字段名','新字段名'

	其他：
	alter table table_name rename column oldname to newname
	******/

--9.删除列
	/******
	语法
	alter table table_name drop column column_name 
	******/
alter table Students drop column Email

--10.遇到字符串中有单引号
	/******
1、使用参数，比如SELECT * FROM yourTable WHERE name = @name;然后外部传入参数@name

2、如果不用参数，而用字符串拼接的话，单引号必须经过判断并替换，
	在数据库中，用2个单引号代表1个实际的单引号,如下例
	******/
select *  From Students Where name='children''s day'

--11.添加/删除约束
	--添加主键约束
	alter table 表名
	add constraint 约束名 primary key (列名)

	--添加唯一约束
	alter table 表名
	add constraint 约束名 unique (列名)

    --添加多列联合唯一约束
	alter table 表名 add constraint 约束名 unique (列名1,列名2) 

	--添加默认约束：没有显式给指定的列赋值，那么把默认约束值插入到该列中
	alter table 表名
	add constraint 约束名 default(内容) for 列名

	--添加check约束
	alter table 表名
	add constraint 约束名 check(内容)

	--添加外键约束
	alter table 表名
	add constraint 约束名 foreign key(列名) references 另一表名(列名)

	--删除约束
	alter table 表名
	drop constraint 约束名


--12.清空数据表里的数据而保留数据表结构
	TRUNCATE TABLE dbo.cpc_daily_tracking


--13.当字符串为中文字符是可能会出现乱码导致结果和判断错误，解决方法为在字符串前加n
select * from test where sp_position like N'%视频%'


--14.创建存储过程，同时会先判断存储过程是否已存在于当前的数据库中
if (exists (select * from sys.objects where name = 'proc_get_student'))
    drop proc adi_buying_KPI
go
create proc adi_buying_KPI
as
exec sp_refreshview adi_digital_dim_pp


--15.查看是否有符合条件的记录
if EXISTS (select left([ga_ad_content],charindex('?',[ga_ad_content])-1) as ga_adcontent_stan from [dbo].[adi_digital_fact_ga])
THEN  Print 'Record exits - Update'
ELSE  Print 'Record doesn''t exist - Insert'