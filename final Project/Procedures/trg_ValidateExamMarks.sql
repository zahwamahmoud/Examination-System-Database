CREATE TRIGGER trg_ValidateExamMarks
ON Exam_Question
AFTER INSERT, UPDATE
AS
BEGIN
    -- Check if the sum of marks for an exam exceeds its maximum allowed degree
    IF EXISTS (
        SELECT 1 
        FROM Exam e
        JOIN Course c ON e.course_id = c.c_id
        JOIN (
            SELECT E_Id, SUM(Mark) AS TotalMarks
            FROM Exam_Question
            WHERE E_Id IN (SELECT E_Id FROM inserted)
            GROUP BY E_Id
        ) eq ON e.E_id = eq.E_Id
        WHERE eq.TotalMarks > c.max_degree
    )
    BEGIN
        PRINT 'Total exam marks exceed maximum allowed!';
        ROLLBACK TRANSACTION;
    END
END;
