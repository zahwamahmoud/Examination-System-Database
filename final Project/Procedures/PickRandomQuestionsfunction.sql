
-- Picking Random Questions Function
CREATE FUNCTION dbo.PickRandomQuestions(@numQuestions INT)
RETURNS TABLE
AS
RETURN (
    SELECT TOP (@numQuestions) 
        q.Question_Id,
        q.question,
        q.correct_answer
    FROM (
        SELECT MCQ_Id AS Question_Id, question, correct_answer FROM MCQ
        UNION ALL
        SELECT Text_id, question, best_accepted_answer FROM Text
        UNION ALL
        SELECT TF_id, question, CAST(correct_answer AS NVARCHAR(255)) FROM TF
    ) q
    ORDER BY NEWID()
);

-- Example Usage
SELECT * FROM dbo.PickRandomQuestions(5);


