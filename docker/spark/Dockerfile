FROM bitnami/spark:3.5
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY job.py /app/job.py


CMD ["/opt/bitnami/spark/bin/spark-submit", "/app/job.py"]
