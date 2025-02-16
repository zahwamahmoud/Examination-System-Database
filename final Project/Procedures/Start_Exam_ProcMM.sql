
-- Creates Virtual table where student answers can be changed quickly instead of changing database table columns
CREATE PROC Proc_Start_Exam
AS
BEGIN
SELECT * INTO ##Intermediate_Table
FROM Student_Question_Exam
WHERE 1=2
END
