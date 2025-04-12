🛒 E-Commerce ETL Pipeline + Power BI Dashboard
Project Overview
This project demonstrates an end-to-end ETL pipeline using Amazon S3, Amazon Redshift, and Power BI to analyze and visualize e-commerce sales data. The process involves:

Data Extraction from raw CSV files stored in Amazon S3

Data Transformation in Amazon Redshift using SQL queries

Data Visualization in Power BI for business insights

Tech Stack
Layer	Tool/Service
🧊 Storage	Amazon S3
🏢 Warehouse	Amazon Redshift
🛠️ Transformation	SQL in Redshift
📊 Dashboard	Power BI
📂 Versioning	Git + GitHub
Project Structure
bash
Copy
ecommerce-etl-powerbi-dashboard/
├── aws/                  
│   ├── redshift_queries/    
│   │   ├── create_table.sql      # SQL for Redshift Table Creation
│   │   ├── copy_data.sql         # SQL for COPY Command to Load Data
│   │   └── create_view.sql       # SQL for Creating Views in Redshift
│   ├── s3_bucket/               # S3 bucket configuration
│   └── README.md                # You’re here!
├── powerbi/                    
│   ├── ecommerce_dashboard.pbix   # Power BI Dashboard File
├── data/                        
│   ├── ecommercesalesanalysis.csv  # Raw Data in CSV Format
└── README.md                    # Project Documentation
ETL Pipeline Breakdown
1. Data Storage - Amazon S3
Raw e-commerce sales data is stored in an Amazon S3 bucket named ecommerce-etl-bucket.

The data file is ecommercesalesanalysis.csv.

The COPY command is used to load data from S3 into Redshift.

2. Data Transformation - Amazon Redshift
The following SQL creates the ecommerce_sales table in Redshift to store the data:

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
The COPY command to load data into Redshift from S3:

sql
Copy
COPY ecommerce_sales
FROM 's3://ecommerce-etl-bucket/ecommercesalesanalysis.csv'
IAM_ROLE 'arn:aws:iam::420509932103:role/RedshiftS3AccessRole'
FORMAT AS CSV
IGNOREHEADER 1
REGION 'us-east-2';
A view is created to calculate the total revenue for each product:

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
    ...
    (price * (sales_month_1 + sales_month_2 + ...)) AS total_revenue
FROM ecommerce_sales;
Power BI Dashboard
The processed data from Redshift is visualized in Power BI. The dashboard includes:

KPI Cards for total revenue, average review score, and review count

Bar Chart showing the top products by revenue

Donut Chart for revenue distribution across different categories

Scatter Plot to visualize the relationship between review score and total revenue

How to Run This
Clone the repository to get the project files.

Set up your AWS environment:

Create an S3 bucket and upload the CSV file.

Set up Redshift and create the necessary tables and views using the provided SQL files.

Power BI:

Connect Power BI to Redshift and load the data to create the dashboard.

You can use the ecommerce_dashboard.pbix file as a starting template.

Screenshots


Additional Features
Scalability: The pipeline can be extended to include more product attributes, additional sales data, or deeper insights.

Automation: This pipeline can be automated using AWS Lambda or other automation tools for regular data updates.

Final Thoughts
This project demonstrates how to leverage AWS for cloud-based data storage and processing (S3 & Redshift), combined with Power BI for interactive data visualizations. This end-to-end pipeline enables businesses to extract valuable insights from their e-commerce sales data.
