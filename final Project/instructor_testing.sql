--instructor 
--teaching instructor for his info
EXEC SearchUserInfo @UserType = 'Teaching_Instructor', @UserID = 1, @UserName = 'Dr. Ahmed Youssef';

--showing student info using their first name return alll the matches
SELECT * FROM Show_Student_Result_By_Name ('Ahmed')

SELECT * FROM Show_ALL_Students_Results(1,1,1,1)

SELECT * FROM Show_Result_By_Student_Exam_Ids(1,1)

--show the course and the exam time
select * from vw_ExamDetails

select * from V_Show_Students_Results 
-- (examid ,student id)
EXEC AssignStudentToExam 2, 1; 
--------------------------

Proc_CheckStudentAnswer 1, 1

DECLARE @Selected QuestionTableType;
INSERT INTO @Selected VALUES (7), (8), (9); 

-- Execute the procedure with manual selection
EXEC SelectExamQuestions 
    @ExamID = 4, 
    @ManualSelection = 1, 
    @NumQuestions = 3, 
    @SelectedQuestions = @Selected;

--random selection
EXEC SelectExamQuestions 
    @ExamID =6 , 
    @ManualSelection = 0, 
    @NumQuestions = 6;
