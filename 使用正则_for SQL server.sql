--���������ɾ��ԭ�к��� 
IF OBJECT_ID(N'dbo.RegexReplace') IS NOT NULL
 DROP FUNCTION dbo.RegexReplace 
GO 
--��ʼ���������滻���� 
 CREATE FUNCTION dbo.RegexReplace 
( 
 @string VARCHAR(MAX), --���滻���ַ��� 
 @pattern VARCHAR(255), --�滻ģ�� 
 @replacestr VARCHAR(255), --�滻����ַ��� 
 @IgnoreCase INT = 0 --0���ִ�Сд 1�����ִ�Сд 
) 
RETURNS VARCHAR(8000) 
AS
BEGIN
 DECLARE @objRegex INT, @retstr VARCHAR(8000) 
 --�������� 
 EXEC sp_OACreate 'VBScript.RegExp', @objRegex OUT
 --�������� 
 EXEC sp_OASetProperty @objRegex, 'Pattern', @pattern 
 EXEC sp_OASetProperty @objRegex, 'IgnoreCase', @IgnoreCase 
 EXEC sp_OASetProperty @objRegex, 'Global', 1 
 --ִ�� 
 EXEC sp_OAMethod @objRegex, 'Replace', @retstr OUT, @string, @replacestr 
 --�ͷ� 
 EXECUTE sp_OADestroy @objRegex 
 RETURN @retstr 
END
GO 
--��֤�������еĻ�����Ҫ��Ole Automation Proceduresѡ����Ϊ1 
EXEC sp_configure 'show advanced options', 1 
RECONFIGURE WITH OVERRIDE 
EXEC sp_configure 'Ole Automation Procedures', 1 
RECONFIGURE WITH OVERRIDE

SELECT dbo.RegexReplace('John Smith', 'john', '',1) 