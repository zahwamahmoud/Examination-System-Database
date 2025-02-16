CREATE PROCEDURE AddOrUpdateTrack
    @Ins_id INT,
    @T_id INT = NULL,  -- NULL means adding a new track
    @name VARCHAR(20)
AS
BEGIN
    -- Check if the instructor is a Training Manager
    IF EXISTS (
        SELECT 1 FROM Instructor WHERE Ins_id = @Ins_id AND title = 'Training_manager'
    )
    BEGIN
        IF @T_id IS NULL
        BEGIN
            -- Insert a new track with an auto-generated ID
            INSERT INTO Track (T_id, name)
            VALUES ((SELECT ISNULL(MAX(T_id), 0) + 1 FROM Track), @name);
            PRINT 'Track added successfully.';
        END
        ELSE
        BEGIN
            -- Update an existing track
            UPDATE Track
            SET name = @name
            WHERE T_id = @T_id;
            PRINT 'Track updated successfully.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Access Denied: Only Training Managers can manage tracks.';
    END
END;


--testing

-- Add a new track
EXEC AddOrUpdateTrack @Ins_id = 2, @T_id = NULL, @name = 'AI & ML';

-- Update an existing track
EXEC AddOrUpdateTrack @Ins_id = 1, @T_id = 3, @name = 'Updated AI Track';
