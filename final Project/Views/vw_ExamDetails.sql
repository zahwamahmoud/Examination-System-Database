CREATE VIEW vw_ExamDetails AS
SELECT 
    E.E_id AS ExamID, 
    C.name AS CourseName, 
    E.start_time AS StartTime, 
    E.end_time AS EndTime, 
    DATEDIFF(MINUTE, E.start_time, E.end_time) AS TotalTime
FROM Exam E
JOIN Course C ON E.course_id = C.c_id;
