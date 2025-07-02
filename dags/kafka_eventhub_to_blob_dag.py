from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
from azure.eventhub import EventHubConsumerClient
from azure.storage.blob import BlobServiceClient

def consume_eventhub_to_blob():
    blob_service = BlobServiceClient.from_connection_string("AZURE_BLOB_CONNECTION_STRING")
    blob_client = blob_service.get_blob_client(container="my-container", blob="kafka/messages.txt")

    received = []

    def on_event(partition_context, event):
        received.append(event.body_as_str())
        if len(received) >= 100:
            partition_context.update_checkpoint(event)

    client = EventHubConsumerClient.from_connection_string(
        "AZURE_EVENTHUB_CONNECTION_STRING",
        consumer_group="$Default",
        eventhub_name="myeventhub"
    )

    with client:
        client.receive(on_event=on_event, starting_position="-1", max_wait_time=5)

    blob_client.upload_blob("\n".join(received), overwrite=True)

with DAG("eventhub_to_blob", start_date=datetime(2024, 1, 1), schedule_interval="@hourly", catchup=False) as dag:
    task = PythonOperator(
        task_id="consume_eventhub_to_blob",
        python_callable=consume_eventhub_to_blob
    )
