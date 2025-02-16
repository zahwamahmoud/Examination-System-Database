--inserting into intack table
INSERT INTO Intake (In_id, name) VALUES
(1, 'Intake 2024'),
(2, 'Intake 2025'),
(3, 'Intake 2026'),
(4, 'Intake 2027'),
(5, 'Intake 2028');

--inserting into branch
INSERT INTO Branch (b_id, In_id, name, address) VALUES
(1, 1, 'Cairo', 'Cairo, Egypt'),
(2, 2, 'Alexandria', 'Alexandria, Egypt'),
(3, 3, 'Giza', 'Giza, Egypt'),
(4, 4, 'Mansoura', 'Mansoura, Egypt'),
(5, 5, 'Tanta', 'Tanta, Egypt');

--inserting into track table
INSERT INTO Track (T_id, name) VALUES
(1, 'Computer Science'),
(2, 'AI'),
(3, 'Cyber Security'),
(4, 'Data Science'),
(5, 'Software Engineering');

INSERT INTO User_Account (UA_ID, email, password, usertype) VALUES
(1, 'student1@gmail.com', 'Pass1234', 'Student'),
(2, 'student2@yahoo.com', 'StudPass22', 'Student'),
(3, 'instructor1@gmail.com', 'TeachPass45', 'Instructor'),
(4, 'admin1@gmail.com', 'AdminPass99', 'Admin'),
(5, 'student3@gmail.com', 'MyPassword88', 'Student');

--
INSERT INTO Student (st_id, UA_Id, T_id, b_id, In_id, name, gender, grade) VALUES
(1, 1, 1, 1, 1, 'Ahmed Ali', 'Male', 85),
(2, 2, 2, 2, 2, 'Mona Hassan', 'Female', 90),
(3, 5, 3, 3, 3, 'Omar Samir', 'Male', 88),
(4, 1, 4, 4, 4, 'Nour Adel', 'Female', 92),
(5, 2, 5, 5, 5, 'Hassan Youssef', 'Male', 80);

--
INSERT INTO Instructor (Ins_id, UA_Id, T_id, b_id, In_id, name, gender, title) VALUES
(1, 3, 1, 1, 1, 'Dr. Ahmed Youssef', 'Male', 'Teaching_Instructor'),
(2, 3, 2, 2, 2, 'Prof. Sarah Mohamed', 'Female', 'Training_manager'),
(3, 3, 3, 3, 3, 'Dr. Hani Saleh', 'Male', 'Teaching_Instructor'),
(4, 3, 4, 4, 4, 'Prof. Nada Khaled', 'Female', 'Training_manager'),
(5, 3, 5, 5, 5, 'Dr. Mohamed Tarek', 'Male', 'Teaching_Instructor');

--
INSERT INTO Course (c_id, name, description, min_degree, max_degree) VALUES
(1, 'Mathematics', 'Basic math concepts', 30, 100),
(2, 'Physics', 'Fundamentals of Physics', 35, 100),
(3, 'Computer Science', 'Programming and algorithms', 40, 100);

INSERT INTO Exam (E_id, course_id, exam_type, intake_id, branch_id, track_id, start_time, end_time, exam_date, max_degree) VALUES
(1, 1, 'exam', 1, 1, 1, '2025-03-10 10:00:00', '2025-03-10 12:00:00', '2025-03-10', 100),
(2, 2, 'exam', 1, 1, 1, '2025-03-15 10:00:00', '2025-03-15 12:00:00', '2025-03-15', 100),
(3, 3, 'exam', 1, 1, 1, '2025-03-20 10:00:00', '2025-03-20 12:00:00', '2025-03-20', 100);

INSERT INTO Question (Q_id, course_id, question_text, question_type) VALUES
-- Mathematics MCQs
(1, 1, 'What is 5+5?', 'MCQ'),
(2, 1, 'What is the square root of 16?', 'MCQ'),
(3, 1, 'What is 10*2?', 'MCQ'),
(4, 1, 'Solve for x: 2x = 10', 'MCQ'),
(5, 1, 'What is 25 divided by 5?', 'MCQ'),
(6, 1, 'What is 3 squared?', 'MCQ'),
-- Mathematics TF
(7, 1, 'Is 2+2 equal to 4?', 'TF'),
(8, 1, 'Is 10 greater than 20?', 'TF'),
(9, 1, 'Is 5 an even number?', 'TF'),
(10, 1, 'Is 0 a natural number?', 'TF'),
(11, 1, 'Is 3 a prime number?', 'TF'),
(12, 1, 'Is 100 a square number?', 'TF'),

