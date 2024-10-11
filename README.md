# NWMS_MOD7_final

## Project Overview
This repository contains the final project for the **Database Analytics** module. The project demonstrates my ability to generate and work with real-world-like data, perform SQL-based operations, and gain insights using advanced querying techniques. 

### Purpose
The purpose of this project is to:
1. Create a simulated dataset representing six years of student data from the Command and General Staff School (CGSS).
2. Use PostgreSQL and SQL queries to analyze the data.
3. Showcase advanced querying techniques, such as JOINs and aggregations.

---

## Data Overview

### Initial Source and Format
The dataset was generated using **Generative AI** to simulate realistic student performance and demographic information. This data includes six years of student records, capturing various details like grades, branch of service, and graduation information. The dataset was created in **CSV format** and later imported into PostgreSQL using **pgAdmin** for further manipulation and querying.

---

## Data Transformation

### Obstacles Overcome
- **Data Cleaning**: The raw generated dataset contained some inconsistencies, such as null values for grades or demographic information, which needed to be addressed before importing into PostgreSQL.
- **Data Type Conversion**: Converting the dates and numeric values to the appropriate SQL data types during import required careful handling, especially for columns like `Graduation_date` and `Final_Grade`.
- **Normalization**: The data had to be split into multiple tables to normalize it and reduce redundancy. This helped with query performance and ensured data integrity.

---

## Table Structure and Data Types

### Table: `Student_Grades`
| Column         | Data Type |
|----------------|-----------|
| `Student_id`    | VARCHAR(10) PRIMARY KEY |
| `C200`          | NUMERIC   |
| `C300`          | NUMERIC   |
| `C400`          | NUMERIC   |
| `C500`          | NUMERIC   |
| `F100`          | NUMERIC   |
| `S100`          | NUMERIC   |
| `H100`          | NUMERIC   |
| `L100`          | NUMERIC   |
| `M000`          | NUMERIC   |
| `M100`          | NUMERIC   |
| `M200`          | NUMERIC   |
| `M300`          | NUMERIC   |
| `M400`          | NUMERIC   |
| `X100`          | NUMERIC   |
| `Final_Grade`   | NUMERIC   |

### Table: `Student_Demographics`
| Column           | Data Type |
|------------------|-----------|
| `Student_ID`      | VARCHAR(10) PRIMARY KEY |
| `Age`             | INT       |
| `Gender`          | VARCHAR(10) |
| `Marital_Status`  | VARCHAR(20) |
| `Graduation_Date` | DATE      |
| `Spouse_Age`      | NUMERIC   |
| `Child_1`         | NUMERIC   |
| `Child_2`         | NUMERIC   |
| `Child_3`         | NUMERIC   |
| `Child_4`         | NUMERIC   |

### Table: `Service_Details`
| Column              | Data Type |
|---------------------|-----------|
| `Student_ID`         | VARCHAR(10) PRIMARY KEY |
| `Branch_of_Service`  | VARCHAR(50) |
| `Rank`               | VARCHAR(10) |
| `Functional_Branch`  | VARCHAR(50) |
| `Service_Component`  | VARCHAR(20) |
| `Commissioning_Source` | VARCHAR(50) |

---

## Example Queries

### 1. **View All Data from a Table**

Here’s an example of viewing all the data from the `Student_Grades` table using a simple `SELECT` statement:

```sql
SELECT * FROM Student_Grades;
Below is an enhanced version of your `README.md` that addresses the following points: the initial source and format of your data, obstacles you overcame while transforming the data, your table structure including data types, `SELECT *` from your tables, and exciting queries (with at least one join and one query where data is aggregated).

### `README.md`

```markdown
# NWMS_MOD7_final

## Project Overview
This repository contains the final project for the Database Analytics module. The project demonstrates my ability to generate and work with real-world data, perform SQL-based operations, and gain insights using advanced querying techniques. 

### Purpose
The purpose of this project is to:
1. Create a simulated dataset representing six years of student data from the Command and General Staff School (CGSS).
2. Use PostgreSQL and SQL queries to analyze the data.
3. Showcase advanced querying techniques, such as JOINs and aggregations.

---

## Data Overview

### Initial Source and Format
The dataset was generated using Generative AI to simulate realistic student performance and demographic information. It includes six years of student records, capturing various details like grades, branch of service, and graduation information. The dataset was created in CSV format and later imported into PostgreSQL using pgAdmin for further manipulation and querying.

---

## Data Transformation

### Obstacles Overcome
- **Data Cleaning**: The raw generated dataset contained some inconsistencies, such as null values for grades or demographic information, which must be addressed before importing into PostgreSQL.
- **Data Type Conversion**: Converting the dates and numeric values to the appropriate SQL data types during import required careful handling, especially for columns like `Graduation_date` and `Final_Grade`.
- **Normalization**: The data had to be split into multiple tables to normalize it and reduce redundancy. This helped with query performance and ensured data integrity.

---

## Table Structure and Data Types

