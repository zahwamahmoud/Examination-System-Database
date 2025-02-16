EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'clr strict security', 0;
RECONFIGURE;

sp_configure 'clr enabled', 1;

RECONFIGURE;

CREATE ASSEMBLY TextAnswerCheckerAssembly
FROM 'D:\iti\Sql\dll\dlllibrary\ClassLibrary1\ClassLibrary1\bin\Debug\ClassLibrary1.dll'
WITH PERMISSION_SET = SAFE;

EXEC sp_configure 'clr strict security', 1;
RECONFIGURE;