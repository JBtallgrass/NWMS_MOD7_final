CREATE TABLE International_Officers (
    Age INT,
    Gender VARCHAR(10),
    Marital_Status VARCHAR(20),
    Country VARCHAR(50),
    Branch_of_Service VARCHAR(50),
    Officer_Rank VARCHAR(10),
    Functional_Branch VARCHAR(50),
    Student_ID VARCHAR(10) PRIMARY KEY,
    Graduation_Date DATE,
    Spouse_Age NUMERIC,
    Child_1 NUMERIC,
    Child_2 NUMERIC,
    Child_3 NUMERIC,
    Child_4 NUMERIC
);
CREATE TABLE Service_Details (
    Branch_of_Service VARCHAR(50),
    Rank VARCHAR(10),
    Functional_Branch VARCHAR(50),
    Student_ID VARCHAR(10) PRIMARY KEY,
    Service_Component VARCHAR(20),
    Commissioning_Source VARCHAR(50)
);
CREATE TABLE student_demographics (
    age INT,
    gender VARCHAR(10),
    marital_status VARCHAR(20),
    student_id VARCHAR(10) PRIMARY KEY,
    graduation_date DATE,
    spouse_age NUMERIC,
    child_1 NUMERIC,
    child_2 NUMERIC,
    child_3 NUMERIC,
    child_4 NUMERIC
);
CREATE TABLE Student_Grades (
    Student_id VARCHAR(10) PRIMARY KEY,
    C200 NUMERIC,
    C300 NUMERIC,
    C400 NUMERIC,
    C500 NUMERIC,
    F100 NUMERIC,
    S100 NUMERIC,
    H100 NUMERIC,
    L100 NUMERIC,
    M000 NUMERIC,
    M100 NUMERIC,
    M200 NUMERIC,
    M300 NUMERIC,
    M400 NUMERIC,
    X100 NUMERIC,
    Final_Grade NUMERIC
);

COPY student_demographics(age, gender, marital_status, student_id, graduation_date, spouse_age, child_1, child_2, child_3, child_4)
FROM 'C:\Program Files\PostgreSQL\17\data\imports\Student_Demographics_With_Graduation_Dates.csv'
DELIMITER ',' CSV HEADER;

COPY international_officers (age, gender, marital_status, country, branch_of_service, officer_rank, functional_branch, student_id, graduation_date, spouse_age, child_1, child_2, child_3, child_4 )
FROM 'C:\Program Files\PostgreSQL\17\data\imports\Updated_International_Officers.csv'
DELIMITER ',' CSV HEADER;

Copy service_details (branch_of_service, officer_rank, functional_branch, student_id, service_component, commissioning_source)
FROM 'C:\Program Files\PostgreSQL\17\data\imports\Updated_Service_Details.csv'
DELIMITER ',' CSV HEADER;

COPY student_grades (student_id, C200, C300, C400, C500, F100, S100, H100, L100, M000, M100, M200, M300, M400, X100, final_grade)
FROM 'C:\Program Files\PostgreSQL\17\data\imports\Student_Grades_and_GPA.csv'
Delimiter ',' CSV HEADER;

SELECT * FROM Student_Grades;
SELECT * FROM Student_Grades WHERE "final_grade" > 90;
SELECT * FROM Student_Grades ORDER BY "final_grade" DESC;
SELECT * FROM student_demographics;
Select * from student_grades;

SELECT 
    d.Graduation_Date, 
    AVG(g.Final_Grade) AS Avg_GPA
FROM 
    Student_Grades g
JOIN 
    Student_Demographics d
ON 
    g.Student_id = d.Student_ID
GROUP BY 
    d.Graduation_Date
ORDER BY 
    d.Graduation_Date;

SELECT 
    d.country, 
    AVG(g.Final_Grade) AS Avg_GPA
FROM 
    Student_Grades g
JOIN 
    international_officers d
ON 
    g.Student_id = d.Student_ID
GROUP BY 
    d.Country
ORDER BY 
    Avg_GPA DESC;

SELECT 
    d.branch_of_service, 
    sd.Graduation_date,
    AVG(g."final_grade") AS Avg_GPA
FROM 
    Student_Grades g
JOIN 
    service_details d
ON 
    g.Student_id = d.Student_ID
JOIN
    Student_Demographics sd
ON
    g.Student_id = sd.Student_ID
GROUP BY 
    d.branch_of_service, sd.Graduation_date
ORDER BY 
    sd.Graduation_date, Avg_GPA DESC;

