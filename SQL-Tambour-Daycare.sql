create schema Tambour_Daycare;
/* Database Systems, Tambour School for Children (TSC)/ Daycare */
/* Type of SQL : MySQL  */

BEGIN;

/* CREATE CLASSROOM TABLE*/


CREATE TABLE Classroom (
Room_ID INT PRIMARY KEY,
Room_Type VARCHAR(20) NOT NULL,
Capacity INT NOT NULL
);

/* CREATE CLASS TABLE*/
CREATE TABLE CLASS (
CLASS_ID INT PRIMARY KEY,
Class_Name VARCHAR(25) NOT NULL,
Age_Group VARCHAR (50) NOT NULL,
Class_Tuition_Rate DECIMAL (10, 2) NOT NULL,
Room_Num INT NOT NULL,
Room_ID INT NOT NULL,
FOREIGN KEY(Room_ID) REFERENCES Classroom(Room_ID)
);



CREATE TABLE STUDENT (
STUDENT_ID INT PRIMARY KEY,
STUDENT_FNAME VARCHAR(25) NOT NULL,
STUDENT_LNAME VARCHAR(25) NOT NULL,
STUDENT_DOB DATE NOT NULL,
STUDENT_ADDRESS VARCHAR(50) NOT NULL,
STUDENT_CITY VARCHAR(20) NOT NULL,
STUDENT_STATE CHAR(2) NOT NULL,
STUDENT_ZIPCode CHAR(5) NOT NULL,
STUDENT_START_DATE DATE,
STUDENT_PHONE_NUM CHAR(14) NOT NULL,
STUDENT_ALLERGIES VARCHAR(50) NOT NULL,
STUDENT_TUITION_RATE DECIMAL(10, 2) NOT NULL,
CLASS_ID INT,
FOREIGN KEY(CLASS_ID) REFERENCES CLASS(CLASS_ID)
);


/* Create Employees table */
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
EmployeeFName VARCHAR(50),
EmployeeLName VARCHAR(50),
EmployeeDateOfHire DATE,
EmployeeAddress VARCHAR(100),
EmployeeCity VARCHAR(50),
EmployeeState VARCHAR(50),
EmployeeZip VARCHAR(10),
EmployeePhone VARCHAR(15),
ClassAssignment VARCHAR(50),
CLASS_ID INT,
FOREIGN KEY(CLASS_ID) REFERENCES CLASS(CLASS_ID)
);


/* Create Attendance table*/
CREATE TABLE attendance (
Attendance_ID INT PRIMARY KEY,
Attendance_Date DATE,
Attendance_Status VARCHAR(10),
STUDENT_ID INT,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID)
);

/* Create Tuition table */
CREATE TABLE Tuition (
TuitionID INT PRIMARY KEY,
STUDENT_ID INT,
EmployeeID INT,
InvoiceDate DATE,
Amount DECIMAL(10, 2),
Pmt_Status VARCHAR(20),
PaidAmount DECIMAL(10, 2),
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

ALTER TABLE tuition
MODIFY COLUMN TuitionID INT DEFAULT 0;


/*CREATE TRANSPORTATION TABLE*/

CREATE TABLE Transportation (
  Bus_ID INT PRIMARY KEY,
  STUDENT_ID INT,
  EmployeeID INT,
  Bus_Sche VARCHAR(25),
  Bus_Route VARCHAR(25),
  FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
  FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);

/* Create Authorized_pickup table */
CREATE TABLE Authorized_pickup (
Authorized_pickup_ID INT,
Authorized_pickup_1 VARCHAR(45),
Authorized_pickup_2 VARCHAR(45),
Authorized_pickup_3 VARCHAR(45),
STUDENT_ID INT,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID)
);



/* Enroll_Checklist table */
CREATE TABLE Enroll_Checklist (
Enroll_Checklist_ID INT,
Student_info_sheet VARCHAR(45),
Student_medical_sheet VARCHAR(45),
Authorized_pickup_sheet VARCHAR(45),
Student_birth_certificate VARCHAR(45),
Social_security_card CHAR(12),
Immunization_record VARCHAR(45),
Registration_fee DECIMAL(10, 2),
STUDENT_ID INT,
EmployeeID INT,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
);


