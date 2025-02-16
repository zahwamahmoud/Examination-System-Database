USE ExaminationSystem;
GO

CREATE PROCEDURE AddOrUpdateBranch
    @Ins_id INT,
    @b_id INT = NULL,  -- NULL means adding a new branch
    @In_id INT,
    @name VARCHAR(20),
    @address VARCHAR(25)
AS
BEGIN
    -- Check if the instructor is a Training Manager
    IF EXISTS (
        SELECT 1 FROM Instructor WHERE Ins_id = @Ins_id AND title = 'Training_manager'
    )
    BEGIN
        -- If branch ID is NULL, insert a new branch
        IF @b_id IS NULL
        BEGIN
            DECLARE @NewBranchID INT;

            -- Generate a new branch ID (assuming it's auto-increment, otherwise handle it manually)
            SET @NewBranchID = (SELECT ISNULL(MAX(b_id), 0) + 1 FROM Branch);

            INSERT INTO Branch (b_id, In_id, name, address)
            VALUES (@NewBranchID, @In_id, @name, @address);

            PRINT 'Branch added successfully with ID: ' + CAST(@NewBranchID AS VARCHAR);
        END
        ELSE
        BEGIN
            -- Update existing branch
            UPDATE Branch
            SET In_id = @In_id, name = @name, address = @address
            WHERE b_id = @b_id;

            PRINT 'Branch updated successfully.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Access Denied: Only Training Managers can manage branches.';
    END
END;
GO

GO


---testing


-- Add a new branch (should generate a new ID)
EXEC AddOrUpdateBranch @Ins_id = 2, @b_id = NULL, @In_id = 2, @name = 'Ciritiva', @address = 'Fayoum';

-- Update an existing branch (use an existing b_id)
EXEC AddOrUpdateBranch @Ins_id = 2, @b_id = 1, @In_id = 2, @name = 'BNS', @address = 'BaniSuaf';

-- Update an existing branch
EXEC AddOrUpdateBranch @Ins_id = 2, @b_id = 1, @In_id = 2, @name = 'BNS', @address = 'BaniSuaf';
