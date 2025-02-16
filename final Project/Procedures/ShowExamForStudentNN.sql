
------------------------student---------------------------
CREATE or alter PROCEDURE ShowExamForStudent
    @StudentID INT,
    @ExamID INT
AS
BEGIN
    -- Check if the student is assigned to the exam
    IF NOT EXISTS (
        SELECT 1 FROM Student_Exam 
        WHERE student_Id = @StudentID AND exam_Id = @ExamID
    )
    BEGIN
        PRINT 'Access Denied: You are not assigned to this exam.';
        RETURN;
    END

    -- Retrieve Exam Details
    SELECT 
        e.E_id, e.exam_date, e.start_time, e.end_time, e.exam_type, c.[name] AS course_name
    FROM Exam e
    JOIN Course c ON e.course_id = c.c_id
    WHERE e.E_id = @ExamID;

    PRINT '----------------------';

    -- Retrieve Questions for the Exam
    SELECT 
        q.Q_id, q.question_text
    FROM Exam_Question eq
    JOIN Question q ON eq.Q_id = q.Q_id
    WHERE eq.E_Id = @ExamID and q.question_type='TEXT' ;

    PRINT '----------------------';

    -- Retrieve MCQ Choices (without correct answers)
    SELECT 
    q.Q_id, 
    q.question_text, 
    STRING_AGG(ch.choice, ', ') AS choices
    FROM Exam_Question eq
    JOIN Question q ON eq.Q_id = q.Q_id
    JOIN MCQ m ON q.Q_id = m.Q_id
    JOIN Choice ch ON m.Q_id = ch.Q_id
    WHERE eq.E_Id = @ExamID
    GROUP BY q.Q_id, q.question_text;

    PRINT '----------------------';

    -- Retrieve TF Questions (showing only True/False options)
    SELECT 
        q.Q_id, q.question_text, 'True' AS option1, 'False' AS option2
    FROM Exam_Question eq
    JOIN Question q ON eq.Q_id = q.Q_id
    JOIN TF tf ON q.Q_id = tf.Q_id
    WHERE eq.E_Id = @ExamID;
END;
GO
---------------------------------
EXEC ShowExamForStudent 1, 1;

