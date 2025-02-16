--student
-- student search for his info
EXEC SearchUserInfo @UserType = 'Student', @UserID = 1, @UserName = 'Ahmed Ali';


-- check (student id ,exam ,time,...) if he has access print the questions
EXEC StartExam @StudentID = 1, @ExamID = 2;

--------
--show the course and the eam time
select * from vw_ExamDetails


EXEC ShowExamForStudent 1, 2;

select * from dbo.Show_Result_By_Student_Exam_Ids (1,1)

TRUNCATE TABLE Student_Exam
TRUNCATE TABLE Student_Question_Exam
DROP TABLE ##Intermediate_Table

Proc_Start_Exam
GO
Proc_StoreStudentAnswer 1, 1, 1, '10'
GO
Proc_StoreStudentAnswer 1, 2, 1, '4'
GO
Proc_StoreStudentAnswer 1, 3, 1, '20'
GO
Proc_StoreStudentAnswer 1, 4, 1, '5'
GO
Proc_StoreStudentAnswer 1, 5, 1, '5'
GO
Proc_StoreStudentAnswer 1, 6, 1, '9'
GO
Proc_StoreStudentAnswer 1, 7, 1, 0
GO
Proc_StoreStudentAnswer 1, 8, 1, 0
GO
Proc_StoreStudentAnswer 1, 9, 1, 1
GO
Proc_StoreStudentAnswer 1, 10, 1, 0
GO
Proc_StoreStudentAnswer 1, 11, 1, 1
GO
Proc_StoreStudentAnswer 1, 12, 1, 1

SELECT * FROM Student_Question_Exam

Proc_LogStudentExam 1, 1

Proc_CheckStudentAnswer 1, 1

SELECT * FROM Student_Exam

SELECT * FROM Student_Question_Exam
