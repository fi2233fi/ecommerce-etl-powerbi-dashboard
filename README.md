# E-Commerce ETL Pipeline + Power BI Dashboard

## Overview

This project demonstrates an **end-to-end ETL pipeline** using **Amazon S3**, **Amazon Redshift**, and **Power BI** to analyze e-commerce sales data.

### Tech Stack:
- **AWS S3** – Cloud storage for raw CSV data
- **Amazon Redshift** – Data warehouse for processing and analyzing data
- **Power BI** – Visualization of e-commerce performance

---

## AWS Setup

### 1. **Amazon S3 Bucket Setup**
- Raw e-commerce data (`ecommercesalesanalysis.csv`) is stored in an **S3 bucket** called `ecommerce-etl-bucket`.
- Data is loaded into Redshift via the **COPY command**.

### 2. **Redshift Table Setup**
- Created a table in **Redshift** to store e-commerce sales data using the following SQL:

```sql
CREATE TABLE ecommerce_sales (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    review_score FLOAT,
    review_count INT,
    sales_month_1 INT,
    sales_month_2 INT,
    ...
    sales_month_12 INT
);


