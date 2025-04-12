🛒 E-Commerce ETL Pipeline + Power BI Dashboard
Project Overview
This project demonstrates a complete end-to-end ETL pipeline using Amazon S3, Amazon Redshift, and Power BI to analyze and visualize e-commerce sales data. The process covers:

Data Extraction from raw CSV files stored in S3

Data Transformation in Redshift using SQL queries

Data Visualization in Power BI for business insights

Tech Stack
Layer	Tool/Service
🧊 Storage	Amazon S3
🏢 Warehouse	Amazon Redshift
🛠️ Transformation	SQL in Redshift
📊 Dashboard	Power BI
📂 Versioning	Git + GitHub
Project Structure
pgsql
Copy
ecommerce-etl-powerbi-dashboard/
├── aws/                
│   ├── redshift_queries/    
│   │   ├── create_table.sql        # Redshift Table Creation SQL
│   │   ├── copy_data.sql           # COPY Command to Load Data into Redshift
│   │   └── create_view.sql         # SQL to Create Views for Data Aggregation
│   ├── s3_bucket/                 # S3 bucket configuration
│   └── README.md                  # Project Documentation (You’re Here!)
├── powerbi/                       
│   ├── ecommerce_dashboard.pbix   # Power BI Dashboard File
├── data/                         
│   ├── ecommercesalesanalysis.csv  # Raw Data in CSV Format
└── README.md                      # Project Documentation
ETL Pipeline Breakdown
1. Data Storage - Amazon S3
Raw e-commerce sales data (ecommercesalesanalysis.csv) is stored in an Amazon S3 bucket named ecommerce-etl-bucket.

The COPY command is used to load the data into Amazon Redshift for further analysis.

2. Data Transformation - Amazon Redshift
Data is processed in Redshift using SQL queries. A table is created to store product-level sales data:

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
    ...
    sales_month_12 INT
);
The COPY command loads the raw data from S3 into Redshift:

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
The data processed in Redshift is visualized in Power BI. The dashboard includes:

KPI Cards for total revenue, average review score, and review count

Bar Chart showing the top products by revenue

Donut Chart for revenue distribution across different categories

Scatter Plot to visualize the relationship between review score and total revenue

How to Run This
Clone the repository.

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
This project demonstrates the ability to use AWS for cloud-based data storage and processing (S3 & Redshift), along with Power BI for data visualization, enabling businesses to gain valuable insights from e-commerce sales data.
