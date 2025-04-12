E-Commerce ETL Pipeline + Power BI Dashboard
Overview
This project demonstrates an end-to-end ETL pipeline using Amazon S3, Amazon Redshift, and Power BI to analyze and visualize e-commerce sales data. The process includes data extraction from a CSV file stored in S3, data transformation in Redshift, and the final data visualization in Power BI.

Tech Stack:
AWS S3 – Cloud storage for raw CSV data storage.

Amazon Redshift – A fully managed data warehouse to process, analyze, and store data.

Power BI – A data visualization tool to create interactive and insightful dashboards.

AWS Setup
1. Amazon S3 Bucket Setup
Raw e-commerce sales data is stored in an Amazon S3 bucket named ecommerce-etl-bucket.

The data file is ecommercesalesanalysis.csv, which contains sales data from multiple months.

The COPY command is used to load the data from the S3 bucket directly into Redshift for processing.

2. Redshift Table Setup
Created a table in Amazon Redshift to store e-commerce sales data with the following SQL query:

sql
Copy
CREATE TABLE ecommerce_sales (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    review_score FLOAT,
    review_count INT,
    sales_month_1 INT,
    sales_month_2 INT,
    sales_month_3 INT,
    sales_month_4 INT,
    sales_month_5 INT,
    sales_month_6 INT,
    sales_month_7 INT,
    sales_month_8 INT,
    sales_month_9 INT,
    sales_month_10 INT,
    sales_month_11 INT,
    sales_month_12 INT
);
This Redshift table structure reflects the product-level sales data across 12 months of sales.

3. Data Loading into Redshift
Used the COPY command to load data from the S3 bucket into the ecommerce_sales table in Redshift:

sql
Copy
COPY ecommerce_sales
FROM 's3://ecommerce-etl-bucket/ecommercesalesanalysis.csv'
IAM_ROLE 'arn:aws:iam::420509932103:role/RedshiftS3AccessRole'
FORMAT AS CSV
IGNOREHEADER 1
REGION 'us-east-2';
The COPY command loads the CSV file from the S3 bucket and stores it in the Redshift table for transformation and analysis.

4. Redshift Data Transformation (View)
To analyze the total revenue for each product across the 12 months, a view was created in Redshift with the following SQL query:

sql
Copy
CREATE VIEW product_sales_summary AS
SELECT 
    product_id,
    product_name,
    category,
    price,
    review_score,
    review_count,
    (price * sales_month_1) AS revenue_month_1,
    (price * sales_month_2) AS revenue_month_2,
    (price * sales_month_3) AS revenue_month_3,
    (price * sales_month_4) AS revenue_month_4,
    (price * sales_month_5) AS revenue_month_5,
    (price * sales_month_6) AS revenue_month_6,
    (price * sales_month_7) AS revenue_month_7,
    (price * sales_month_8) AS revenue_month_8,
    (price * sales_month_9) AS revenue_month_9,
    (price * sales_month_10) AS revenue_month_10,
    (price * sales_month_11) AS revenue_month_11,
    (price * sales_month_12) AS revenue_month_12,
    (price * (
        sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 +
        sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 +
        sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12
    )) AS total_revenue
FROM ecommerce_sales;
This view aggregates the monthly revenue for each product and calculates the total revenue across all months.

Power BI Dashboard
The processed data from Redshift is visualized in Power BI. The dashboard includes:

KPI Cards for key metrics such as total revenue, average review score, and review count.

Bar Chart showing the top products by revenue.

Donut Chart for revenue distribution across different categories.

Scatter Plot to visualize the relationship between review score and total revenue.

How to Run This
Clone this repository.

Set up your AWS environment with S3 and Redshift (refer to AWS docs for setup).

Upload the CSV file into S3 and use the Redshift COPY command to load the data into Redshift.

Use Power BI to connect to Redshift and create the visualizations (as shown in the Power BI file).

Screenshots


✅ Step 2: Update Your GitHub Repo
Ensure that all files are updated:

README.md: Now includes the AWS setup, SQL code for Redshift, and Power BI dashboard details.

ETL_redshift_pipeline.sql: Contains the necessary SQL for table creation, data loading, and views.

dashboard-screenshot.png: The Power BI dashboard screenshot showing your visualizations.

Stage and Commit the Changes:

If you’ve added the updated README.md, make sure to stage, commit, and push your changes:

bash
Copy
git add .
git commit -m "Updated README.md with detailed AWS setup and added SQL file"
git push origin master
