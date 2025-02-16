CREATE OR ALTER PROCEDURE LoginUser
    @Email NVARCHAR(55),
    @Password NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StoredPassword NVARCHAR(255), @UserType NVARCHAR(50);

    -- Retrieve the stored password and user type
    SELECT @StoredPassword = [password], @UserType = usertype
    FROM User_Account
    WHERE email = @Email;

    -- Check if email exists
    IF @StoredPassword IS NULL
    BEGIN
        PRINT 'Error: Invalid email!';
        RETURN;
    END

    -- Compare the entered password with the stored password
    IF @StoredPassword = @Password
    BEGIN
        PRINT 'Login successful!';
        PRINT 'User Type: ' + @UserType;
    END
    ELSE
    BEGIN
        PRINT 'Error: Incorrect password!';
    END
END;
GO

EXEC LoginUser @Email = 'student1@gmail.com', @Password = 'Pass1234';