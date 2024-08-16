create database Hundred_days_sql
use Hundred_days_sql

-- Create the student_batch table
CREATE TABLE student_batch (
    StudentID INT,
    CourseID INT,
    EnrollmentYear INT
);

-- Insert sample records into the student_batch table
INSERT INTO student_batch (StudentID, CourseID, EnrollmentYear) VALUES
(1, 101, 2019),
(1, 102, 2019),
(1, 103, 2019),
(1, 104, 2019),
(1, 105, 2019),
(1, 106, 2019),
(1, 107, 2019),
(1, 108, 2019),
(1, 109, 2019),
(1, 110, 2019),
(2, 101, 2019),
(2, 102, 2019),
(2, 103, 2019),
(2, 104, 2019),
(2, 105, 2019),
(2, 106, 2019),
(2, 107, 2019),
(2, 108, 2019),
(2, 109, 2019),
(2, 110, 2019),
(3, 101, 2019),
(3, 102, 2019),
(3, 103, 2019),
(3, 104, 2019),
(3, 105, 2019),
(3, 106, 2019),
(3, 107, 2019),
(3, 108, 2019),
(4, 101, 2019),
(4, 102, 2019),
(4, 103, 2019),
(4, 104, 2019),
(4, 105, 2019),
(4, 106, 2019),
(4, 107, 2019),
(4, 108, 2019),
(4, 109, 2019),
(1, 105, 2020),
(1, 106, 2020),
(3, 107, 2020),
(4, 108, 2019),
(4, 109, 2020),
(2, 106, 2020),
(1, 107, 2020),
(4, 110, 2020),
(4, 111, 2020);

--Write a query to get the list of students who had enrolled in all the courses availble in 2019.suppose there were 10  courses available in 2019,the query should return the studentID who were enrolled in all 10 courses
select * from student_batch
--StudentID,count(CourseId)
--where clause on year
--group by studentID
--this is example of subquery-------------------------

select StudentID
--Count(distinct CourseID) as enrolled_course
from student_batch
where EnrollmentYear=2019
Group by StudentID
having Count(distinct CourseID)=(select Count(distinct CourseID) from student_batch
                                 where EnrollmentYear=2019)

-- Question No --2
CREATE TABLE t1(c1 INT);

CREATE TABLE t2(c2 VARCHAR);

INSERT INTO t1
VALUES
(4),
(6),
(7),
(9),
(3),
(9);

INSERT INTO t2
VALUES
(1),
(5),
(9),
(2),
(2),
(8);
 DROP TABLE T2

select * from t1
select * from t2

SELECT T2.C2
FROM t2
FULL OUTER JOIN t1 ON t1.c1 = CAST(t2.c2 AS INT);
                                 
