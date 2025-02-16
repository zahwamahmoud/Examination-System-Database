-- Step 1: Ensure function exists
DROP FUNCTION IF EXISTS dbo.Show_ALL_Students_Results;
GO

-- Step 2: Create function with proper permissions
CREATE FUNCTION dbo.Show_ALL_Students_Results(
    @Exam_Id INT, 
    @Branch_Id INT, 
    @Intake_Id INT, 
    @Track_Id INT
)
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
INNER JOIN Student S ON SE.Student_Id = S.st_Id 
WHERE 
    SE.Exam_Id = @Exam_Id 
    AND S.T_id = @Track_Id 
    AND S.b_id = @Branch_Id 
    AND S.In_id = @Intake_Id;
GO

-- Step 3: Grant permission to allow users to access it
GRANT SELECT ON dbo.Show_ALL_Students_Results TO instructor;
