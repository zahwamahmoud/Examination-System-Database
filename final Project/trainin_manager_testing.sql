--trining manager



-- Add a new branch 
EXEC AddOrUpdateBranch @Ins_id = 2, @b_id = NULL, @In_id = 2, @name = 'Ciritiva', @address = 'Fayoum';

-- Update an existing branch (use an existing b_id)
EXEC AddOrUpdateBranch @Ins_id = 2, @b_id = 1, @In_id = 2, @name = 'BNS', @address = 'BaniSuaf';


---------------------

-- Add a new intake
EXEC AddOrUpdateIntake @Ins_id = 2, @In_id = NULL, @name = 'Fall 2025';

-- Update an existing intake
EXEC AddOrUpdateIntake @Ins_id = 2, @In_id = 1, @name = 'Updated Intake Name';

-----------------------


-- Add a new track
EXEC AddOrUpdateTrack @Ins_id = 2, @T_id = NULL, @name = 'AI & ML';

-- Update an existing track
EXEC AddOrUpdateTrack @Ins_id = 2, @T_id = 3, @name = 'Updated AI Track';

----------------

--training manger for hiss info
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'self', @UserName = 'Prof. Sarah Mohamed';

--training manger for student 
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'student', @TargetID = 1, @UserName = 'Ahmed Ali';

--training manger for instructor
EXEC SearchUserInfo @UserType = 'Training_manager', @UserID = 2, @SearchTarget = 'instructor', @TargetID =1, @UserName = 'Dr. Ahmed Youssef';

-------------------


