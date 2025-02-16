CREATE PROCEDURE AddStudent
    @st_id INT,  -- Student ID (passed manually)
    @Ins_id INT,
    @UA_Id INT,
    @T_id INT,
    @b_id INT,
    @In_id INT,
    @name VARCHAR(20),
    @gender VARCHAR(10),
    @grade INT
AS
BEGIN
    -- Check if the instructor is a Training Manager
    IF EXISTS (
        SELECT 1 FROM Instructor WHERE Ins_id = @Ins_id AND title = 'Training_manager'
    )
    BEGIN
        -- Check if the Student ID already exists
        IF NOT EXISTS (SELECT 1 FROM Student WHERE st_id = @st_id)
        BEGIN
            INSERT INTO Student (st_id, UA_Id, T_id, b_id, In_id, name, gender, grade)
            VALUES (@st_id, @UA_Id, @T_id, @b_id, @In_id, @name, @gender, @grade);
            PRINT 'Student added successfully.';
        END
        ELSE
        BEGIN
            PRINT 'Error: Student ID already exists.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Access Denied: Only Training Managers can add students.';
    END
END;
drop proc AddStudent
EXEC AddStudent 
    @st_id = 6,  
    @Ins_id = 2,   
    @UA_Id = 1,  
    @T_id = 3,     
    @b_id = 2,     
    @In_id = 5,    
    @name = 'John Doe', 
    @gender = 'Male', 
    @grade = 85;
