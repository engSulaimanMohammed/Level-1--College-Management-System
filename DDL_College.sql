
create database CollegeDB

use CollegeDB


create table Department
(
	Department_id int primary key,
	D_name nvarchar(100)
)


create table Faculty
(
	F_id int primary key,
	Name nvarchar(100),
	Mobile_no nvarchar(20),
	Salary int,
	Department_id int,
	foreign key (Department_id) references Department(Department_id)
)


create table Hostel
(
	Hostel_id int primary key,
	Hostel_name nvarchar(100),
	City nvarchar(80),
	State nvarchar(80),
	Address nvarchar(100),
	Pin_code nvarchar(20),
	No_of_seats int
)


create table Student
(
	S_id int primary key,
	F_name nvarchar(50),
	L_name nvarchar(50),
	Name nvarchar(100),
	Phone_no nvarchar(20),
	DOB date,
	Department_id int,
	Hostel_id int,
	foreign key (Department_id) references Department(Department_id),
	foreign key (Hostel_id) references Hostel(Hostel_id)
)


create table Course
(
	Course_id int primary key,
	Course_name nvarchar(100),
	Duration nvarchar(50),
	Department_id int,
	foreign key (Department_id) references Department(Department_id)
)


create table Subject
(
	Subject_id int primary key,
	Subject_name nvarchar(100),
	F_id int,
	foreign key (F_id) references Faculty(F_id)
)


create table Exams
(
	Exam_code int primary key,
	Exam_date date,
	Exam_time time,
	Room nvarchar(50),
	Department_id int,
	foreign key (Department_id) references Department(Department_id)
)


create table Student_Course
(
	S_id int,
	Course_id int,
	foreign key (S_id) references Student(S_id),
	foreign key (Course_id) references Course(Course_id),
	primary key (S_id, Course_id)
)


create table Student_Subject
(
	S_id int,
	Subject_id int,
	foreign key (S_id) references Student(S_id),
	foreign key (Subject_id) references Subject(Subject_id),
	primary key (S_id, Subject_id)
)


create table Student_Exam
(
	S_id int,
	Exam_code int,
	foreign key (S_id) references Student(S_id),
	foreign key (Exam_code) references Exams(Exam_code),
	primary key (S_id, Exam_code)
)