### Table: `Student_Grades`
| Column         | Data Type |
|----------------|-----------|
| `Student_id`    | VARCHAR(10) PRIMARY KEY |
| `C200`          | NUMERIC   |
| `C300`          | NUMERIC   |
| `C400`          | NUMERIC   |
| `C500`          | NUMERIC   |
| `F100`          | NUMERIC   |
| `S100`          | NUMERIC   |
| `H100`          | NUMERIC   |
| `L100`          | NUMERIC   |
| `M000`          | NUMERIC   |
| `M100`          | NUMERIC   |
| `M200`          | NUMERIC   |
| `M300`          | NUMERIC   |
| `M400`          | NUMERIC   |
| `X100`          | NUMERIC   |
| `Final_Grade`   | NUMERIC   |

### Table: `Student_Demographics`
| Column           | Data Type |
|------------------|-----------|
| `Student_ID`      | VARCHAR(10) PRIMARY KEY |
| `Age`             | INT       |
| `Gender`          | VARCHAR(10) |
| `Marital_Status`  | VARCHAR(20) |
| `Graduation_Date` | DATE      |
| `Spouse_Age`      | NUMERIC   |
| `Child_1`         | NUMERIC   |
| `Child_2`         | NUMERIC   |
| `Child_3`         | NUMERIC   |
| `Child_4`         | NUMERIC   |

### Table: `Service_Details`
| Column              | Data Type |
|---------------------|-----------|
| `Student_ID`         | VARCHAR(10) PRIMARY KEY |
| `Branch_of_Service`  | VARCHAR(50) |
| `Rank`               | VARCHAR(10) |
| `Functional_Branch`  | VARCHAR(50) |
| `Service_Component`  | VARCHAR(20) |
| `Commissioning_Source` | VARCHAR(50) |

---

## Example Queries

### 1. **View All Data from a Table**

Here’s an example of viewing all the data from the `Student_Grades` table using a simple `SELECT` statement:

```sql
SELECT * FROM Student_Grades;
```

This query retrieves all columns and rows from the `Student_Grades` table, providing an overview of the dataset.

---

## Interesting Queries

### 2. **JOIN Query**: Student GPA by Branch of Service and Graduation Date

This query performs a **JOIN** between `Student_Grades`, `Service_Details`, and `Student_Demographics` to calculate the average GPA by branch of service and graduation year.

```sql
SELECT 
    d.branch_of_service, 
    sd.Graduation_date,
    AVG(g."Final_Grade") AS Avg_GPA
FROM 
    Student_Grades g
JOIN 
    service_details d ON g.Student_id = d.Student_ID
JOIN
    Student_Demographics sd ON g.Student_id = sd.Student_ID
GROUP BY 
    d.branch_of_service, sd.Graduation_date
ORDER BY 
    sd.Graduation_date, Avg_GPA DESC;
```

### Explanation:
- **JOINs**: This query combines the `Student_Grades`, `Service_Details`, and `Student_Demographics` tables using `Student_ID` as the key.
- **GROUP BY**: The data is grouped by `branch_of_service` and `Graduation_date` to calculate the average GPA per branch and graduation date.
- **ORDER BY**: The results are ordered by `Graduation_date` and the average GPA in descending order.

---

### 3. **Aggregation Query**: Average GPA by Country and Graduation Year

This query aggregates the GPA data by country and graduation year, providing insights into student performance across different countries.

```sql
SELECT 
    d.Country, 
    EXTRACT(YEAR FROM d.Graduation_Date) AS Graduation_Year, 
    AVG(g."Final_Grade") AS Avg_GPA
FROM 
    Student_Grades g
JOIN 
    Student_Demographics d ON g.Student_id = d.Student_ID
GROUP BY 
    d.Country, Graduation_Year
ORDER BY 
    Graduation_Year, Avg_GPA DESC;
```

### Explanation:
- **Aggregation**: The query uses `AVG()` to calculate the average GPA per country and graduation year.
- **EXTRACT()**: This function extracts the year from the `Graduation_Date` column.
- **GROUP BY**: Data is grouped by `Country` and `Graduation_Year` to show average GPA for each group.

---

## How to Use
To replicate this project:
1. Clone the repository:
    ```bash
    git clone https://github.com/JBallgrass/NWMS_MOD7_final.git
    ```
2. Import the SQL scripts into pgAdmin or your preferred PostgreSQL environment.
3. Load the dataset and execute the provided SQL queries to generate insights.

---

## Future Work
- Integration with business intelligence tools such as Tableau or Power BI to create visual dashboards of student performance trends.
- Further data augmentation with additional features to simulate more advanced analytics and forecasting.

---

## Acknowledgments
This project was made possible using **Generative AI** for creating a realistic dataset and **pgAdmin** for database management and query execution.
```

### How to Use the `README.md`:
1. Copy this enhanced `README.md` content into your repository.
2. Commit the new file using the following PowerShell commands:

```bash
git add README.md
git commit -m "Updated README.md to include project details, queries, and explanations."
git push origin main
```

This `README.md` now contains all the details to explain your project clearly, including the data source, transformation steps, table structure, sample queries, and exciting analysis insights.

Feel free to let me know if you need further adjustments or explanations!
