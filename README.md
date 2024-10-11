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

