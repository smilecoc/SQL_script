--如果存在则删除原有函数 
IF OBJECT_ID(N'dbo.RegexReplace') IS NOT NULL
 DROP FUNCTION dbo.RegexReplace 
GO 
--开始创建正则替换函数 
 CREATE FUNCTION dbo.RegexReplace 
( 
 @string VARCHAR(MAX), --被替换的字符串 
 @pattern VARCHAR(255), --替换模板 
 @replacestr VARCHAR(255), --替换后的字符串 
 @IgnoreCase INT = 0 --0区分大小写 1不区分大小写 
) 
RETURNS VARCHAR(8000) 
AS
BEGIN
 DECLARE @objRegex INT, @retstr VARCHAR(8000) 
 --创建对象 
 EXEC sp_OACreate 'VBScript.RegExp', @objRegex OUT
 --设置属性 
 EXEC sp_OASetProperty @objRegex, 'Pattern', @pattern 
 EXEC sp_OASetProperty @objRegex, 'IgnoreCase', @IgnoreCase 
 EXEC sp_OASetProperty @objRegex, 'Global', 1 
 --执行 
 EXEC sp_OAMethod @objRegex, 'Replace', @retstr OUT, @string, @replacestr 
 --释放 
 EXECUTE sp_OADestroy @objRegex 
 RETURN @retstr 
END
GO 
--保证正常运行的话，需要将Ole Automation Procedures选项置为1 
EXEC sp_configure 'show advanced options', 1 
RECONFIGURE WITH OVERRIDE 
EXEC sp_configure 'Ole Automation Procedures', 1 
RECONFIGURE WITH OVERRIDE

SELECT dbo.RegexReplace('John Smith', 'john', '',1) 