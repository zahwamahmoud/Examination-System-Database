

-- Checks each student answer for an exam and updates the student exam total grade once exam is submitted
Go
CREATE PROCEDURE Proc_CheckStudentAnswer @Student_Id INT, @Exam_Id INT
AS
	BEGIN

		-- Implementing this using the cursor
		DECLARE @Student_Answer NVARCHAR(255)
		DECLARE @Question_type VARCHAR(10), @Question_Id INT
		DECLARE @Question_Correct_Ans NVARCHAR(255)
		DECLARE @Question_grade FLOAT
		DECLARE @Exam_Total_Mark FLOAT
		DECLARE @Min_degree INT

		SELECT @Exam_Total_Mark=SUM(Mark)
		FROM Exam_Question
		WHERE E_Id=@Exam_Id

		UPDATE Student_Exam				-- Initializing the obtained and total marks of the exam
		SET obtained_marks = 0, total_marks=@Exam_Total_Mark
		WHERE Student_id=@Student_Id AND exam_Id=@exam_Id

		DECLARE Question_Info_Cursor CURSOR FOR
		SELECT Question_Id, Student_ans
		FROM Student_Question_Exam
		WHERE Student_Id=@Student_Id AND E_Id=@Exam_Id

		OPEN Question_Info_Cursor

		FETCH NEXT FROM Question_Info_Cursor
		INTO @Question_Id, @Student_Answer

		WHILE @@FETCH_STATUS=0
		BEGIN
			SELECT @Question_type = Question_type
			FROM Question
			WHERE Q_id = @Question_Id

			IF(@Question_type='MCQ')			-- represents question MCQ
			BEGIN
				SELECT @Question_Correct_Ans = correct_answer
				FROM MCQ
				WHERE Q_id=@Question_Id
			END
			ELSE IF(@Question_type='TF')		-- represents question True or false 
			BEGIN
				SELECT @Question_Correct_Ans = CONVERT(NVARCHAR(255),correct_answer)
				FROM TF
				WHERE Q_id=@Question_Id
			END
			ELSE IF(@Question_type='TEXT')	-- represents text question
			BEGIN
				SELECT @Question_Correct_Ans = best_accepted_answer
				FROM [Text]
				WHERE Q_id=@Question_Id
			END

			IF(@Question_Correct_Ans=@Student_Answer)
			BEGIN
				SELECT @Question_grade=Mark
				FROM Exam_Question
				WHERE @Question_Id=Q_id AND E_Id = @Exam_Id

				UPDATE Student_Question_Exam
				SET IsCorrect = 1
				WHERE Student_Id=@Student_Id AND E_Id=@Exam_Id AND Question_Id=@Question_Id

				UPDATE Student_Exam
				SET obtained_marks = obtained_marks+@Question_grade
				WHERE Student_id=@Student_Id AND exam_Id=@Exam_Id
			END
			ELSE
				UPDATE Student_Question_Exam
				SET IsCorrect = 0
				WHERE Student_Id=@Student_Id AND E_Id=@Exam_Id AND Question_Id=@Question_Id
			

			FETCH NEXT FROM Question_Info_Cursor
			INTO @Question_Id, @Student_Answer

		END
		CLOSE Question_Info_Cursor
		DEALLOCATE Question_Info_Cursor

		SELECT @Min_Degree=min_degree
		FROM Exam INNER JOIN Course
		ON E_id = @Exam_Id AND course_id=c_id

		-- Checks if the student result is considered 'pass' or 'Fail'
		IF((SELECT obtained_marks FROM Student_Exam WHERE student_Id=@Student_Id AND exam_Id=@Exam_Id) >= @Min_degree)
		BEGIN
			UPDATE Student_Exam
			SET result_status='Pass'
			WHERE Student_id=@Student_Id AND exam_Id=@Exam_Id
		END
		ELSE
		BEGIN
			UPDATE Student_Exam
			SET result_status='Fail'
			WHERE Student_id=@Student_Id AND exam_Id=@Exam_Id
		END
	END
GO

