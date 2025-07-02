from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("ExampleJob").getOrCreate()
df = spark.read.json("s3a://your-bucket/data.json")
df.show()
