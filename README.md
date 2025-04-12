E-Commerce ETL Pipeline + Power BI Dashboard
Overview
This project demonstrates an end-to-end ETL pipeline using Amazon S3, Amazon Redshift, and Power BI to analyze and visualize e-commerce sales data. The workflow involves data extraction from a CSV file stored in S3, data transformation in Redshift, and the final data visualization in Power BI.

Tech Stack:
AWS S3: Cloud storage for raw CSV data

Amazon Redshift: Fully managed data warehouse to process, store, and analyze data

Power BI: Data visualization tool for creating interactive dashboards


AWS Setup
1. Amazon S3 Bucket Setup
Raw e-commerce sales data (ecommercesalesanalysis.csv) is stored in an S3 bucket called ecommerce-etl-bucket.

The data is loaded into Redshift using the COPY command.

2. Redshift Table Setup
The ecommerce_sales table was created in Redshift to store e-commerce sales data using the following SQL:
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
3. Data Loading into Redshift
The COPY command was used to load data from the S3 bucket into Redshift:
COPY ecommerce_sales
FROM 's3://ecommerce-etl-bucket/ecommercesalesanalysis.csv'
IAM_ROLE 'arn:aws:iam::420509932103:role/RedshiftS3AccessRole'
FORMAT AS CSV
IGNOREHEADER 1
REGION 'us-east-2';
This command extracts the data from S3 and loads it into the ecommerce_sales table in Redshift.

4. Redshift Data Transformation
A view was created in Redshift to calculate monthly and total revenue for each product:

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
    ...
    (price * (sales_month_1 + sales_month_2 + ...)) AS total_revenue
FROM ecommerce_sales;
Power BI Dashboard
The processed data from Redshift is visualized in Power BI. The dashboard includes:

KPI Cards for key metrics such as total revenue, average review score, and review count.

Bar Chart showing the top products by revenue.

Donut Chart for revenue distribution across different categories.

Scatter Plot to visualize the relationship between review score and total revenue.

How to Run This
Clone this repository to get the project files.

Set up your own AWS environment with S3 and Redshift (refer to the AWS documentation).

Upload the CSV file to S3 and use the COPY command to load the data into Redshift.

Use Power BI to connect to Redshift and create the visualizations (as shown in the Power BI file).

Screenshots


Final Thoughts
This project showcases the ability to use AWS for cloud-based data management (S3 and Redshift) and Power BI for creating meaningful visualizations. The pipeline takes raw data from S3, processes it in Redshift, and provides valuable insights through Power BI dashboards.
