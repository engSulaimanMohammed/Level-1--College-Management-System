/* =========================================================
   LEVEL 1 - COLLEGE MANAGEMENT SYSTEM
   SQL SERVER / SSMS
   TABLES ONLY - NO DATA
   ========================================================= */

USE master;
GO

IF DB_ID('CollegeDB') IS NOT NULL
BEGIN
    ALTER DATABASE CollegeDB
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE CollegeDB;
END;
GO

CREATE DATABASE CollegeDB;
GO

USE CollegeDB;
GO

/* =========================================================
   TABLES
   ========================================================= */

CREATE TABLE Department (
    Department_id INT PRIMARY KEY,
    D_name VARCHAR(100) NOT NULL UNIQUE
);
GO

CREATE TABLE Faculty (
    F_id INT PRIMARY KEY,
    Name VARCHAR(120) NOT NULL,
    Mobile_no VARCHAR(20),
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    Department_id INT NOT NULL,

    CONSTRAINT FK_Faculty_Department
        FOREIGN KEY (Department_id)
        REFERENCES Department(Department_id)
);
GO

CREATE TABLE Hostel (
    Hostel_id INT PRIMARY KEY,
    Hostel_name VARCHAR(100) NOT NULL,
    City VARCHAR(80),
    State VARCHAR(80),
    Address VARCHAR(255),
    Pin_code VARCHAR(20),
    No_of_seats INT CHECK (No_of_seats >= 0)
);
GO

CREATE TABLE Student (
    S_id INT PRIMARY KEY,
    F_name VARCHAR(60) NOT NULL,
    L_name VARCHAR(60) NOT NULL,
    Phone_no VARCHAR(20),
    DOB DATE NOT NULL,
    Department_id INT NULL,
    Hostel_id INT NULL,

    CONSTRAINT FK_Student_Department
        FOREIGN KEY (Department_id)
        REFERENCES Department(Department_id),

    CONSTRAINT FK_Student_Hostel
        FOREIGN KEY (Hostel_id)
        REFERENCES Hostel(Hostel_id)
);
GO

CREATE TABLE Course (
    Course_id INT PRIMARY KEY,
    Course_name VARCHAR(120) NOT NULL,
    Duration VARCHAR(50),
    Department_id INT NOT NULL,

    CONSTRAINT FK_Course_Department
        FOREIGN KEY (Department_id)
        REFERENCES Department(Department_id)
);
GO

CREATE TABLE Subject (
    Subject_id INT PRIMARY KEY,
    Subject_name VARCHAR(120) NOT NULL,
    F_id INT NOT NULL,

    CONSTRAINT FK_Subject_Faculty
        FOREIGN KEY (F_id)
        REFERENCES Faculty(F_id)
);
GO

CREATE TABLE Exams (
    Exam_code VARCHAR(20) PRIMARY KEY,
    Exam_date DATE NOT NULL,
    Exam_time TIME NOT NULL,
    Room VARCHAR(50),
    Department_id INT NOT NULL,

    CONSTRAINT FK_Exams_Department
        FOREIGN KEY (Department_id)
        REFERENCES Department(Department_id)
);
GO

CREATE TABLE Student_Course (
    S_id INT NOT NULL,
    Course_id INT NOT NULL,

    CONSTRAINT PK_Student_Course
        PRIMARY KEY (S_id, Course_id),

    CONSTRAINT FK_StudentCourse_Student
        FOREIGN KEY (S_id)
        REFERENCES Student(S_id),

    CONSTRAINT FK_StudentCourse_Course
        FOREIGN KEY (Course_id)
        REFERENCES Course(Course_id)
);
GO

CREATE TABLE Student_Subject (
    S_id INT NOT NULL,
    Subject_id INT NOT NULL,

    CONSTRAINT PK_Student_Subject
        PRIMARY KEY (S_id, Subject_id),

    CONSTRAINT FK_StudentSubject_Student
        FOREIGN KEY (S_id)
        REFERENCES Student(S_id),

    CONSTRAINT FK_StudentSubject_Subject
        FOREIGN KEY (Subject_id)
        REFERENCES Subject(Subject_id)
);
GO

CREATE TABLE Student_Exam (
    S_id INT NOT NULL,
    Exam_code VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Student_Exam
        PRIMARY KEY (S_id, Exam_code),

    CONSTRAINT FK_StudentExam_Student
        FOREIGN KEY (S_id)
        REFERENCES Student(S_id),

    CONSTRAINT FK_StudentExam_Exam
        FOREIGN KEY (Exam_code)
        REFERENCES Exams(Exam_code)
);
GO

PRINT 'CollegeDB tables created successfully.';
GO
