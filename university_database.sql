Create a department table
CREATE TABLE Department (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50)
);
Create a student table
CREATE TABLE Student (
    student_id NUMBER PRIMARY KEY,
    student_name VARCHAR2(50),
    dept_id NUMBER,
    year_of_study NUMBER,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
Create a faculty table
CREATE TABLE Faculty (
    faculty_id NUMBER PRIMARY KEY,
    faculty_name VARCHAR2(50),
    dept_id NUMBER,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
Create a course table
CREATE TABLE Course (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(50),
    dept_id NUMBER,
    faculty_id NUMBER,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);
Create a exam results table
CREATE TABLE ExamResult (
    result_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    marks NUMBER,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);
-- Departments
INSERT INTO Department VALUES (1, 'Computer Science');
INSERT INTO Department VALUES (2, 'Electronics');
INSERT INTO Department VALUES (3, 'Mechanical');

-- Students
INSERT INTO Student VALUES (101, 'Alice', 1, 2);
INSERT INTO Student VALUES (102, 'Bob', 1, 3);
INSERT INTO Student VALUES (103, 'Charlie', 2, 2);
INSERT INTO Student VALUES (104, 'David', 3, 1);

-- Faculty
INSERT INTO Faculty VALUES (201, 'Dr. Smith', 1);
INSERT INTO Faculty VALUES (202, 'Dr. Johnson', 2);
INSERT INTO Faculty VALUES (203, 'Dr. Lee', 3);

-- Courses
INSERT INTO Course VALUES (301, 'DBMS', 1, 201);
INSERT INTO Course VALUES (302, 'Digital Circuits', 2, 202);
INSERT INTO Course VALUES (303, 'Thermodynamics', 3, 203);

-- Exam Results
INSERT INTO ExamResult VALUES (401, 101, 301, 85);
INSERT INTO ExamResult VALUES (402, 102, 301, 90);
INSERT INTO ExamResult VALUES (403, 103, 302, 70);
INSERT INTO ExamResult VALUES (404, 104, 303, 65);
INSERT INTO ExamResult VALUES (405, 101, 301, 95); -- Alice improved score
COMMIT;
1. List all students with their department
SELECT s.student_name, d.dept_name
FROM Student s
JOIN Department d ON s.dept_id = d.dept_id;
2. Show faculty and the courses they teach
SELECT f.faculty_name, c.course_name
FROM Faculty f
JOIN Course c ON f.faculty_id = c.faculty_id;
3. Find department-wise student count
SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM Department d
LEFT JOIN Student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name;
4. Find top 3 students in Computer Science by marks
SELECT student_name, marks
FROM (
    SELECT s.student_name, er.marks,
           ROW_NUMBER() OVER (ORDER BY er.marks DESC) AS rn
    FROM ExamResult er
    JOIN Student s ON er.student_id = s.student_id
    JOIN Department d ON s.dept_id = d.dept_id
    WHERE d.dept_name = 'Computer Science'
)
WHERE rn <= 3;
5. Find pass percentage by department (pass = marks ≥ 40)
SELECT d.dept_name,
       ROUND( (SUM(CASE WHEN er.marks >= 40 THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2 ) AS pass_percentage
FROM ExamResult er
JOIN Student s ON er.student_id = s.student_id
JOIN Department d ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

