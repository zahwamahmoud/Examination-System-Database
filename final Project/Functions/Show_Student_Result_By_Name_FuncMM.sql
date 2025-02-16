GO
-- Drop function if it already exists
DROP FUNCTION IF EXISTS dbo.Show_Student_Result_By_Name;
GO

-- Create function
CREATE FUNCTION dbo.Show_Student_Result_By_Name(@name VARCHAR(20))
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
    WHERE S.name LIKE @name + '%';
GO

-- Grant permission to allow users to access it
GRANT SELECT ON dbo.Show_Student_Result_By_Name TO instructor;