/* CREATE PARENT_GUARDIAN TABLE*/
CREATE TABLE PARENT_GUARDIAN(
PG_ID INT PRIMARY KEY,
PG_FNAME VARCHAR(35) NOT NULL,
PG_LNAME VARCHAR(35) NOT NULL,
PG_PHONE_NUM CHAR(14) NOT NULL,
PG_ADDRESS VARCHAR(45) NOT NULL,
PG_CITY VARCHAR(20) NOT NULL,
PG_STATE CHAR(2) NOT NULL,
PG_ZIPCode CHAR(5) NOT NULL,
PG_RELATIONSHIP_STUDENT VARCHAR(35) NOT NULL
);


/* CREATE RELATIONSHIP TABLE */
CREATE TABLE RELATIONSHIP (
RELATIONSHIP_ID INT PRIMARY KEY NOT NULL,
STUDENT_ID INT NOT NULL,
PG_ID INT NOT NULL,
RELATIONSHIP_TYPE VARCHAR(25) NOT NULL,
FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID),
FOREIGN KEY (PG_ID) REFERENCES PARENT_GUARDIAN(PG_ID)
);

set global FOREIGN_KEY_CHECKS = 0;


INSERT INTO Authorized_pickup (Authorized_pickup_ID, Authorized_pickup_1, Authorized_pickup_2, Authorized_pickup_3, STUDENT_ID) VALUES
(10, 'mom', 'dad', 'aunt',100),
(20, 'dad', 'aunt', 'mom',101),
(30, 'aunt', 'dad', 'mom',102),
(40, 'dad', 'mom', 'dad',103),
(50, 'dad', 'aunt', 'mom',104);

INSERT INTO Enroll_Checklist (Enroll_Checklist_ID, Student_info_sheet, Student_medical_sheet, Authorized_pickup_sheet,
 Student_birth_certificate, Social_security_card, Immunization_record, Registration_fee, STUDENT_ID, EmployeeID)
VALUES 
(11, 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 85.00, 100, 53201),
(12, 'no', 'no', 'yes', 'yes', 'yes', 'no', 75.00, 101, 53202),
(13, 'no', 'no', 'yes', 'yes', 'yes', 'no', 85.00, 102, 53203),
(14, 'no', 'no', 'yes', 'yes', 'yes', 'no', 85.00, 103, 53204),
(15, 'no', 'no', 'yes', 'yes', 'yes', 'no', 75.00, 104, 53205);
      
INSERT INTO Classroom (Room_ID, Room_Type, Capacity) VALUES
(111, 'Infant', '5'),
(222, 'Toddler', '10'),
(333, 'Preschool', '15'),
(444, 'Grade', '20'),
(555, 'Middle', '25');

INSERT INTO CLASS (CLASS_ID, Class_Name, Age_Group, Room_Num, Room_ID, Class_Tuition_Rate) VALUES
(1,'Infant','0-6 months','11','111', 2000.00),
(2,'Toddler','1-3 years','12','222', 1500.00),
(3,'Preschool','3-6 years','13','333', 1000.00),
(4,'Grade','7-10 years','14','444', 850.00),
(5,'Middle','10-13 years','15','555',650.00);



/*Insert Data in Transportation*/

INSERT INTO Transportation (Bus_ID, STUDENT_ID, EmployeeID, Bus_Sche, Bus_Route) VALUES
(10, 100, 53201, 'Monday', 'Route 1'),
(11, 101, 53202, 'Tuesday', 'Route 2'),
(12, 102, 53203, 'Wednesday', 'Route 3'),
(13, 103, 53204, 'Thursday', 'Route 4'),
(14, 104, 53205, 'Friday', 'Route 5');

/* Delete rows with duplicate attendance values */
DELETE FROM student WHERE STUDENT_ID IN (100, 101, 102, 103, 104);

/*Insert Data in Student Table*/

