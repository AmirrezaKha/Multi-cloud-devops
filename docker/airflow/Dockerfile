FROM apache/airflow:2.9.0-python3.9

COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt

COPY ../../dags/ /opt/airflow/dags/
COPY plugins/ /opt/airflow/plugins/
