create PROCEDURE AddOrUpdateIntake
    @Ins_id INT,
    @In_id INT = NULL,  -- NULL means adding a new intake
    @name VARCHAR(25)
AS
BEGIN
    -- Check if the instructor is a Training Manager
    IF EXISTS (
        SELECT 1 FROM Instructor WHERE Ins_id = @Ins_id AND title = 'Training_manager'
    )
    BEGIN
        IF @In_id IS NULL
        BEGIN
            -- Insert a new intake with a generated ID
            INSERT INTO Intake (In_id, name)
            VALUES ((SELECT ISNULL(MAX(In_id), 0) + 1 FROM Intake), @name);
            PRINT 'Intake added successfully.';
        END
        ELSE
        BEGIN
            -- Update the existing intake
            UPDATE Intake
            SET name = @name
            WHERE In_id = @In_id;
            PRINT 'Intake updated successfully.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Access Denied: Only Training Managers can manage intakes.';
    END
END;
 
 drop proc AddOrUpdateIntake
--testing 

-- Add a new intake
EXEC AddOrUpdateIntake @Ins_id = 2, @In_id = NULL, @name = 'Fall 2025';

-- Update an existing intake
EXEC AddOrUpdateIntake @Ins_id = 2, @In_id = 1, @name = 'Updated Intake Name';
