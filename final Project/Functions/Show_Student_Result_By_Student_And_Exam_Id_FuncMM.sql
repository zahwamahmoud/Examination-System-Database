GO
-- Drop function if it already exists
DROP FUNCTION IF EXISTS dbo.Show_Result_By_Student_Exam_Ids;
GO

-- Create function
CREATE FUNCTION dbo.Show_Result_By_Student_Exam_Ids(@student_Id INT, @Exam_Id INT)
RETURNS TABLE
AS
RETURN 
    SELECT 
        S.name, 
        SE.obtained_marks, 
        SE.total_marks, 
        SE.exam_status, 
        SE.result_status
    FROM Student_Exam SE 
    INNER JOIN Student S 
        ON SE.Student_Id = S.st_Id 
    WHERE SE.Student_Id = @student_Id 
    AND SE.Exam_Id = @Exam_Id; -- Added missing exam condition
GO

-- Grant permission to allow users to access it
GRANT SELECT ON dbo.Show_Result_By_Student_Exam_Ids TO student;
GRANT SELECT ON dbo.Show_Result_By_Student_Exam_Ids TO instructor;

