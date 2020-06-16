SELECT 'DROP TABLE "' + TABLE_NAME + '"' 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_NAME LIKE '_stage_%'


DECLARE @cmd varchar(4000)
DECLARE cmds CURSOR FOR
SELECT 'drop table [' + Table_Name + ']'
FROM INFORMATION_SCHEMA.TABLES
WHERE Table_Name LIKE '_stage_%'

OPEN cmds
WHILE 1 = 1
BEGIN
    FETCH cmds INTO @cmd
    IF @@fetch_status != 0 BREAK
    EXEC(@cmd)
END
CLOSE cmds;
DEALLOCATE cmds