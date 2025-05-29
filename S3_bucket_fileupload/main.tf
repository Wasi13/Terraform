provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_object" "failover_image" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "failover.PNG"
  source = var.local_file_path
  etag   = filemd5(var.local_file_path)
  content_type = "image/png"
}
