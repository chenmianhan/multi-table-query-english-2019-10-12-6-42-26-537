# 1.Query the existence of 1 course
select * from course where id='1';
# 2.Query the presence of both 1 and 2 courses
select * from course 
where id='1' or id='2';
# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select s.id,s.name,avg(sc.score) 
from student s,student_course sc 
group by s.id 
having avg(sc.score)>=60;
# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * from student  s
where s.id not in(
select studentId from student_course
);
# 5.Query all SQL with grades
select * from student_course;
# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select * 
from student s
where s.id in (
select studentId 
from student_course
where courseId ='1' and studentId in(
select studentId 
from student_course
where courseId ='2'
)
);
# 7.Retrieve 1 student score with less than 60 scores in descending order
select s.* ,sc.score from  student s join student_course sc
ON s.id= sc.studentId 
where sc.score<60 and sc.courseId='1'
order by sc.score desc;
# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select sc.courseId,avg(score) 
from student_course sc 
group by sc.courseId 
order by avg(score) DESC , sc.courseId;
# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.name,tmp.scoretmp as score
from student s join 
(
select sc1.score as scoretmp , sc1.studentId as sidtmp
from student_course sc1
where sc1.score<60 and sc1.courseId in (
select c.id 
from course c
where c.name='Math')
)as tmp 
ON tmp.sidtmp=s.id ;