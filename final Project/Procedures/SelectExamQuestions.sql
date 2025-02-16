CREATE TYPE QuestionTableType AS TABLE (Q_id INT);

CREATE OR ALTER PROCEDURE SelectExamQuestions
    @ExamID INT,
    @ManualSelection BIT,
    @NumQuestions INT = NULL,
    @SelectedQuestions QuestionTableType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if Exam ID exists in Exam table
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE E_Id = @ExamID)
    BEGIN
        -- Insert a new Exam with default values
        PRINT 'Exam ID does not exist. Creating a new exam entry.';

        INSERT INTO Exam (E_id, course_id, exam_type, intake_id, branch_id, track_id, start_time, end_time, exam_date, max_degree)
        VALUES (@ExamID, 1, 'exam', 1, 1, 1, GETDATE(), DATEADD(HOUR, 1, GETDATE()), CAST(GETDATE() AS DATE), 100);
    END;

    -- ✅ Manual Selection: Instructor selects questions manually
    IF @ManualSelection = 1
    BEGIN
        -- Ensure the correct number of questions are selected
        IF (SELECT COUNT(*) FROM @SelectedQuestions) <> @NumQuestions
        BEGIN
            PRINT 'Error: Number of selected questions does not match the specified count.';
            RETURN;
        END;

        -- Insert manually selected questions
        INSERT INTO Exam_Question (E_Id, Q_id, Mark)
        SELECT @ExamID, Q_id, 1 
        FROM @SelectedQuestions;
        
        PRINT '✅ Manual selection of questions completed.';
    END
    ELSE
    BEGIN
        -- Ensure NumQuestions is provided
        IF @NumQuestions IS NULL OR @NumQuestions <= 0
        BEGIN
            PRINT 'Error: Number of questions must be specified for random selection.';
            RETURN;
        END;

        -- Insert randomly selected questions
        INSERT INTO Exam_Question (E_Id, Q_id, Mark)
        SELECT TOP (@NumQuestions) @ExamID, Q_id, 1
        FROM (
            SELECT Q_id FROM MCQ
            UNION ALL
            SELECT Q_id FROM TF
            UNION ALL
            SELECT Q_id FROM Text
        ) AS Questions
        ORDER BY NEWID(); 

        PRINT '✅ Random selection of questions completed.';
    END
END;


--testing

--manual selection
-- Declare a table variable of the custom type
DECLARE @Selected QuestionTableType;
INSERT INTO @Selected VALUES (10), (11), (12); 

-- Execute the procedure with manual selection
EXEC SelectExamQuestions 
    @ExamID = 4, 
    @ManualSelection = 1, 
    @NumQuestions = 3, 
    @SelectedQuestions = @Selected;

------------------------
--random selection
EXEC SelectExamQuestions 
    @ExamID =7 , 
    @ManualSelection = 0, 
    @NumQuestions = 6;

select* from Exam_Question

