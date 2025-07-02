from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import boto3
import psycopg2

def transfer_s3_to_redshift():
    # Read from S3 (via boto3)
    s3 = boto3.client('s3')
    bucket = 'my-aws-bucket'
    key = 'data/my_data.csv'

    obj = s3.get_object(Bucket=bucket, Key=key)
    content = obj['Body'].read().decode('utf-8')

    # Connect to Redshift and insert data
    conn = psycopg2.connect(
        host='redshift-host',
        port=5439,
        dbname='analytics',
        user='admin',
        password='secret'
    )
    cur = conn.cursor()

    for line in content.strip().split("\n")[1:]:  # Skip header
        values = line.split(",")
        cur.execute("INSERT INTO my_table (col1, col2) VALUES (%s, %s)", values)

    conn.commit()
    cur.close()
    conn.close()

with DAG("aws_s3_to_redshift", start_date=datetime(2024, 1, 1), schedule_interval="@daily", catchup=False) as dag:
    transfer = PythonOperator(
        task_id="s3_to_redshift",
        python_callable=transfer_s3_to_redshift
    )
