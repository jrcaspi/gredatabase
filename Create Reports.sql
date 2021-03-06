--Report 1
select 
Sc.School_ID, 
Sc.School_Name,
round(avg(Re.total_score)) as "Average Total Score", 
median(Re.total_score) as "Median Total Score"

from jLJ16002.SAT_Results Re
join jLJ16002.Student St
on Re.Collegeboard_ID = St.Collegeboard_ID
right outer join jLJ16002.School Sc
on Sc.School_ID = St.school_id

Group by Sc.School_ID, 
Sc.School_Name

order by Sc.School_ID
desc nulls last;



--Report 2:
select 
st.Grad_Year,
round(avg(Re.total_score)) as "Average Total Score", 
median(Re.total_score) as "Median Total Score"

from jLJ16002.SAT_Results Re
join jLJ16002.Student St
on Re.Collegeboard_ID = St.Collegeboard_ID
join jLJ16002.School Sc
on Sc.School_ID = St.school_id
where st.school_ID = &enterschoolid
Group by 
st.Grad_Year;





--Report 3
select 
S.Student_First_Name,
S.Student_Last_Name,
T.Test_Name,
T.Test_Date,
R.Total_Score, 
R.Verbal_Score, 
R.Math_Score,
S.Grad_Year 
from jLJ16002.QUESTION_ANSWER QA
join jLJ16002.SAT_Results R
on R.Collegeboard_ID = QA.Collegeboard_ID
join JLJ16002.STUDENT S
on S.Collegeboard_ID = QA.Collegeboard_ID
join JLJ16002.SAT_Test T
on T.Test_ID = R.Test_ID
where s.&CollegeBoard_IDOrAlt_Student_ID = &EnterID
group by S.Student_First_Name,
S.Student_Last_Name,
T.Test_Name,
T.Test_Date,
R.Total_Score, 
R.Verbal_Score, 
R.Math_Score,
S.Grad_Year  ;

--Report 4
select sat.COLLEGEBOARD_ID, 
Alt_student_ID, 
Student_First_Name, 
Student_Last_Name, 
Grad_Year,
total_score, 
math_score, 
verbal_score

from JLJ16002.sat_results sat
join JLJ16002.student stu
on sat.COLLEGEBOARD_ID = stu.COLLEGEBOARD_ID

where TOTAL_SCORE <
(select round(avg(total_score))
from JLJ16002.sat_results)

group by 
sat.COLLEGEBOARD_ID,
Alt_student_ID, 
Student_First_Name, 
Student_Last_Name, 
Grad_Year,
total_score, 
math_score, 
verbal_score

order by total_score desc;

--Report 5
select * from 
(
select SUBJECT_Tag1_Description, qa.Answer, qa.QUESTION_ANSWER_ID

from JLJ16002.question_answer qa
join JLJ16002.QUESTION_TEST qt
on qt.QUESTION_TEST_ID = qa.question_test_ID
join JLJ16002.TAGS T
on T.TAG_ID = qt.TAG_ID)
pivot 
(COUNT(QUESTION_ANSWER_ID)
for answer in ('+', '-', 'O'));