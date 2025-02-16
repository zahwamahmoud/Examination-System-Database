-----------------------instructor---------------------------
CREATE PROCEDURE AssignStudentToExam
    @ExamID INT,
    @StudentID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Exam WHERE E_id = @ExamID)
    BEGIN
        PRINT 'Error: Exam does not exist.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Student WHERE st_id = @StudentID)
    BEGIN
        PRINT 'Error: Student does not exist.';
        RETURN;
    END

    INSERT INTO Student_Exam (student_Id, exam_Id)
    VALUES ( @StudentID,@ExamID);

    PRINT 'Student assigned successfully.';
END;


EXEC AssignStudentToExam 1, 2;
go

-------------------------instructor---------------------------------
---############################# date ===from time 
CREATE OR ALTER PROCEDURE DefineExamWithoutDetermineTimeOrDate
    @ExamID INT,  -- Manually provided Exam ID
    @InstructorID INT,
    @CourseID INT,
    @ExamType VARCHAR(20),
    @IntakeID INT,
    @BranchID INT,
    @TrackID INT,
    @MaxDegree INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate Instructor-Course Relationship
    IF NOT EXISTS (
        SELECT 1 FROM Instructor_Course 
        WHERE Ins_id = @InstructorID AND c_id = @CourseID
    )
    BEGIN
        PRINT 'Error: You are not assigned to this course!';
        RETURN;
    END

    -- Check if Exam ID already exists (to prevent duplicate keys)
    IF EXISTS (SELECT 1 FROM Exam WHERE E_id = @ExamID)
    BEGIN
        PRINT 'Error: Exam ID already exists!';
        RETURN;
    END

    -- Insert New Exam with manually assigned Exam ID
    INSERT INTO Exam (E_id, course_id, exam_type, intake_id, branch_id, track_id, max_degree)
    VALUES (@ExamID, @CourseID, @ExamType, @IntakeID, @BranchID, @TrackID, @MaxDegree);

    PRINT 'Exam successfully created!';
END;


EXEC DefineExamWithoutDetermineTimeOrDate 
    @ExamID = 10,  -- Manually assigned Exam ID
    @InstructorID = 1, 
    @CourseID = 1, 
    @ExamType = 'exam', 
    @IntakeID = 1, 
    @BranchID = 1, 
    @TrackID = 1, 
    @MaxDegree = 60;


----------------------------------------------------------
CREATE PROCEDURE UpdateExamSchedule
    @InstructorID INT,
    @ExamID INT,
    @ExamDate DATE,
    @StartTime DATETIME,
    @EndTime DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the instructor is assigned to this exam
    IF NOT EXISTS (
        SELECT 1 FROM Instructor_Exam 
        WHERE Ins_id = @InstructorID AND E_id = @ExamID
    )
    BEGIN
        PRINT 'Error: You are not authorized to modify this exam!';
        RETURN;
    END

    -- Validate Time Range
    IF @StartTime >= @EndTime
    BEGIN
        PRINT 'Error: Start time must be before end time!';
        RETURN;
    END

    -- Check if exam exists before updating
    IF EXISTS (SELECT 1 FROM Exam WHERE E_id = @ExamID)
    BEGIN
        -- Update existing exam schedule
        UPDATE Exam
        SET 
            exam_date = @ExamDate, 
            start_time = @StartTime, 
            end_time = @EndTime
        WHERE E_id = @ExamID;

        PRINT 'Exam schedule updated successfully!';
    END
    ELSE
    BEGIN
        PRINT 'Error: Exam not found!';
    END
END;
 drop proc UpdateExamSchedule 

------------
EXEC UpdateExamSchedule 
    @InstructorID = 1, 
    @ExamID = 3,     
    @ExamDate = '2025-02-15',
    @StartTime = '2025-02-15 09:00:00', 
    @EndTime = '2025-02-15 11:00:00';

