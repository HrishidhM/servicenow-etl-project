# ServiceNow Incident ETL Pipeline  
**Technologies:** PostgreSQL, DBT, Apache Airflow, Apache Superset, Docker  

This project demonstrates an end-to-end ETL pipeline for **ServiceNow Incident Ticket Analysis**.  
It includes ingestion, transformation, orchestration, automated testing, and interactive dashboarding.

---

## 🔄 Architecture Flow

CSV File (tickets.csv)
|
▼
PostgreSQL (Raw Schema)
|
▼
+------------------+
| DBT Models |
+------------------+
|
▼
Staging → Fact → Summary Models
|
▼
Apache Airflow
(Daily Automated Pipeline)
|
▼
Apache Superset Dashboard


---

## 🚀 Pipeline Overview

### **1️⃣ Data Ingestion (Airflow → PostgreSQL)**  
Airflow reads the `tickets.csv` and loads it into PostgreSQL under:

- Schema: `servicenow_raw`
- Table: `incidents_raw`

---

### **2️⃣ Data Transformation (DBT)**  
DBT models create:

#### **Staging Layer**
- Cleans raw data  
- Removes duplicates  
- Standardizes formats  
- Converts timestamps  
- Extracts Year, Month, Day  

#### **Fact Layer**
- Computes:  
  - Resolution time  
  - SLA breach flags  
  - Assignment histories  

#### **Summary Layer**
- Monthly ticket metrics  
- Average resolution time  
- Ticket closure rate  
- Category/Priority insights  

DBT tests included:  
✔ Not null  
✔ Unique key  
✔ Relationship checks  

---

### **3️⃣ Orchestration (Apache Airflow)**  
A single DAG performs:

1. Ingest CSV → PostgreSQL  
2. Run DBT models  
3. Run DBT tests  
4. Send status  

Schedule: **Daily (`@daily`)**

---

### **4️⃣ Dashboarding (Apache Superset)**  
Includes visualizations for:

- Monthly ticket trends  
- Resolution time analysis  
- Priority/category breakdowns  
- Assignment group performance  
- Ticket closure rate  

Dashboard is exported at:


---

## 🛠️ How to Run Locally

### **Prerequisites**
- Docker installed  
- Python 3.10+  
- DBT installed (`pip install dbt-postgres`)  

---

### **Step 1: Start Airflow**


Airflow UI:  
👉 http://localhost:8080/

---

### **Step 2: Run DBT Transformations**

Navigate to DBT folder:


---

## 🚫 Sensitive Files Not Included
For security reasons, the following are **not committed**:

- `profiles.yml`
- Raw full CSV data  
- Airflow logs  
- DBT target folders  

---

## ✨ Deliverables Checklist

- ✔ Airflow DAG  
- ✔ DBT Project (Staging → Fact → Summary Models)  
- ✔ DBT Tests  
- ✔ PostgreSQL schema design  
- ✔ Superset Dashboard Export  
- ✔ Full project hosted on GitHub  
- ✔ README with documentation  

---

 

---