-- Physics MCQs
(13, 2, 'What is the unit of force?', 'MCQ'),
(14, 2, 'What is the speed of light?', 'MCQ'),
(15, 2, 'Which law explains motion?', 'MCQ'),
(16, 2, 'What is the acceleration due to gravity?', 'MCQ'),
(17, 2, 'Which gas is necessary for combustion?', 'MCQ'),
(18, 2, 'What is the SI unit of power?', 'MCQ'),
-- Physics TF
(19, 2, 'Does light travel faster than sound?', 'TF'),
(20, 2, 'Is Newton’s first law about inertia?', 'TF'),
(21, 2, 'Can energy be created?', 'TF'),
(22, 2, 'Is sound a form of energy?', 'TF'),
(23, 2, 'Is gravity a fundamental force?', 'TF'),
(24, 2, 'Is weight the same as mass?', 'TF'),

-- Computer Science MCQs
(25, 3, 'What does CPU stand for?', 'MCQ'),
(26, 3, 'What is the full form of RAM?', 'MCQ'),
(27, 3, 'Which language is used for web development?', 'MCQ'),
(28, 3, 'What does HTML stand for?', 'MCQ'),
(29, 3, 'What is a loop in programming?', 'MCQ'),
(30, 3, 'What is the function of an OS?', 'MCQ'),
-- Computer Science TF
(31, 3, 'Is Python a compiled language?', 'TF'),
(32, 3, 'Is JavaScript case-sensitive?', 'TF'),
(33, 3, 'Can an algorithm have infinite steps?', 'TF'),
(34, 3, 'Is AI a branch of Computer Science?', 'TF'),
(35, 3, 'Is 1 GB equal to 1000 MB?', 'TF'),
(36, 3, 'Can a computer function without an OS?', 'TF');
------

-- Correct Answers for MCQ Questions
INSERT INTO MCQ (Q_id, correct_answer) VALUES
(1, '10'), (2, '4'), (3, '20'), (4, '5'), (5, '5'), (6, '9'),
(13, 'Newton'), (14, '299,792,458 m/s'), (15, 'Newton’s laws'), (16, '9.8 m/s^2'), (17, 'Oxygen'), (18, 'Watt'),
(25, 'Central Processing Unit'), (26, 'Random Access Memory'), (27, 'JavaScript'), (28, 'Hypertext Markup Language'), (29, 'Repeating sequence'), (30, 'Manages hardware and software');

-- Correct Answers for TF Questions (1 = True, 0 = False)
INSERT INTO TF (Q_id, correct_answer) VALUES
(7, 1), (8, 0), (9, 0), (10, 0), (11, 1), (12, 1),
(19, 1), (20, 1), (21, 0), (22, 1), (23, 1), (24, 0),
(31, 0), (32, 1), (33, 0), (34, 1), (35, 0), (36, 0);


INSERT INTO Choice (Ch_id, Q_id, choice) VALUES
(1, 1, '8'), (2, 1, '10'), (3, 1, '12'), (4, 1, '15'),
(5, 2, '2'), (6, 2, '4'), (7, 2, '6'), (8, 2, '8'),
(9, 3, '10'), (10, 3, '20'), (11, 3, '30'), (12, 3, '40'),
(13, 4, '3'), (14, 4, '5'), (15, 4, '7'), (16, 4, '10'),
(17, 5, '5'), (18, 5, '10'), (19, 5, '15'), (20, 5, '20'),
(21, 6, '6'), (22, 6, '9'), (23, 6, '12'), (24, 6, '15');


INSERT INTO Exam_Question (E_Id, Q_id, Mark) VALUES
(1, 1, 5), (1, 2, 5), (1, 3, 5), (1, 4, 5), (1, 5, 5), (1, 6, 5),
(1, 7, 5), (1, 8, 5), (1, 9, 5), (1, 10, 5), (1, 11, 5), (1, 12, 5),

(2, 13, 5), (2, 14, 5), (2, 15, 5), (2, 16, 5), (2, 17, 5), (2, 18, 5),
(2, 19, 5), (2, 20, 5), (2, 21, 5), (2, 22, 5), (2, 23, 5), (2, 24, 5),

(3, 25, 5), (3, 26, 5), (3, 27, 5), (3, 28, 5), (3, 29, 5), (3, 30, 5),
(3, 31, 5), (3, 32, 5), (3, 33, 5), (3, 34, 5), (3, 35, 5), (3, 36, 5);


