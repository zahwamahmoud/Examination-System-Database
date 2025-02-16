
GO
-- This procedure just stores the student answer. 
CREATE PROCEDURE Proc_StoreStudentAnswer @Student_Id INT, @Question_Id INT,@Exam_Id INT, @Student_Ans NVARCHAR(255)
AS 
	BEGIN 
		
		DECLARE @Start_Time DATETIME, @End_Time DATETIME
		SELECT @Start_Time = start_time, @End_Time = end_time
		FROM Exam 
		WHERE E_id=@Exam_Id
		
		IF(GETDATE() BETWEEN @Start_Time AND @End_Time)
		BEGIN
			IF(EXISTS(SELECT * FROM Student_Question_Exam WHERE Student_Id=@Student_Id AND Question_Id=@Question_Id AND E_Id=@Exam_Id))
			BEGIN
				UPDATE ##Intermediate_Table
				SET Student_ans=@Student_Ans
				WHERE Student_Id=@Student_Id AND Question_Id=@Question_Id AND E_Id=@Exam_Id
			END
			ELSE
			BEGIN
				INSERT INTO ##Intermediate_Table
				VALUES(@Student_Id, @Question_Id, @Exam_Id,@Student_Ans, NULL)
			END
		END
		ELSE IF(GETDATE() < @Start_Time) 
		BEGIN
			PRINT 'Please Enter during the exam specified time duration'
		END
		ELSE IF(GETDATE() > @End_Time)
		BEGIN
			PRINT 'Time out'
		END

	END

GO 