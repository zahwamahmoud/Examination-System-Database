CREATE FUNCTION dbo.CalculateStudentScore(@StudentID INT, @ExamID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Score INT;

    SELECT @Score = COALESCE(SUM(CASE WHEN SA.answer = Q.correct_answer THEN EQ.mark ELSE 0 END), 0)
    FROM StudentAnswers SA
    INNER JOIN Exam_Question EQ ON SA.q_id = EQ.q_id AND EQ.e_id = @ExamID
    INNER JOIN Questions Q ON SA.q_id = Q.q_id
    WHERE SA.student_id = @StudentID;

    RETURN @Score;
END;
