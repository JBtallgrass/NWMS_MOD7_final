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

SELECT 
    EXTRACT(YEAR FROM children_data.Graduation_Date) AS Graduation_Year,
    CASE
        WHEN child_age BETWEEN 0 AND 18 THEN child_age
        ELSE NULL
    END AS Child_Age,
    COUNT(*) AS Number_of_Children
FROM (
    SELECT Student_ID, Graduation_Date, Child_1 AS child_age FROM Student_Demographics
    WHERE Child_1 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_2 AS child_age FROM Student_Demographics
    WHERE Child_2 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_3 AS child_age FROM Student_Demographics
    WHERE Child_3 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_4 AS child_age FROM Student_Demographics
    WHERE Child_4 IS NOT NULL
) AS children_data
GROUP BY Graduation_Year, Child_Age
ORDER BY Graduation_Year, Child_Age;
SELECT 
    EXTRACT(YEAR FROM children_data.Graduation_Date) AS Graduation_Year,
    CASE
        WHEN child_age BETWEEN 3 AND 4 THEN 'Pre-K'
        WHEN child_age = 5 THEN 'Kindergarten'
        WHEN child_age = 6 THEN '1st Grade'
        WHEN child_age = 7 THEN '2nd Grade'
        WHEN child_age = 8 THEN '3rd Grade'
        WHEN child_age = 9 THEN '4th Grade'
        WHEN child_age = 10 THEN '5th Grade'
        WHEN child_age = 11 THEN '6th Grade'
        WHEN child_age = 12 THEN '7th Grade'
        WHEN child_age = 13 THEN '8th Grade'
        WHEN child_age = 14 THEN '9th Grade'
        WHEN child_age = 15 THEN '10th Grade'
        WHEN child_age = 16 THEN '11th Grade'
        WHEN child_age = 17 THEN '12th Grade'
        ELSE NULL
    END AS School_Grade,
    COUNT(*) AS Number_of_Children
FROM (
    SELECT Student_ID, Graduation_Date, Child_1 AS child_age FROM Student_Demographics
    WHERE Child_1 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_2 AS child_age FROM Student_Demographics
    WHERE Child_2 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_3 AS child_age FROM Student_Demographics
    WHERE Child_3 IS NOT NULL
    UNION ALL
    SELECT Student_ID, Graduation_Date, Child_4 AS child_age FROM Student_Demographics
    WHERE Child_4 IS NOT NULL
) AS children_data
GROUP BY Graduation_Year, School_Grade
ORDER BY Graduation_Year, School_Grade;

-- Create a single combined table for all students with corrected Enrollment Year
CREATE TABLE all_students AS
-- Resident Students
SELECT 
    d.Student_ID, 
    s.branch_of_service,
    'Resident Student' AS Student_Type,
    EXTRACT(YEAR FROM (d.graduation_date - INTERVAL '10 months')) AS Enrollment_Year,
    d.graduation_date - INTERVAL '10 months' AS calculated_enrollment_date,
    d.graduation_date,
    d.age
FROM student_demographics d
JOIN service_details s ON d.Student_ID = s.Student_ID

UNION ALL

-- International Officers
SELECT 
    i.Student_ID, 
    s.branch_of_service,
    'International Officer' AS Student_Type,
    EXTRACT(YEAR FROM (i.graduation_date - INTERVAL '10 months')) AS Enrollment_Year,
    i.graduation_date - INTERVAL '10 months' AS calculated_enrollment_date,
    i.graduation_date,
    'International' AS race,  -- Assuming we don't have race data for international officers
    i.age
FROM international_officers i
JOIN service_details s ON i.Student_ID = s.Student_ID;

-- Example query to calculate average GPA
SELECT 
    a.Enrollment_Year,
    a.branch_of_service,
    a.Student_Type,
    AVG(g.Final_Grade) AS Avg_GPA,
    COUNT(DISTINCT a.Student_ID) AS Student_Count
FROM all_students a
JOIN student_grades g ON g.Student_ID = a.Student_ID
GROUP BY a.Enrollment_Year, a.branch_of_service, a.Student_Type
ORDER BY a.Enrollment_Year, a.branch_of_service, a.Student_Type;

-- Note: To drop this table when you no longer need it, use:
-- DROP TABLE IF EXISTS all_students;