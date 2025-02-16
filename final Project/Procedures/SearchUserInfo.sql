CREATE PROCEDURE SearchUserInfo
    @UserType NVARCHAR(50),
    @UserID INT,
    @UserName NVARCHAR(50) = NULL,
    @SearchTarget NVARCHAR(50) = NULL, -- 'self', 'student', 'instructor' (for Training_manager)
    @TargetID INT = NULL -- ID of the student/instructor to search (for Training_manager)
AS
BEGIN
    -- Checking Student Info
    IF @UserType = 'Student'
    BEGIN
        IF EXISTS (SELECT 1 FROM Student WHERE st_id = @UserID AND (@UserName IS NULL OR name = @UserName))
        BEGIN
            SELECT * FROM Student WHERE st_id = @UserID;
        END
        ELSE
        BEGIN
            PRINT 'No matching student found';
        END
    END

    -- Checking Instructor Info
    ELSE IF @UserType = 'Teaching_Instructor'
    BEGIN
        IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_id = @UserID AND (@UserName IS NULL OR name = @UserName))
        BEGIN
            SELECT * FROM Instructor WHERE Ins_id = @UserID;
        END
        ELSE
        BEGIN
            PRINT 'No matching instructor found';
        END
    END

    -- Training Manager: Can search for self, student, or instructor
    ELSE IF @UserType = 'Training_manager'
    BEGIN
        IF @SearchTarget = 'self'
        BEGIN
            IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_id = @UserID AND title = 'Training_manager' AND (@UserName IS NULL OR name = @UserName))
            BEGIN
                SELECT * FROM Instructor WHERE Ins_id = @UserID;
            END
            ELSE
            BEGIN
                PRINT 'No matching training manager found';
            END
        END
        ELSE IF @SearchTarget = 'student'
        BEGIN
            IF EXISTS (SELECT 1 FROM Student WHERE st_id = @TargetID AND (@UserName IS NULL OR name = @UserName))
            BEGIN
                SELECT * FROM Student WHERE st_id = @TargetID;
            END
            ELSE
            BEGIN
                PRINT 'No matching student found';
            END
        END
        ELSE IF @SearchTarget = 'instructor'
        BEGIN
            IF EXISTS (SELECT 1 FROM Instructor WHERE Ins_id = @TargetID AND (@UserName IS NULL OR name = @UserName))
            BEGIN
                SELECT * FROM Instructor WHERE Ins_id = @TargetID;
            END
            ELSE
            BEGIN
                PRINT 'No matching instructor found';
            END
        END
        ELSE
        BEGIN
            PRINT 'Invalid search target. Choose "self", "student", or "instructor".';
        END
    END
    ELSE
    BEGIN
        PRINT 'Invalid user type.';
    END
END;

--testQueries
-- student search for his info
EXEC SearchUserInfo @UserType = 'Student', @UserID = 1, @UserName = 'Ahmed Ali';

--teaching instructor for his info
EXEC SearchUserInfo @UserType = 'Teaching_Instructor', @UserID = 1, @UserName = 'Dr. Ahmed Youssef';

--training manger for hiss info
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'self', @UserName = 'Prof. Sarah Mohamed';

--training manger for student 
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'student', @TargetID = 1, @UserName = 'Ahmed Ali';

--training manger for instructor
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'instructor', @TargetID =1, @UserName = 'Dr. Ahmed Youssef';