INSERT INTO STUDENT (STUDENT_ID, STUDENT_FNAME, STUDENT_LNAME, STUDENT_DOB, STUDENT_ADDRESS, STUDENT_CITY, STUDENT_STATE, STUDENT_ZIPCode, STUDENT_START_DATE, STUDENT_PHONE_NUM, STUDENT_ALLERGIES, STUDENT_TUITION_RATE)
VALUES 
(100, 'Benson', 'Reeves', '2019-10-05', '224 MELROSE ST', 'WINSTON SALEM', 'NC', '27103', '2020-08-25', '336-976-8765', 'FOOD ALLERGIES- Peanuts and milk', 2000.00),
(101, 'Teri', 'Gutierrez', '2020-08-25', '4300 CARVER SCHOOL RD', 'WINSTON SALEM', 'NC', '27105', '2022-08-25', '336-435-6080', 'NO FOOD ALLERGIES', 2000.00),
(102, 'Louis', 'Ramsev', '2019-09-22', '391 INDIANA AVE', 'WINSTON SALEM', 'NC', '27105', '2018-08-25', '336-748-4003', 'NO FOOD ALLERGIES', 1000.00),
(103, 'Alvin', 'Greene', '2020-03-14', '4200 HAVENWOOD DR', 'WINSTON SALEM', 'NC', '27106', '2018-08-25', '336-799-5825', 'FOOD ALLERGIES- Peanuts, Egg and Milk', 850.00),
(104, 'Michael', 'Roach', '2019-04-19', '138 S CHERRY ST', 'WINSTON SALEM', 'NC', '27101', '2022-08-25', '336-915-9954', 'NO FOOD ALLERGIES', 650.00);

/* PARENT_GUARDIAN rows*/
INSERT INTO PARENT_GUARDIAN VALUES (200, 'Mike', 'Reeves', '336-976-8765', '224 MELROSE ST', 'WINSTON SALEM', 'NC', '27103', 'Father');
INSERT INTO PARENT_GUARDIAN VALUES (201, 'Emma', 'Gutierrez', '336-435-6080', '4300 CARVER SCHOOL RD', 'WINSTON SALEM', 'NC', '27105', 'Mother');
INSERT INTO PARENT_GUARDIAN VALUES (202, 'Sophia', 'Ramsev', '336-748-4003', '391 INDIANA AVE', 'WINSTON SALEM', 'NC', '27105', 'Aunt');
INSERT INTO PARENT_GUARDIAN VALUES (203, 'Jack', 'Greene', '336-799-5825', '4200 HAVENWOOD DR', 'WINSTON SALEM', 'NC', '27106', 'Father');
INSERT INTO PARENT_GUARDIAN VALUES (204, 'Amelia', 'Roach', '336-915-9954', '138 S CHERRY ST', 'WINSTON SALEM', 'NC', '27101', 'Mother');

/* Delete rows with duplicate RELATIONSHIP_ID values */
DELETE FROM RELATIONSHIP WHERE RELATIONSHIP_ID IN (301, 302, 303, 304, 305);

/* Insert new rows with unique RELATIONSHIP_ID values */
INSERT INTO RELATIONSHIP (RELATIONSHIP_ID, STUDENT_ID, PG_ID, RELATIONSHIP_TYPE)
VALUES (301, 100, 200, 'Father'),
       (302, 101, 201, 'Mother'),
       (303, 102, 202, 'Aunt'),
       (304, 103, 203, 'Father'),
       (305, 104, 204, 'Mother');

/* Delete rows with duplicate attendance values */
DELETE FROM student_attendance WHERE Attendance_ID IN (100, 101, 102, 103, 104);

/*ATTENDANCE rows*/ 
INSERT INTO attendance (Attendance_ID, Attendance_Date, Attendance_Status, STUDENT_ID)
VALUES 
(400, '2017-01-26', 'Present', 100), 
(401, '2017-10-26', 'Absent', 101), 
(402, '2017-03-29', 'Late', 102),  
(403, '2018-01-29', 'Absent', 103), 
(404, '2019-04-30', 'Present', 104);


