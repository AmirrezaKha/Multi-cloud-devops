from airflow import DAG
from airflow.operators.python import PythonOperator
from kafka import KafkaConsumer
import boto3
from datetime import datetime

def consume_and_store_to_s3():
    consumer = KafkaConsumer('aws_topic', bootstrap_servers='b-1.mskcluster.amazonaws.com:9092')
    s3 = boto3.client('s3')

    lines = []
    for message in consumer:
        lines.append(message.value.decode('utf-8'))
        if len(lines) >= 100:
            break

    s3.put_object(
        Bucket='my-aws-bucket',
        Key='kafka-data/messages.txt',
        Body="\n".join(lines)
    )

with DAG("kafka_aws_to_s3", start_date=datetime(2024, 1, 1), schedule_interval="@hourly", catchup=False) as dag:
    task = PythonOperator(
        task_id="consume_kafka_to_s3",
        python_callable=consume_and_store_to_s3
    )
