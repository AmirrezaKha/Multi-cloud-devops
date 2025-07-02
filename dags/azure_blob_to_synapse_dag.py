from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from azure.storage.blob import BlobServiceClient
import pyodbc

def transfer_blob_to_synapse():
    blob_conn_str = "DefaultEndpointsProtocol=https;AccountName=...;AccountKey=...;EndpointSuffix=core.windows.net"
    blob_service = BlobServiceClient.from_connection_string(blob_conn_str)
    container = blob_service.get_container_client("my-container")
    blob = container.get_blob_client("data/my_data.csv")
    stream = blob.download_blob().readall().decode("utf-8")

    synapse_conn = pyodbc.connect(
        "Driver={ODBC Driver 17 for SQL Server};"
        "Server=tcp:synapse-server.database.windows.net,1433;"
        "Database=mydb;Uid=admin;Pwd=password;Encrypt=yes;"
    )
    cursor = synapse_conn.cursor()

    for line in stream.strip().split("\n")[1:]:
        values = line.split(",")
        cursor.execute("INSERT INTO dbo.my_table (col1, col2) VALUES (?, ?)", values)

    synapse_conn.commit()
    cursor.close()
    synapse_conn.close()

with DAG("azure_blob_to_synapse", start_date=datetime(2024, 1, 1), schedule_interval="@daily", catchup=False) as dag:
    transfer = PythonOperator(
        task_id="blob_to_synapse",
        python_callable=transfer_blob_to_synapse
    )