INSERT INTO Employees (EmployeeID, EmployeeFName, EmployeeLName,EmployeeDateOfHire,  EmployeeAddress, EmployeeCity, EmployeeState, EmployeeZip, EmployeePhone, ClassAssignment,CLASS_ID) VALUES 
(53201, 'Sapir', 'Cummins', '2017-08-12','410 Scholar Street', 'Greensboro', 'NC', '27413', '336-937-8391', 'teacher',1),
(53202,  'Andreia', 'Bustos','2018-01-30', '130 West Drive', 'Elon', 'NC', '27244', '336-392-9238', 'teacher',2),
(53203,  'Seema', 'Augustin','2017-02-15', '310 Xochitl Avenue', 'Greensboro', 'NC', '27412', '336-948-8423', 'faculty',3),
(53204,  'Mitsuko', 'Carlisle', '2016-12-29','403 Cary Drive', 'Elon', 'NC', '27244', '336-948-2851', 'teacher',4),
(53205, 'Myron', 'Phillips', '2017-03-29','854 Lakeland Street', 'Greensboro', 'NC', '27413', '336-931-8273', 'faculty',5);

INSERT INTO TUITION (TuitionID, STUDENT_ID,EmployeeID, InvoiceDate, Amount, Pmt_Status, PaidAmount) VALUES
(1, 100,53201, '2022-11-28', 2000, 'Paid',2000),
(2, 101,53202, '2022-05-29', 450, 'Unpaid',0 ),
(3, 102,53203, '2022-04-19', 350, 'Paid', 350),
(4, 103,53204, '2022-02-13', 1500, 'Paid', 1500),
(5, 104,53205, '2022-10-29', 500, 'Unpaid',0 );



ALTER TABLE Tuition
ADD COLUMN Scholarship INT (3);

SELECT * FROM Tuition;


SELECT STUDENT_ID, STUDENT_FNAME, STUDENT_LNAME, STUDENT_START_DATE, 
 STUDENT_TUITION_RATE
 FROM STUDENT
 WHERE STUDENT_TUITION_RATE = 2000.0
 ;
 
 SELECT * FROM STUDNET;
 
SELECT STUDENT.STUDENT_ID, STUDENT_FNAME, 
attendance.Attendance_Date, Attendance_Status
FROM STUDENT INNER JOIN Attendance 
ON STUDENT.STUDENT_ID = attendance.STUDENT_ID
WHERE Attendance_Status = 'Absent' AND YEAR (Attendance_Date) = 2017;


SELECT c.Class_Name, AVG(c.Class_Tuition_Rate) AS Average_Tuition_Rate
FROM Class c
GROUP BY c.Class_Name;



SELECT t.STUDENT_ID, s.STUDENT_FNAME, s.STUDENT_LNAME,
 SUM(t.Amount) AS Total_Amount_Paid, SUM(t.PaidAmount) AS Total_Amount_Due
FROM Tuition t
LEFT JOIN STUDENT s ON t.STUDENT_ID = s.STUDENT_ID
GROUP BY t.STUDENT_ID, s.STUDENT_FNAME, s.STUDENT_LNAME;


/*How many students are enrolled in each classroom*/
SELECT c.Room_ID, c.Room_Type, COUNT(s.STUDENT_ID) AS Total_Students_Enrolled
FROM Classroom c
LEFT JOIN CLASS cl ON c.Room_ID = cl.Room_ID
LEFT JOIN STUDENT s ON cl.CLASS_ID = s.CLASS_ID
GROUP BY c.Room_ID, c.Room_Type;


DELIMITER //
CREATE TRIGGER enroll_checklist_trigger
AFTER INSERT ON STUDENT FOR EACH ROW
BEGIN
INSERT INTO Enroll_Checklist (Enroll_Checklist_ID, Student_info_sheet, Student_medical_sheet, Authorized_pickup_sheet, Student_birth_certificate, Social_security_card, Immunization_record, Registration_fee, Student_ID, Employee_ID)
    VALUES (NEW.STUDENT_ID, 'no', 'no', 'no', 'no', 'no', 'no', 0.00, NEW.STUDENT_ID, 0);
END;
//

DELIMITER ;
