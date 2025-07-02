# main.tf
resource "aws_s3_bucket" "data_lake" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = var.tags
}