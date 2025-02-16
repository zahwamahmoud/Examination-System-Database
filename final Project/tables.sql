CREATE DATABASE ExaminationSystem;
GO

use ExaminationSystem
-- Table 1: Intake
CREATE TABLE Intake (
    In_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(25)
);

-- Table 2: Branch
CREATE TABLE Branch (
    b_id INT NOT NULL PRIMARY KEY,
    In_id INT NOT NULL,
    name VARCHAR(20),
    address VARCHAR(25),
    FOREIGN KEY (In_id) REFERENCES Intake(In_id) ON DELETE CASCADE
);

-- Table 3: Track
CREATE TABLE Track (
    T_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20)
);

-- Table 4: User Account
CREATE TABLE User_Account (
    UA_ID INT PRIMARY KEY,
    email NVARCHAR(55) NOT NULL CHECK (email LIKE '%@gmail.com' OR email LIKE '%@yahoo.com'),
    [password] NVARCHAR(255) NOT NULL, -- Increase length for hashed passwords
	CONSTRAINT user_CheckPassword CHECK (
        [password] LIKE '%[A-Z]%' AND 
        [password] LIKE '%[a-z]%' AND 
        [password] LIKE '%[0-9]%' AND 
        LEN([password]) >= 8 AND 
        LEN([password]) <= 25
    ),
    usertype NVARCHAR(50) NOT NULL
);

-- Table 5: Student
CREATE TABLE Student (
    st_id INT NOT NULL PRIMARY KEY,
    UA_Id INT NOT NULL,
    T_id INT NOT NULL,
    b_id INT NOT NULL,
    In_id INT NOT NULL,
    name VARCHAR(20),
    gender VARCHAR(10),
    grade INT,
    FOREIGN KEY (UA_Id) REFERENCES User_Account(UA_Id) ON DELETE CASCADE,
    FOREIGN KEY (T_id) REFERENCES Track(T_id),
    FOREIGN KEY (b_id) REFERENCES Branch(b_id),
    FOREIGN KEY (In_id) REFERENCES Intake(In_id)
);

-- Table 6: Instructor
CREATE TABLE Instructor (
    Ins_id INT NOT NULL PRIMARY KEY,
    UA_Id INT NOT NULL,
    T_id INT NOT NULL,
    b_id INT NOT NULL,
    In_id INT NOT NULL,
    name VARCHAR(20),
    gender VARCHAR(10),
    title VARCHAR(20) CHECK (title IN ('Teaching_Instructor', 'Training_manager')),
    FOREIGN KEY (UA_Id) REFERENCES User_Account(UA_Id) ON DELETE CASCADE,
    FOREIGN KEY (T_id) REFERENCES Track(T_id),
    FOREIGN KEY (b_id) REFERENCES Branch(b_id),
    FOREIGN KEY (In_id) REFERENCES Intake(In_id)
);

-- Table 7: Course
CREATE TABLE Course (
    c_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(20),
    description VARCHAR(255),
    min_degree INT,
    max_degree INT,
	CONSTRAINT chk_max_degree CHECK (max_degree > min_degree) 
);

-- Table 8: Exam
CREATE TABLE Exam (
    E_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    exam_type VARCHAR(20) CHECK (exam_type IN ('exam', 'corrective')),
    intake_id INT NOT NULL,
    branch_id INT NOT NULL,
    track_id INT NOT NULL,
    start_time DATETIME ,
    end_time DATETIME , 
	exam_date DATE ,
    max_degree INT NOT NULL,
	constraint check_endtime CHECK (end_time > start_time) ,
	constraint chech_max_degree CHECK (max_degree > 0),
    FOREIGN KEY (course_id) REFERENCES Course(c_id),
    FOREIGN KEY (intake_id) REFERENCES Intake(In_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(b_id),
    FOREIGN KEY (track_id) REFERENCES Track(T_id)
);

-- Table 9: Instructor_Course
CREATE TABLE Instructor_Course (
    Ins_id INT,
    c_id INT,
    PRIMARY KEY (Ins_id, c_id),
    FOREIGN KEY (Ins_id) REFERENCES Instructor(Ins_id),
    FOREIGN KEY (c_id) REFERENCES Course(c_id)
);


-- Table 10: Instructor_Exam
CREATE TABLE Instructor_Exam (
    E_id INT,
    Ins_id INT,
    S_time DATETIME,
    E_time DATETIME,
    PRIMARY KEY (E_id, Ins_id),
    FOREIGN KEY (E_id) REFERENCES Exam(E_id),
    FOREIGN KEY (Ins_id) REFERENCES Instructor(Ins_id)
);
CREATE TABLE Question (
    Q_id INT PRIMARY KEY,
    course_id INT NOT NULL,
    question_text NVARCHAR(255) NOT NULL,
    question_type VARCHAR(10) CHECK (question_type IN ('MCQ', 'TF', 'TEXT')),
    FOREIGN KEY (course_id) REFERENCES Course(c_id)
);


-- Table 11: MCQ
CREATE TABLE MCQ (
    Q_id INT PRIMARY KEY,
    correct_answer NVARCHAR(255),
    FOREIGN KEY (Q_id) REFERENCES Question(Q_id)
);

-- Table 12: Choice
CREATE TABLE Choice (
    Ch_id INT PRIMARY KEY,
    Q_id INT,
    choice NVARCHAR(255),
   
    FOREIGN KEY (Q_id) REFERENCES MCQ(Q_id)
);


-- Table 13: Text
CREATE TABLE Text (
    Q_id INT PRIMARY KEY,
    best_accepted_answer NVARCHAR(255),
    FOREIGN KEY (Q_id) REFERENCES Question(Q_id)
);

-- Table 14: TF
CREATE TABLE TF (
    Q_id INT PRIMARY KEY,
    correct_answer BIT,
    FOREIGN KEY (Q_id) REFERENCES Question(Q_id)
);

-- Table 15: Exam_Question
CREATE TABLE Exam_Question (
    E_Id INT,
    Q_id INT,
    Mark FLOAT CHECK (Mark > 0),
    PRIMARY KEY (E_Id, Q_id),
    FOREIGN KEY (E_Id) REFERENCES Exam(E_Id),
    FOREIGN KEY (Q_id) REFERENCES Question(Q_id)
);

-- Table 16: Student_Question_Exam
CREATE TABLE Student_Question_Exam(
    student_Id INT,
    Question_Id INT,
	E_Id int,
    Student_ans NVARCHAR(255),
    iscorrect BIT,
    PRIMARY KEY (student_Id, Question_Id,E_Id),
    FOREIGN KEY (student_Id) REFERENCES Student(st_id) ON DELETE CASCADE,
	FOREIGN KEY (E_Id) REFERENCES Exam(E_Id) ON DELETE CASCADE,
    FOREIGN KEY (Question_Id) REFERENCES Question(Q_id) ON DELETE CASCADE 
);
CREATE TABLE Student_Exam (
    student_Id INT NOT NULL,
    exam_Id INT NOT NULL,
    total_marks FLOAT CHECK (total_marks >= 0),
    obtained_marks FLOAT ,
	Exam_status VARCHAR(10) DEFAULT 'scheduled' CHECK (Exam_status IN ('scheduled', 'inExam', 'left')),
    result_status VARCHAR(10) CHECK (result_status IN ('Pass', 'Fail')),
	constraint check_optained_marks CHECK (obtained_marks >= 0 AND obtained_marks <= total_marks),
    PRIMARY KEY (student_Id, exam_Id),
    FOREIGN KEY (student_Id) REFERENCES Student(st_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_Id) REFERENCES Exam(E_id) ON DELETE CASCADE
);


