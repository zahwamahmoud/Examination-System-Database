-- This view selects all the students results for every exam answered
GO
CREATE VIEW V_Show_Students_Results
AS 
SELECT name, obtained_marks, total_marks, exam_status, result_status
FROM Student_Exam SE INNER JOIN Student S
ON SE.Student_Id = S.st_Id
GO



