CREATE OR ALTER PROCEDURE StartExam
    @StudentID INT,
    @ExamID INT
AS
BEGIN
    DECLARE @CurrentTime TIME = CONVERT(TIME, GETDATE());
    DECLARE @CurrentDate DATE = CAST(GETDATE() AS DATE);
    DECLARE @examDate DATE, @StartTime TIME, @EndTime TIME;

    -- Check if the student is assigned to this exam
    IF NOT EXISTS (
        SELECT 1 
        FROM Student_Exam 
        WHERE student_Id = @StudentID AND exam_Id = @ExamID
    )
    BEGIN
        PRINT 'Access Denied: You are not assigned to this exam.';
        RETURN;
    END
	
	
    -- Retrieve exam details
    SELECT @examDate = e.exam_date, @StartTime = e.start_time, @EndTime = e.end_time
    FROM Exam e
    WHERE e.E_id = @ExamID;

    -- Check if the exam is available now
    IF @examDate = @CurrentDate AND @CurrentTime BETWEEN @StartTime AND @EndTime
    BEGIN
        PRINT 'Access Granted: You may start the exam.';
		execute Proc_Start_Exam
        EXEC ShowExamForStudent @StudentID, @ExamID;
    END
    ELSE
    BEGIN
        PRINT 'Access Denied: Exam is not available at this time.';
    END
END;

EXEC StartExam @StudentID = 1, @ExamID = 1;
go

