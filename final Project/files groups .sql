
GO

CREATE DATABASE ExaminationSystem
ON 
PRIMARY
(
    NAME = ExaminationSystem_Primary,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MMSSQLSERVER\MSSQL\DATA\ExaminationSystem_Primary.mdf',
    SIZE = 50MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB
),
FILEGROUP PRIMARY_DATA
(
    NAME = ExaminationSystem_Data,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MMSSQLSERVER\MSSQL\DATA\ExaminationSystem_Data.ndf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 50MB
),
FILEGROUP TRANSACTIONS_DATA
(
    NAME = ExaminationSystem_Transactions,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MMSSQLSERVER\MSSQL\DATA\ExaminationSystem_Transactions.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 25MB
),
FILEGROUP INDEX_DATA
(
    NAME = ExaminationSystem_Index,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MMSSQLSERVER\MSSQL\DATA\ExaminationSystem_Index.ndf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 25MB
)
LOG ON
(
    NAME = ExaminationSystem_Log,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MMSSQLSERVER\MSSQL\DATA\ExaminationSystem_log.ldf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 50MB
);
GO

ALTER DATABASE ExaminationSystem
MODIFY FILEGROUP filegroup1 DEFAULT;


SELECT name, physical_name
FROM sys.master_files
WHERE database_id = DB_ID('ExaminationSystem');