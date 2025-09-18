# 🎓 University Database Project (Oracle SQL)
“A University Database project in Oracle SQL for managing students, faculty, courses, and exam results. Includes schema, sample data, and queries.”

## 📌 Project Overview
This project is a University Database Management System implemented in **Oracle SQL**.  
It manages **students, faculty, courses, and exam results** for a university.  

## 📂 Features
- Store student and faculty details
- Course allocation per faculty
- Exam result management
- Department-wise reports (student count, pass percentage, toppers)

## 🏗️ Database Design
**Entities:**
- Department
- Student
- Faculty
- Course
- ExamResult

Relationships:
- One Department → Many Students/Faculty/Courses
- One Faculty → Many Courses
- One Student → Many ExamResults

## 🗄️ SQL Schema
See [`university_database.sql`](./university_database.sql) for full schema and queries.

## 📊 Sample Queries
- List students with their department
- Faculty and courses they teach
- Department-wise student count
- Top 3 students in Computer Science
- Pass percentage by department

## 🚀 How to Run
1. Open Oracle SQL Developer.
2. Run `university_database.sql`.
3. Query the tables for reports.
