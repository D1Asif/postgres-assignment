-- Active: 1734400560870@@127.0.0.1@5432@university_db

-- create university_db database
CREATE DATABASE university_db;

-- show all the databases
SELECT datname from pg_database; 

-- Create students table
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    email VARCHAR(50),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) UNIQUE,
    credits INT
);

CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

INSERT INTO students (student_name, email, age, frontend_mark, backend_mark, status)
VALUES 
('Sameer', 'sameer@example.com', 21, 48, 60, NULL), 
('Zoya', 'zoya@example.com', 23, 52, 58, NULL), 
('Nabil', 'nabil@example.com', 22, 37, 46, NULL), 
('Rafi', 'rafi@example.com', 24, 41, 40, NULL), 
('Sophia', 'sophia@example.com', 22, 50, 52, NULL), 
('Hasan', 'hasan@gmail.com', 23, 43, 39, NULL);

INSERT INTO courses (course_name, credits)
VALUES ('Next.js', 3), 
('React.js', 4), 
('Databases', 3), 
('Prisma', 3);

INSERT INTO enrollment (student_id, course_id)
VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(3, 2)

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollment;

-- Query 1: Insert a new student record
INSERT INTO students (student_name, email, age, frontend_mark, backend_mark, status)
VALUES ('Asif', 'asif@example.com', 23, 58, 60, NULL);

-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT students.student_name from enrollment
INNER JOIN courses ON enrollment.course_id = courses.course_id
INNER JOIN students ON enrollment.student_id = students.student_id
WHERE courses.course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students 
    ORDER BY frontend_mark + backend_mark DESC 
    LIMIT 1
);

-- Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id 
    FROM enrollment
);

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT * FROM students
OFFSET 2
LIMIT 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(student_id) FROM enrollment
JOIN courses ON courses.course_id = enrollment.course_id
GROUP BY course_name;

-- Query 7: Calculate and display the average age of all students.
SELECT ROUND(AVG(age), 2) as average_age FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students
WHERE email LIKE '%example.com%';