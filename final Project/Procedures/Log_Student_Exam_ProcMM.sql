
GO
-- Logs the student in the exam once student submits it
CREATE PROC Proc_LogStudentExam @Student_Id INT, @Exam_Id INT
AS
	BEGIN
		DECLARE @Start_Time DATETIME, @End_Time DATETIME
		SELECT @Start_Time = start_time, @End_Time = end_time
		FROM Exam 
		WHERE E_id=@Exam_Id
		
		-- If student enters within the specified exam time, his status changes from absent (default value) to present
		IF(GETDATE() BETWEEN @Start_Time AND @End_Time)
		BEGIN
			INSERT INTO Student_Exam
			VALUES(@student_Id, @Exam_Id, NULL, NULL, 'left', NULL)
			
			INSERT INTO Student_Question_Exam
			SELECT * FROM ##Intermediate_Table

			DROP TABLE ##Intermediate_Table
		END
		ELSE 
			PRINT 'Time out'
	END

GO
