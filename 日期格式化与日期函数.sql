--**********************日期的格式化与日期相关函数，操作****************--


--日期格式化
	/******
	1.CONVERT()函数

		语法
		CONVERT(data_type(length),date,style)，
		data_type(length) 规定目标数据类型（带有可选的长度）。date指需要转换的值。style 规定日期/时间的输出格式。

		其中常用的style代码及显示格式如下：
		101： mm/dd/yyyy
		110： mm-dd-yyyy
		111： yyyy/mm/dd
		112： yyyymmdd
		120： yyyy-mm-dd hh:mm:ss
		121： yyyy-mm-dd hh:mm:sssssss
		全部的代码可以参考:https://www.cnblogs.com/rainman/p/6558261.html
	******/

	--getdate()函数获取当前的日期与时间。返回的为datetime类型
	SELECT CONVERT(varchar(100), GETDATE(), 111)

	/******
	2.FORMAT()函数

		语法
		FORMAT(value,format[,culture])
		参数format用于指定显示的格式，给予用户对格式更自由地控制，culture参数是可选的，用于指定显示的语言，该函数返回值的数据类型是NVARCHAR，如果格式转换失败，该函数返回NULL
		参数format使用#表示一个数值，参数 format 使用以下占位符来表示日期/时间的格式：
			yyyy、MM、dd：表示年、月、日
			hh:mm:ss fffffff：表示时、分、秒、毫秒
			使用“/”，“-”等作为连接各个部分（part）的分割符号

	******/
	--SYSDATETIME()函数获取当前的日期与时间，但是返回的数据类型是DATETIME2，会更加精准
	select format(SYSDATETIME(),'yyyy-MM-dd hh:mm:ss fffffff')

	/******
	format()函数还可以转变数值类型，使用特定的格式展示等
	******/
	select FORMAT(123456789,'###-##-####') AS 'Custom Number Result'

--日期的拆分与拼接（构造）
	/******
	1.DATEPART() 函数：DATEPART() 函数用于返回日期/时间的单独部分，比如年、月、日、小时、分钟等等

	语法：
	DATEPART(datepart,date)
	date 参数是合法的日期表达式。datepart为需要取出的数据缩写代码datepart 
	参数可以是下列的值：
	quarter：季度，取值范围是 1、2、3、4
	week：周在年中的序数，取值范围是 1 - 53
	dayofyear：天在年中的序数，取值范围是 1 - 366
	weekday：天在一周中的序数，取值范围是 1 - 7
	https://www.w3school.com.cn/sql/func_datepart.asp
	******/

SELECT DATEPART(yyyy,GETDATE()) AS Year,
DATEPART(m,GETDATE()) AS Month,
DATEPART(quarter,GETDATE()) AS Quarter,
DATEPART(dayofyear,GETDATE()) AS daynumber


	/******
	2.YEAR(date),MONTH(date),DAY(date)等函数返回年，月，日
	******/

	/******
	3.DATENAME()函数，
	
	语法
	DATENAME(datepart,date)与DATEPART不同的地方在于返回字符类型
	******/

SELECT DATENAME(month, getdate()) AS 'Month'

	/******
	4.构造日期的函数，
	
	语法
	DATEFROMPARTS ( year, month, day )
	DATETIME2FROMPARTS ( year, month, day, hour, minute, seconds, fractions, precision ) 
	DATETIMEOFFSETFROMPARTS ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )
	TIMEFROMPARTS ( hour, minute, seconds, fractions, precision ) 
	参数precision 是指小数秒的精度，指的是DateTime2(n)、DateTimeOffset(n),Time(n)中的n值，表示以多少位小数表示1s
	******/

select DATEFROMPARTS ( 2020, 1, 2 )

--其他日期函数
	/******
	1.EOMonth()，
	
	语法：
	EOMONTH(start_date [,month_to_add])
	start_date： 有两种输入方式，能够转换为Date的字符串类型 和 date 数据类型
	month_to_add： 是int 类型，能够为正整数，负整数和0，默认值是0，如果省略，那么使用默认值0,表示月份的偏移量。

	******/

--查看当前月的最后一天、下一个月的最后一天、上一个月的最后一天
declare @date date
set @date=getdate()

select EOMONTH(@date) as CurrentMonth_EndDay,
    EOMONTH(@date,1) as NextMonth_EndDay,
    EOMONTH(@date,-1) as LastMonth_EndDay

	/******
	2.dateadd()函数

	语法：
	DATEADD(datepart,number,date)
	datepart是單位(年，月，天等)，number是指定的數值，date是原始日期
	如下例傳回的結果是当前时间的两个月后的日期，类型为datetime类型
	******/
	SELECT DATEADD(MONTH,2,getdate())

	/******
	3.获取月份的第一天
	根据上述两个函数我们还可以通过上个月的最后一天+1来获取第一天
	******/
select dateadd(day,1,EOMONTH(getdate(),-1)) as CurrentMonth_startDay

	/******
	同时也可以通过前面所说的日期拼接函数与format函数实现
	******/
declare @date date
set @date=getdate()

select DATEFROMPARTS(year(@date),month(@date),1) 

--or

select FORMAT(GETDATE(),'yyyy-MM-01')

	/******
	4.获取当前是周几：返回文本格式
	******/
	set LANGUAGE 'Simplified Chinese'
	select  DATENAME(WEEKDAY,getutcdate())

	set LANGUAGE 'us_english'
	select  DATENAME(WEEKDAY,getutcdate())


	/******
	5.DATEDIFF函数计算两个日期之间的间隔，传回带正负符号的整数

	语法：
	DATEDIFF(datepart,startdate,enddate)
	datepart为间隔的单位，startdate跟enddate为起始时间
	******/
SELECT DATEDIFF(DAY, '2010-10-03','2010-10-04'  )
