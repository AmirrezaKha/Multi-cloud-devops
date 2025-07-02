from kafka import KafkaConsumer

consumer = KafkaConsumer('my-topic', bootstrap_servers='kafka:9092')
for msg in consumer:
    print(f"Received: {msg.value.decode()}")
