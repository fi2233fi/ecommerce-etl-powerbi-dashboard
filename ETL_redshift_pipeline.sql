-- 1. Create the Redshift table
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

-- 2. Load data from S3 into Redshift
COPY ecommerce_sales
FROM 's3://ecommerce-etl-bucket/ecommercesalesanalysis.csv'
IAM_ROLE 'arn:aws:iam::420509932103:role/RedshiftS3AccessRole'
FORMAT AS CSV
IGNOREHEADER 1
REGION 'us-east-2';

-- 3. Create a view for total revenue calculation
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
    (price * sales_month-- 1. Create the Redshift table
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

-- 2. Load data from S3 into Redshift
COPY ecommerce_sales
FROM 's3://ecommerce-etl-bucket/ecommercesalesanalysis.csv'
IAM_ROLE 'arn:aws:iam::420509932103:role/RedshiftS3AccessRole'
FORMAT AS CSV
IGNOREHEADER 1
REGION 'us-east-2';

-- 3. Create a view for total revenue calculation
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

